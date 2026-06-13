import SwiftUI

struct ContentView: View {
    @State private var greetingText: String = "Click the button to find out..."

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            
            Greeting(name: greetingText)
            
            Spacer().frame(height: 16)
            
            Button(action: {
                // Fetch from COBOL
                let answer = answerToLife()
                
                greetingText = "\(answer)"
            }) {
                Text("Ask COBOL")
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(4)
            }
        }
        .padding(16)
    }
}

struct Greeting: View {
    let name: String
    
    var body: some View {
        Text("The answer to life, from COBOL, is: \(name)!")
    }
}
