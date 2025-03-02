import SwiftUI

struct PredefinedCategoriesView: View {
    let categories = [
        ("Plastic", "bag.fill"),
        ("Glass", "wineglass.fill"),
        ("Metal", "hammer.fill"),
        ("Paper", "doc.fill"),
        ("Electronics", "battery.100"),
        ("Organic", "leaf.fill"),
        ("Wood", "tree.fill"),
        ("Clothing", "tshirt.fill"),
        ("Hazardous", "exclamationmark.triangle.fill"),
        ("Miscellaneous", "cube.box.fill")
    ]

    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    Text("Select a Category")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.top, 10)

                    LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 20) {
                        ForEach(categories, id: \.0) { category in
                            NavigationLink(destination: CategoryItemsView(category: category.0)) {
                                VStack {
                                    Image(systemName: category.1)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 50, height: 50)
                                        .foregroundColor(.blue)

                                    Text(category.0)
                                        .font(.headline)
                                        .foregroundColor(.black)
                                }
                                .frame(width: 140, height: 140)
                                .background(Color.white)
                                .cornerRadius(20)
                                .shadow(color: Color.gray.opacity(0.2), radius: 10, x: 0, y: 5)
                            }
                        }
                    }
                    .padding()
                }
                .padding(.bottom, 30)
            }
        }
    }
}
