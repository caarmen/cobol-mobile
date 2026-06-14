//
//  CobolDemoApp.swift
//  CobolDemo
//
//  Created by Carmen Alvarez on 13/06/2026.
//

import SwiftUI

@main
struct CobolDemoApp: App {
    init() {
        cob_init(0, nil)
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
