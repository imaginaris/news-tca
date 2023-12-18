import SwiftUI
import ComposableArchitecture

struct LatestNewsView: View {
    let store: StoreOf<LatestNewsReducer>

    @State private var isErrorPresented = false

    var body: some View {
        NavigationStackStore(self.store.scope(state: \.path, action: \.path)) {
            WithViewStore(store, observe: { $0 }) { viewStore in
                List {
                    ForEach(viewStore.state.list) { article in
                        NavigationLink(state: NewsDetailReducer.State(article: article)) {
                            NewsCellView(article: article)
                            .swipeActions {
                                Button("", systemImage: "star") {
                                    store.send(.didClickSave(article))
                                }
                                .tint(.orange)
                            }
                        }
                        .buttonStyle(.borderless)
                    }
                }
                .listStyle(.plain)
                .onAppear(perform: {
                    viewStore.send(.viewDidAppear)
                })
                .overlay {
                    if viewStore.state.isLoading {
                        ProgressView()
                            .controlSize(.large)
                    }
                }
            }
            .navigationTitle("latestNews.title")
            .alert(store: store.scope(
                state: \.$presentedAlert,
                action: \.alert
            ))
        } destination: { store in
            NewsDetailView(store: store)
        }
    }
}

#Preview {
    LatestNewsView(store: Store(initialState: LatestNewsReducer.State()) {
        LatestNewsReducer()
    })
}
