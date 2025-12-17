//
//  Groceny_AppApp.swift
//  Groceny_App
//
//  Created by students on 17/12/25.
//

import SwiftUI
import SwiftData

@main
struct Groceny_AppApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: Listt.self)
        }
    }
}
