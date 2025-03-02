import SwiftUI

struct HomeView: View {
    @State private var backgroundScale: CGFloat = 1.0
    @State private var animateIcons = false

    var body: some View {
        NavigationView {
            ZStack {
                // Background Gradient
                LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.1), Color.green.opacity(0.1), Color.yellow.opacity(0.1)]),
                               startPoint: .topLeading,
                               endPoint: .bottomTrailing)
                    .edgesIgnoringSafeArea(.all)

                VStack(spacing: 20) {
                    // Logo at the Top
                    Image("PlanetPal_Logo_Head")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300, height: 140)
                        .padding(.top, 40)

                    Spacer()

                    // Buttons
                    HStack(spacing: 30) {
                        NavigationLink(destination: ManualSearchView()) {
                            HomeIcon(imageName: "magnifyingglass", label: "Search", animate: $animateIcons)
                        }
                        NavigationLink(destination: PredefinedCategoriesView()) {
                            HomeIcon(imageName: "list.bullet", label: "Categories", animate: $animateIcons)
                        }
                    }
                    .padding(.top, 10)
                    .onAppear {
                        withAnimation(Animation.easeInOut(duration: 2).repeatForever(autoreverses: true)) {
                            animateIcons.toggle()
                        }
                    }
                    
                    NavigationLink(destination: RecyclingQuizView()) {
                        HomeIcon(imageName: "questionmark.circle.fill", label: "Quiz", animate: .constant(false))
                    }


                    Spacer()

                    // "Learn More" Button
                    NavigationLink(destination: RecyclingFactsView()) {
                        HStack {
                            Image(systemName: "book.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 25, height: 25)
                                .foregroundColor(.white)

                            Text("Learn More")
                                .font(.headline)
                                .foregroundColor(.white)
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(12)
                        .shadow(radius: 5)
                        .padding(.horizontal)
                    }
                    .padding(.bottom, 30)
                }
                .padding(.horizontal, 20)
            }
        }
    }
}

// Home Icon Component
struct HomeIcon: View {
    var imageName: String
    var label: String
    @Binding var animate: Bool
    
    var body: some View {
        VStack {
            Image(systemName: imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 55, height: 55)
                .foregroundColor(.blue)
                .padding(.bottom, 8)
                .scaleEffect(animate ? 1.1 : 0.9) // Zoom effect
                .animation(Animation.easeInOut(duration: 2).repeatForever(autoreverses: true), value: animate)
            
            Text(label)
                .font(.system(size: 22, weight: .semibold, design: .serif))
                .foregroundColor(.black.opacity(0.85))
        }
        .frame(width: 140, height: 140)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(color: Color.gray.opacity(0.2), radius: 10, x: 0, y: 5)
    }
}
