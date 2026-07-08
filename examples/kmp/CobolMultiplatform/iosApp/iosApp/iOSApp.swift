import SwiftUI
import GnuCOBOL

@main
struct iOSApp: App {
	init() {
		GnuCOBOL.initialize()
	}
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
