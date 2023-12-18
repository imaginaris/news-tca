import ComposableArchitecture

@Reducer
struct LatestNewsReducer {
    struct State: Equatable {
        var sourceID: String?
        var list = IdentifiedArrayOf<NewsArticle>()
        var isLoading = false
        var isErrorPresented = false
        @PresentationState var presentedAlert: AlertState<Action.Alert>?
        var path = StackState<NewsDetailReducer.State>()
    }

    enum Action: Equatable {
        enum Alert {
            case cancelTapped
        }

        case viewDidAppear
        case apiResponse(IdentifiedArrayOf<NewsArticle>)
        case showError(String)
        case alert(PresentationAction<Alert>)
        case didClickSave(NewsArticle)
        case path(StackAction<NewsDetailReducer.State, NewsDetailReducer.Action>)
    }

    private enum CancelID {
        case fetchRequest
    }

    @Dependency(\.apiService) var apiService
    @Dependency(\.favoriteManager) var favoriteManager

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {

            case let .apiResponse(articles):
                state.list = articles
                state.isLoading = false
                return .none

            case let .showError(message):
                state.presentedAlert = AlertState(title: TextState(message))
                return .none

            case let .didClickSave(article):
                return .run { send in
                    do {
                        try favoriteManager.saveArticle(article)
                    } catch let error {
                        await send(.showError(error.localizedDescription))
                    }
                }
                
            case .alert(.presented(.cancelTapped)):
                state.presentedAlert = nil
                return .none

            case .viewDidAppear:
                guard state.list.isEmpty else {
                    return .none
                }
                state.isLoading = true
                let sourceID = state.sourceID
                return .run { send in
                    do {
                        let listData = if let sourceID {
                            try await apiService.fetchNewsFromSource(sourceID)
                        } else {
                            try await apiService.fetchGeneralNews()
                        }
                        await send(.apiResponse(IdentifiedArrayOf(uniqueElements: listData)))
                    } catch let error {
                        await send(.showError(error.localizedDescription))
                    }
                }
                .cancellable(id: CancelID.fetchRequest, cancelInFlight: true)

            case .path:
                return .none

            case .alert(.dismiss):
                return .none
            }
        }
        .ifLet(\.$presentedAlert, action: \.alert)
        .forEach(\.path, action: \.path) {
            NewsDetailReducer()
        }
    }
}
