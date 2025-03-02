import SwiftUI

struct RecyclingFactsView: View {
    let facts = [
        "♻️ Recycling one aluminum can saves enough energy to run a TV for 3 hours.",
        "🌿 Glass can be recycled indefinitely without losing quality.",
        "📄 Paper recycling saves trees, water, and energy!",
        "🚯 Plastic takes hundreds of years to decompose in landfills.",
        "🌱 Composting organic waste reduces methane emissions from landfills."
    ]
    
    let colorInfo = [
        "🟢 Green – Recyclable Waste (Paper, Cardboard, Glass)",
        "🔵 Blue – Plastic Waste (Bottles, Packaging, Containers)",
        "⚫ Black – Non-Recyclable Waste (Food Wrappers, Used Tissues)",
        "🟡 Yellow – Hazardous Waste (Batteries, Electronics, Paint Cans)",
        "🟤 Brown – Organic Waste (Food Scraps, Garden Waste)"
    ]

    @State private var currentFact: String = ""
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Did You Know?")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top, 20)

            VStack(spacing: 15) {
                Text(currentFact)
                    .font(.title2)
                    .padding()
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity)
                    .background(Color(UIColor.systemGray6))
                    .cornerRadius(12)
                    .shadow(radius: 2)
                
                Button(action: {
                    currentFact = facts.randomElement() ?? "Recycling is important!"
                }) {
                    Text("Show Another Fact")
                        .font(.title2.bold())
                        .padding()
                        .background(Color.green)
                        .cornerRadius(10)
                        .foregroundColor(.white)
                }
                .padding(.horizontal, 40)
            }
            
            Divider().padding(.horizontal, 20)
            
            Text("♻️ **Recycling Bin Color Codes**")
                .font(.headline)
                .padding(.top, 10)
            
            VStack(alignment: .leading, spacing: 10) {
                ForEach(colorInfo, id: \.self) { info in
                    Text(info)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(8)
                        .background(Color(UIColor.systemGray6))
                        .cornerRadius(8)
                        .shadow(radius: 1)
                }
            }
            .padding(.horizontal, 20)

            Spacer()
        }
        .padding()
        .onAppear {
            currentFact = facts.randomElement() ?? "Recycling is important!"
        }
    }
}
