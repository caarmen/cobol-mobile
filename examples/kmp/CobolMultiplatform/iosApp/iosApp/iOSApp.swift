import SwiftUI

@main
struct iOSApp: App {
	init() {
		cob_init(0, nil)
	}
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
