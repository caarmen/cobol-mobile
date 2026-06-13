import SwiftUI

struct ContentView: View {
    // 🔄 Mirroring: var greetingText by remember { mutableStateOf(...) }
    @State private var greetingText: String = "Click the button to find out..."

    var body: some View {
        // 🧱 Mirroring: Column(modifier = Modifier.padding(16.dp))
        VStack(alignment: .leading, spacing: 0) {
            
            // 🏷️ Calling the custom subview (Greeting component)
            Greeting(name: greetingText)
            
            // 📐 Mirroring: Spacer(modifier = Modifier.height(16.dp))
            Spacer().frame(height: 16)
            
            // 🎛️ Mirroring: Button(onClick = { ... }) { Text("Ask COBOL") }
            Button(action: {
                // Fetch from COBOL
                let answer = answerToLife()
                
                // Update state string
                greetingText = "\(answer)"
            }) {
                Text("Ask COBOL")
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(4) // Minimal look mirroring basic Material 3 Android buttons
            }
        }
        .padding(16) // Content padding matching your outer Android column
    }
}

// 🎨 Mirroring: @Composable fun Greeting(name: String)
struct Greeting: View {
    let name: String
    
    var body: some View {
        Text("The answer to life, from COBOL, is: \(name)!")
    }
}
