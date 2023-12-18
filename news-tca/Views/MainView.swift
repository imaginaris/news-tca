import SwiftUI
import ComposableArchitecture

struct MainView: View {
    let latestNewsStore = Store(initialState: LatestNewsReducer.State()) {
        LatestNewsReducer()
    }
    let savedNewsStore = Store(initialState: SavedNewsReducer.State()) {
        SavedNewsReducer()
    }
    let sourcesStore = Store(initialState: SourcesReducer.State()) {
        SourcesReducer()
    }

    var body: some View {
        TabView {
            LatestNewsView(store: latestNewsStore)
                .tabItem {
                    Label("tabbar.news", systemImage: "newspaper")
                }
            SavedNewsView(store: savedNewsStore)
                .tabItem {
                    Label("tabbar.saved", systemImage: "archivebox")
                }
            SourcesView(store: sourcesStore)
                .tabItem {
                    Label("tabbar.sources", systemImage: "dot.radiowaves.up.forward")
                }
        }
    }
}

#Preview {
    MainView()
}
