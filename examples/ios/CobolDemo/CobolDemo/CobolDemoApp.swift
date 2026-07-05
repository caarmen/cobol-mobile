//
//  CobolDemoApp.swift
//  CobolDemo
//
//  Created by Carmen Alvarez on 13/06/2026.
//

import SwiftUI
import GnuCOBOL

@main
struct CobolDemoApp: App {
    init() {
        GnuCOBOL.initialize()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
