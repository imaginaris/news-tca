import SwiftUI
import ComposableArchitecture

struct SavedNewsView: View {
    let store: StoreOf<SavedNewsReducer>

    @State private var isErrorPresented = false

    var body: some View {
        NavigationStack {
            WithViewStore(store, observe: \.list) { viewStore in
                List {
                    ForEach(viewStore.state) { article in
                        NewsCellView(article: article)
                        .swipeActions {
                            Button("generic.button.delete") {
                                store.send(.didClickDelete(article))
                            }
                            .tint(.red)
                        }
                    }
                }
                .listStyle(.plain)
                .onAppear(perform: {
                    viewStore.send(.viewDidAppear)
                })
            }
            .navigationTitle("savedNews.title")
            .alert(store: store.scope(
                state: \.$alert,
                action: \.alert
            ))
        }
    }
}

#Preview {
    SavedNewsView(store: Store(initialState: SavedNewsReducer.State()) {
        SavedNewsReducer()
    })
}
