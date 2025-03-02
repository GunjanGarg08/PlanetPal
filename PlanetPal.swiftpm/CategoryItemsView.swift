import SwiftUI

struct CategoryItemsView: View {
    @Environment(\.presentationMode) var presentationMode
    var category: String
    
    let itemDatabase: [String: (category: String, colourCode: String, dustbinColor: String, recyclingMethod: String)] = [
        // Plastic Items
        "Plastic Bottle": ("Plastic", "Blue", "Green", "Clean and Recycle"),
        "Plastic Bag": ("Plastic", "Blue", "Black", "Not Recyclable"),
        "Plastic Straw": ("Plastic", "Blue", "Black", "Not Recyclable"),
        "Plastic Food Container": ("Plastic", "Blue", "Green", "Rinse and Recycle"),
        "Plastic Cutlery": ("Plastic", "Blue", "Black", "Not Recyclable"),
        "Milk Jug": ("Plastic", "Blue", "Green", "Rinse and Recycle"),
        "Yogurt Cup": ("Plastic", "Blue", "Green", "Rinse and Recycle"),
        
        // Glass Items
        "Glass Jar": ("Glass", "Green", "Blue", "Reuse or Recycle"),
        "Wine Bottle": ("Glass", "Green", "Blue", "Recycle"),
        "Glass Plate": ("Glass", "Green", "Blue", "Recycle"),
        "Broken Glass": ("Glass", "Red", "Special", "Dispose Properly"),
        "Mirror": ("Glass", "Red", "Special", "Hazardous Waste"),
        "Perfume Bottle": ("Glass", "Green", "Blue", "Recycle"),
        
        // Metal Items
        "Aluminum Can": ("Metal", "Silver", "Blue", "Crush and Recycle"),
        "Steel Spoon": ("Metal", "Silver", "Blue", "Reuse or Recycle"),
        "Iron Nail": ("Metal", "Gray", "Blue", "Scrap Metal"),
        "Tin Can": ("Metal", "Gray", "Blue", "Rinse and Recycle"),
        "Foil Wrapper": ("Metal", "Silver", "Blue", "Recycle"),
        
        // Paper Items
        "Newspaper": ("Paper", "Gray", "Blue", "Recycle"),
        "Paper Bag": ("Paper", "Brown", "Blue", "Recycle"),
        "Cardboard Box": ("Paper", "Brown", "Blue", "Flatten and Recycle"),
        "Notebook": ("Paper", "Gray", "Blue", "Remove Staples & Recycle"),
        "Shredded Paper": ("Paper", "White", "Blue", "Recycle in Paper Bags"),
        "Pizza Box": ("Paper", "Brown", "Black", "Not Recyclable if Greasy"),
        
        // Electronic Waste
        "Battery": ("Electronics", "Red", "E-Waste", "Dispose at E-Waste Center"),
        "Phone Charger": ("Electronics", "Red", "E-Waste", "E-Waste Disposal"),
        "Earphones": ("Electronics", "Red", "E-Waste", "Dispose Properly"),
        "Old Laptop": ("Electronics", "Red", "E-Waste", "Donate or Recycle"),
        "Broken TV": ("Electronics", "Red", "E-Waste", "E-Waste Collection Center"),
        "LED Bulb": ("Electronics", "Red", "E-Waste", "Dispose Properly"),
        "Printer Cartridge": ("Electronics", "Red", "E-Waste", "Recycle at Store"),
        
        // Organic Waste
        "Fruit Peel": ("Organic", "Yellow", "Green", "Compost"),
        "Vegetable Waste": ("Organic", "Brown", "Green", "Compost"),
        "Tea Leaves": ("Organic", "Brown", "Green", "Compost"),
        "Eggshells": ("Organic", "White", "Green", "Compost"),
        "Coffee Grounds": ("Organic", "Brown", "Green", "Compost"),
        "Bones": ("Organic", "Red", "Black", "Dispose in General Waste"),
        
        // Wood Items
        "Wooden Chair": ("Wood", "Brown", "Special", "Donate or Reuse"),
        "Wooden Table": ("Wood", "Brown", "Special", "Repurpose or Donate"),
        
        // Clothing
        "Old Jeans": ("Clothing", "Blue", "Special", "Donate or Repurpose"),
        "Cotton Shirt": ("Clothing", "White", "Special", "Donate or Recycle"),
        
        // Hazardous Waste
        "Light Bulb": ("Hazardous", "White", "Special", "Dispose Carefully"),
        "Paint Can": ("Hazardous", "Red", "Special", "Hazardous Waste"),
        "Medicine Bottle": ("Hazardous", "White", "Special", "Return to Pharmacy"),
        "Used Tissue": ("Hazardous", "Red", "Black", "Not Recyclable"),
        "Diapers": ("Hazardous", "Red", "Black", "Not Recyclable"),
        "Expired Medicine": ("Hazardous", "Red", "Special", "Return to Pharmacy"),
        "Chemical Bottles": ("Hazardous", "Red", "Special", "Dispose at Hazardous Waste Center"),
        
        // Miscellaneous
        "Toys": ("Miscellaneous", "Multicolor", "Special", "Donate"),
        "Ceramic Mug": ("Miscellaneous", "White", "Blue", "Not Recyclable"),
        "Candle Wax": ("Miscellaneous", "Yellow", "Special", "Not Recyclable")
    ]



    var body: some View {
        VStack {
            Text("\(category) Items")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.top, 10)

            List(itemDatabase.keys.filter { itemDatabase[$0]?.category == category }, id: \.self) { item in
                if let details = itemDatabase[item] {
                    NavigationLink(destination: ScanResultView(
                        searchType: "category",
                        itemName: item,
                        category: details.category,
                        colourCode: details.colourCode,
                        dustbinColor: details.dustbinColor,
                        recyclingMethod: details.recyclingMethod
                    )) {
                        Text(item)
                            .font(.headline)
                            .padding()
                    }
                }
            }
            .listStyle(PlainListStyle())

            Spacer()

            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                HStack {
                    Image(systemName: "arrow.left.circle.fill")
                        .font(.title2)
                    Text("Go Back")
                        .font(.headline)
                        .fontWeight(.medium)
                }
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .cornerRadius(12)
                .shadow(radius: 3)
                .padding(.horizontal)
            }
            .padding(.bottom, 20)
        }
        .navigationBarBackButtonHidden(true)
    }
}
