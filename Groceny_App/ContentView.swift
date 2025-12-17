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
    
    @State private var title: String = ""
    @State private var isAlertShowing: Bool = false
    
    @Query private var lists: [Listt]
    
    var body: some View {
        NavigationStack {
            List{
                ForEach(lists)
                {
                    list in
                    Text(list.title)
                        .font(.title2)
                        .fontWeight(.light)
                        .padding(.vertical,2)
                    
                    
                }
            }
            .navigationTitle("Grocery List")
            .toolbar{
                            ToolbarItem(placement:.topBarTrailing){
                                Button{
                                    isAlertShowing.toggle()
                                } label: {
                                    Image(systemName: "carrot")
                                        .imageScale(.large)
                                }
                            }
                        }
            
            .overlay{
                           if lists.isEmpty{
                               ContentUnavailableView("Empty Cart",
                                                      
                                                      systemImage:"cart.circle",description: Text("Add some shopping items"))
                           }
                       }
        }
    }
}

#Preview("Second List") {
    do{
        let container = try!
        ModelContainer(for: Listt.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        
        let ctx = container.mainContext
        ctx.insert(Listt(title: "Swift Coding Club", isCompleted: true))
        ctx.insert(Listt(title: "Laundary", isCompleted: true))
        ctx.insert(Listt(title: "Homework", isCompleted: true))
        
        return ContentView()
            .modelContainer(container)
    }
}
#Preview {
    ContentView()
        .modelContainer(for: Listt.self , inMemory: true)
}
