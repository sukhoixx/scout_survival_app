import SwiftUI

@main
struct ScoutSurvivalApp: App {
    @StateObject private var dataStore = SurvivalDataStore()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(dataStore)
        }
    }
}
