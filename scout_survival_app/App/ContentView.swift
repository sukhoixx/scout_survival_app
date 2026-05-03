import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            BrowseView()
                .tabItem {
                    Label("Browse", systemImage: "book.fill")
                }

            SearchView()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }

            FirstAidView()
                .tabItem {
                    Label("First Aid", systemImage: "cross.case.fill")
                }

            AssessmentView()
                .tabItem {
                    Label("Assess", systemImage: "stethoscope")
                }

            PackingView()
                .tabItem {
                    Label("Pack", systemImage: "backpack.fill")
                }
        }
        .accentColor(.green)
    }
}
