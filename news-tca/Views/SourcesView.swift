import SwiftUI
import ComposableArchitecture

struct SourcesView: View {
    let store: StoreOf<SourcesReducer>

    @State private var isErrorPresented = false

    var body: some View {
        NavigationStack {
            WithViewStore(store, observe: { $0 }) { viewStore in
                List {
                    ForEach(viewStore.state.list) { source in
                        VStack(alignment: .leading) {
                            Text(source.name)
                                .font(.headline)
                            if let description = source.description {
                                Text(description)
                            }
                            if let url = source.url {
                                Text(url)
                                    .foregroundStyle(.blue)
                            }
                        }.onTapGesture {
                            viewStore.send(.didSelectSource(source.id))
                        }
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
            .navigationTitle("sources.title")
            .alert(store: store.scope(
                state: \.$alert,
                action: \.alert
            ))
            .sheet(
                store: store.scope(
                    state: \.$newsList,
                    action: \.showNewsList
                )
            ) { store in
                NavigationStack {
                    LatestNewsView(store: store)
                        .toolbar {
                            ToolbarItem {
                                Button("generic.button.close") {
                                    self.store.send(.newsListCloseTapped)
                                }
                            }
                        }
                }
            }
        }
    }
}

#Preview {
    SourcesView(store: Store(initialState: SourcesReducer.State()) {
        SourcesReducer()
    })
}
