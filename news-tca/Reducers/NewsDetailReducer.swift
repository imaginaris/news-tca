import ComposableArchitecture

@Reducer
struct NewsDetailReducer {
    struct State: Equatable {
        let article: NewsArticle
    }

    enum Action: Equatable {
        case viewDidAppear
    }

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {

            case .viewDidAppear:
                return .none
            }
        }
    }
}
