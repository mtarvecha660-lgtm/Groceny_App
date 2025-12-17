//
//  ContentView.swift
//  Groceny_App
//
//  Created by students on 17/12/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    @Environment(\.modelContext)
    private var modelContext
    
    
    @Query private var lists: [Listt]
    
    var body: some View {
        VStack {
            
        }
    }
}
#Preview {
    ContentView()
}
