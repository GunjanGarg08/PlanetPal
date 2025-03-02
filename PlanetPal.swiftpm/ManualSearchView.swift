import SwiftUI

struct ManualSearchView: View {
    @State private var searchText: String = ""
    @State private var showResults = false
    @State private var noResults = false
    @State private var selectedItem: (name: String, category: String, colourCode: String, dustbinColor: String, recyclingMethod: String)?

    let itemDatabase: [String: (category: String, colourCode: String, dustbinColor: String, recyclingMethod: String)] = [
        // Plastic Items
        "plastic bottle": ("Plastic", "Blue", "Green", "Clean and Recycle"),
        "plastic bag": ("Plastic", "Blue", "Black", "Not Recyclable"),
        "plastic straw": ("Plastic", "Blue", "Black", "Not Recyclable"),
        "disposable cups": ("Plastic", "Blue", "Black", "Not Recyclable"),
        "milk jug": ("Plastic", "Blue", "Green", "Rinse and Recycle"),
        "yogurt container": ("Plastic", "Blue", "Green", "Check Local Recycling"),

        // Glass Items
        "glass jar": ("Glass", "Green", "Blue", "Reuse or Recycle"),
        "wine bottle": ("Glass", "Green", "Blue", "Recycle"),
        "glass plate": ("Glass", "Green", "Blue", "Recycle"),
        "mirror": ("Glass", "Gray", "Special", "Not Recyclable"),
        "light bulb": ("Glass", "Red", "Special", "Hazardous Waste"),
        
        // Metal Items
        "aluminum can": ("Metal", "Silver", "Blue", "Crush and Recycle"),
        "tin can": ("Metal", "Gray", "Blue", "Rinse and Recycle"),
        "steel spoon": ("Metal", "Silver", "Blue", "Reuse or Recycle"),
        "iron nail": ("Metal", "Gray", "Blue", "Scrap Metal"),
        "soda can": ("Metal", "Silver", "Blue", "Crush and Recycle"),
        "aluminum foil": ("Metal", "Silver", "Blue", "Recycle if Clean"),
        "metal coat hanger": ("Metal", "Gray", "Blue", "Scrap Metal Recycling"),

        // Paper Items
        "paper bag": ("Paper", "Brown", "Blue", "Recycle"),
        "newspaper": ("Paper", "Gray", "Blue", "Recycle"),
        "cardboard box": ("Paper", "Brown", "Blue", "Flatten and Recycle"),
        "paper towel": ("Paper", "White", "Green", "Compost"),
        "magazine": ("Paper", "Gray", "Blue", "Recycle"),
        "cereal box": ("Paper", "Brown", "Blue", "Flatten and Recycle"),
        "receipt": ("Paper", "White", "Trash", "Not Recyclable"),
        
        // Electronics
        "battery": ("Electronics", "Red", "Special", "Dispose at E-Waste Center"),
        "phone charger": ("Electronics", "Red", "E-Waste", "E-Waste Disposal"),
        "earphones": ("Electronics", "Red", "E-Waste", "Dispose Properly"),
        "laptop": ("Electronics", "Black", "E-Waste", "Take to E-Waste Facility"),
        "remote control": ("Electronics", "Red", "E-Waste", "Remove Batteries First"),
        "tablet": ("Electronics", "Black", "E-Waste", "Recycle at Electronics Store"),

        // Organic Waste
        "food waste": ("Organic", "Brown", "Green", "Compost"),
        "vegetable waste": ("Organic", "Brown", "Green", "Compost"),
        "fruit peel": ("Organic", "Yellow", "Green", "Compost"),
        "tea bags": ("Organic", "Brown", "Green", "Compost"),
        "coffee grounds": ("Organic", "Brown", "Green", "Compost"),
        "compostable cutlery": ("Organic", "Brown", "Green", "Compost"),
        
        // Miscellaneous Items
        "wooden spoon": ("Wood", "Brown", "Green", "Compost"),
        "toothbrush": ("Plastic", "Blue", "Trash", "Not Recyclable"),
        "clothing": ("Textile", "Varied", "Donation", "Donate or Upcycle"),
        "shoes": ("Textile", "Varied", "Donation", "Donate or Upcycle"),
        "pill bottle": ("Plastic", "White", "Special", "Check Local Recycling"),
        "paint can": ("Hazardous", "Red", "Special", "Hazardous Waste Disposal"),
        "cigarette butt": ("Trash", "Black", "Landfill", "Not Recyclable"),
        "diaper": ("Trash", "Black", "Landfill", "Not Recyclable"),
        "plastic wrap": ("Plastic", "Blue", "Black", "Not Recyclable")
    ]

