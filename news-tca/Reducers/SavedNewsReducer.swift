import ComposableArchitecture

@Reducer
struct SavedNewsReducer {
    struct State {
        var list = IdentifiedArrayOf<NewsArticle>()
        @PresentationState var alert: AlertState<Action.Alert>?
        var isErrorPresented = false
    }

    enum Action: Equatable {
        enum Alert {
            case cancelTapped
        }

        case viewDidAppear
        case showError(String)
        case alert(PresentationAction<Alert>)
        case didClickDelete(NewsArticle)
        case didRemove(NewsArticle)
    }

    @Dependency(\.favoriteManager) var favoriteManager

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {

            case let .showError(message):
                state.alert = AlertState(title: TextState(message))
                return .none

            case let .didClickDelete(article):
                return .run { send in
                    do {
                        try favoriteManager.deleteArticle(article)
                        await send(.didRemove(article))
                    } catch let error {
                        await send(.showError(error.localizedDescription))
                    }
                }

            case let .didRemove(article):
                state.list.remove(article)
                return .none

            case .alert(.presented(.cancelTapped)):
                state.alert = nil
                return .none

            case .viewDidAppear:
                state.list = favoriteManager.getArticles()
                return .none

            case .alert(.dismiss):
                return .none
            }
        }
        .ifLet(\.$alert, action: \.alert)
    }
}
