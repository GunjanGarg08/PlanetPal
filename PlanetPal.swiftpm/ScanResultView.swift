
import SwiftUI

struct ScanResultView: View {
    var searchType: String
    var itemImage: UIImage?
    var itemName: String
    var category: String?
    var colourCode: String?
    var dustbinColor: String?
    var recyclingMethod: String?

    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        ZStack {
            // Background Changes Based on Search Type
            LinearGradient(gradient: Gradient(colors: [Color.white, Color.gray.opacity(0.1)]),
                           startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)

            VStack(spacing: 20) {
                // Scan Result Heading
                VStack {
                    Image(systemName: "checkmark.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                        .foregroundColor(.green)

                    Text("Scan Result")
                        .font(.system(size: 30, weight: .bold, design: .rounded))
                        .foregroundColor(.black.opacity(0.8))
                }

                // Show Item Details
                VStack(alignment: .leading, spacing: 10) {
                    scanResultRow(icon: "tag.fill", title: "Item Name", value: itemName, color: .blue)
                    scanResultRow(icon: "square.stack.3d.up.fill", title: "Category", value: category ?? "Unknown", color: .green)
                    scanResultRow(icon: "paintpalette.fill", title: "Colour Code", value: colourCode ?? "N/A", color: .orange)
                    scanResultRow(icon: "trash.fill", title: "Dustbin Color", value: dustbinColor ?? "N/A", color: .red)
                    scanResultRow(icon: "arrow.triangle.2.circlepath.circle.fill", title: "Recycling Method", value: recyclingMethod ?? "N/A", color: .purple)
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.white.opacity(0.95))
                .cornerRadius(15)
                .shadow(radius: 5)
                .padding(.horizontal)

                Spacer()

                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    HStack {
                        Image(systemName: "arrow.left.circle.fill")
                        Text("Go Back")
                    }
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(12)
                    .shadow(radius: 5)
                    .padding(.horizontal)
                }
            }
            .padding(.top, 20)
        }
        .navigationBarBackButtonHidden(true)
    }

    func scanResultRow(icon: String, title: String, value: String, color: Color) -> some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(color)
                .font(.title3)
                .frame(width: 30)
            Text("**\(title):** \(value)")
                .foregroundColor(.black.opacity(0.8))
                .font(.body)
        }
    }
}
