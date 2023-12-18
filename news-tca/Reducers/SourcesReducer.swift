import ComposableArchitecture

@Reducer
struct SourcesReducer {
    struct State: Equatable {
        var list = IdentifiedArrayOf<Source>()
        var isLoading = false
        var isErrorPresented = false
        @PresentationState var alert: AlertState<Action.Alert>?
        @PresentationState var newsList: LatestNewsReducer.State?
    }

    enum Action: Equatable {
        enum Alert {
            case cancelTapped
        }

        case viewDidAppear
        case apiResponse(IdentifiedArrayOf<Source>)
        case showError(String)
        case alert(PresentationAction<Alert>)
        case didSelectSource(String?)
        case showNewsList(PresentationAction<LatestNewsReducer.Action>)
        case newsListCloseTapped
    }

    private enum CancelID {
        case fetchRequest
    }

    @Dependency(\.apiService) var apiService

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {

            case let .apiResponse(articles):
                state.list = articles
                state.isLoading = false
                return .none

            case let .showError(message):
                state.alert = AlertState(title: TextState(message))
                return .none
                
            case .alert(.presented(.cancelTapped)):
                state.alert = nil
                return .none

            case .viewDidAppear:
                guard state.list.isEmpty else {
                    return .none
                }
                state.isLoading = true
                return .run { send in
                    do {
                        let listData = try await apiService.fetchSources()
                        await send(.apiResponse(IdentifiedArrayOf(uniqueElements: listData)))
                    } catch let error {
                        await send(.showError(error.localizedDescription))
                    }
                }
                .cancellable(id: CancelID.fetchRequest, cancelInFlight: true)

            case let .didSelectSource(sourceID):
                guard let sourceID else {
                    return .none
                }
                state.newsList = LatestNewsReducer.State(sourceID: sourceID)
                return .none

            case .newsListCloseTapped:
                state.newsList = nil
                return .none

            case .showNewsList:
                return .none

            case .alert(.dismiss):
                return .none
            }
        }
        .ifLet(\.$alert, action: \.alert)
        .ifLet(\.$newsList, action: \.showNewsList) {
            LatestNewsReducer()
        }
    }
}