    var filteredSuggestions: [String] {
        guard !searchText.isEmpty else { return [] }
        return itemDatabase.keys.filter { $0.contains(searchText.lowercased()) }
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 10) {
                // Custom Back Button & Title
                HStack {
                    Spacer()
                    Text("Manual Search")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Spacer()
                }
                .padding(.horizontal)

                HStack {
                    TextField("Search for an item...", text: $searchText)
                        .padding(12)
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
                        .onSubmit {
                            processSearch()
                        }

                    Button(action: {
                        processSearch()
                    }) {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.blue)
                            .padding()
                            .background(Color.white)
                            .clipShape(Circle())
                            .shadow(radius: 3)
                    }
                }
                .padding(.horizontal)

                // ===== ADDED THIS BLOCK BELOW FOR DEFAULT SUGGESTIONS WHEN EMPTY =====
                if searchText.isEmpty {
                    // Feel free to customize this content with any default suggestions
                    VStack(spacing: 10) {
                        Text("Try searching for something like:")
                            .font(.headline)
                        Text("Plastic Bottle")
                            .font(.title3)
                        Text("Glass Jar")
                            .font(.title3)
                        Text("Paper Bag")
                            .font(.title3)
                        Text("Battery")
                            .padding(.bottom, 10)
                            .font(.title3)
                        
                        Text("Or type your item above to see suggestions.")
                            .foregroundColor(.gray)
                    }
                    .padding()
                }
                // ===== END OF ADDED BLOCK =====

                // Search Suggestions
                if !filteredSuggestions.isEmpty {
                    ScrollView {
                        LazyVStack(spacing: 10) {
                            ForEach(filteredSuggestions, id: \.self) { suggestion in
                                Button(action: {
                                    searchText = suggestion
                                    processSearch()
                                }) {
                                    HStack {
                                        Image(systemName: "magnifyingglass")
                                            .foregroundColor(.blue)
                                        Text(suggestion.capitalized)
                                            .foregroundColor(.black)
                                            .font(.system(size: 18, weight: .medium))
                                        Spacer()
                                    }
                                    .padding()
                                    .background(Color(.white))
                                    .cornerRadius(10)
                                    .shadow(color: Color.gray.opacity(0.2), radius: 3, x: 0, y: 2)
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                    .frame(maxHeight: 400)
                }

                if noResults {
                    Text("🚫 No Results Found")
                        .foregroundColor(.red)
                        .font(.headline)
                        .padding()
                }

                Spacer()
            }
            .navigationDestination(isPresented: $showResults) {
                if let itemData = selectedItem {
                    ScanResultView(
                        searchType: "manual",
                        itemName: itemData.name.capitalized,
                        category: itemData.category,
                        colourCode: itemData.colourCode,
                        dustbinColor: itemData.dustbinColor,
                        recyclingMethod: itemData.recyclingMethod
                    )
                    .onDisappear {
                        searchText = ""
                        noResults = false
                    }
                }
            }
        }
    }

    private func processSearch() {
        let lowercasedSearch = searchText.lowercased()
        if let item = itemDatabase[lowercasedSearch] {
            selectedItem = (name: searchText, category: item.category, colourCode: item.colourCode, dustbinColor: item.dustbinColor, recyclingMethod: item.recyclingMethod)
            showResults = true
            noResults = false
        } else {
            selectedItem = nil
            showResults = false
            noResults = true
        }
    }
}
