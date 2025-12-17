import SwiftUI
import SwiftData

struct ContentView: View {
    
    @Environment(\.modelContext) private var modelContext
    
    @State private var title: String = ""
    @State private var isAlertShowing: Bool = false
    
    @Query private var lists: [Listt]
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(lists) { list in
                    Text(list.title)
                        .foregroundStyle(list.isCompleted == false ? Color.primary : Color.accentColor)
                        .strikethrough(list.isCompleted)
                        .italic(list.isCompleted)
                        .swipeActions{
                            Button(role: .destructive){
                                withAnimation{modelContext.delete(list)}
                            }
                            label:{
                                Label("Delete", systemImage: "trash")
                            }
                        }
                        .swipeActions(edge: .leading){
                            Button("Done", systemImage: list.isCompleted == false ? "checkmark" : "x.fill"){
                                list.isCompleted.toggle()
                            }
                            .tint(list.isCompleted == false ? .green : .accentColor)
                        }
                }
            }
            .navigationTitle("Grocery List")
            .toolbar {
                if lists.isEmpty {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            isAlertShowing.toggle()
                        } label: {
                            Image(systemName: "carrot")
                                .imageScale(.large)
                        }
                    }
                }
            }
            .overlay {
                if lists.isEmpty {
                    ContentUnavailableView(
                        "Empty Cart",
                        systemImage: "cart.circle",
                        description: Text("Add some shopping items")
                    )
                }
            }
        }
    }
}
#Preview("Second List") {
    do {
        let container = try ModelContainer(
            for: Listt.self,
            configurations: ModelConfiguration(isStoredInMemoryOnly: true)
        )
        
        let ctx = container.mainContext
        ctx.insert(Listt(title: "Swift Coding Club", isCompleted: true))
        ctx.insert(Listt(title: "Laundary", isCompleted: true))
        ctx.insert(Listt(title: "Homework", isCompleted: true))
        
        return ContentView()
            .modelContainer(container)
    } catch {
        fatalError("Failed to create model container")
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Listt.self, inMemory: true)
}
