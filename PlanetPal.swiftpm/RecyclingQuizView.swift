import SwiftUI

struct RecyclingQuizView: View {
    @State private var questionIndex = 0
    @State private var score = 0
    @State private var showResult = false
    @State private var selectedAnswer: String? = nil
    @State private var selectedQuestions: [(question: String, options: [String], correctAnswer: String)] = []
    
    let allQuestions: [(question: String, options: [String], correctAnswer: String)] = [
        ("Which bin should paper go in?", ["Green", "Blue", "Red"], "Blue"),
        ("What should you do before recycling a plastic bottle?", ["Crush it", "Throw it", "Wash it"], "Wash it"),
        ("Which item is NOT recyclable?", ["Glass Bottle", "Plastic Straw", "Newspaper"], "Plastic Straw"),
        ("What does the recycling symbol with a ‘1’ mean?", ["Compostable", "PET Plastic", "Non-Recyclable"], "PET Plastic"),
        ("Where should dead batteries be disposed?", ["Blue Bin", "Trash", "E-Waste Center"], "E-Waste Center"),
        ("Which bin does food waste go into?", ["Green", "Black", "Red"], "Green"),
        ("Which material takes the longest to decompose?", ["Plastic", "Paper", "Glass"], "Glass"),
        ("What should you do with old clothes?", ["Throw them away", "Donate or recycle", "Burn them"], "Donate or recycle"),
        ("Can pizza boxes be recycled?", ["Yes", "No", "Only if clean"], "Only if clean"),
        ("Which bin does aluminum foil go in?", ["Recycle if Clean", "Always Recyclable", "Trash"], "Recycle if Clean"),
        ("What does the '♻' symbol mean?", ["Recycle", "Compost", "Trash"], "Recycle"),
        ("Which material is biodegradable?", ["Plastic", "Glass", "Paper"], "Paper"),
        ("What is the best way to reduce waste?", ["Recycle More", "Use Less", "Throw Away Less"], "Use Less"),
        ("Which is an example of upcycling?", ["Turning old clothes into a bag", "Throwing away old shoes", "Burning old furniture"], "Turning old clothes into a bag"),
        ("What is composting used for?", ["Creating landfill", "Reducing pollution", "Turning organic waste into fertilizer"], "Turning organic waste into fertilizer"),
        ("Which plastic type is NOT recyclable?", ["PET (1)", "PVC (3)", "HDPE (2)"], "PVC (3)"),
        ("Which is the best eco-friendly alternative to plastic bags?", ["Paper bags", "Plastic straws", "Aluminum foil"], "Paper bags"),
        ("Which bin should electronic waste go in?", ["Trash Bin", "Recycling Bin", "E-Waste Collection"], "E-Waste Collection"),
        ("Which of these materials is easiest to recycle?", ["Glass", "Plastic", "Styrofoam"], "Glass"),
        ("Which metal is commonly recycled?", ["Iron", "Aluminum", "Lead"], "Aluminum"),
        ("What can you do with old mobile phones?", ["Throw in the trash", "Sell or recycle", "Bury them"], "Sell or recycle"),
        ("What should you NOT put in a recycling bin?", ["Newspapers", "Used tissues", "Plastic bottles"], "Used tissues"),
        ("Which of these items is hazardous waste?", ["Glass bottle", "Light bulb", "Tin can"], "Light bulb"),
        ("Which is a renewable resource?", ["Coal", "Plastic", "Bamboo"], "Bamboo"),
        ("What is the most recycled material in the world?", ["Glass", "Paper", "Aluminum"], "Aluminum"),
        ("Which is NOT an example of waste reduction?", ["Buying in bulk", "Using single-use plastics", "Bringing reusable bags"], "Using single-use plastics"),
        ("Which plastic number is safest for reuse?", ["1", "5", "7"], "5"),
        ("What happens to plastic in the ocean?", ["It disappears", "It breaks down into microplastics", "It turns into sand"], "It breaks down into microplastics")
    ]
    
    init() {
        _selectedQuestions = State(initialValue: Array(allQuestions.shuffled().prefix(10)))
    }
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.green.opacity(0), Color.mint.opacity(0)]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
                .overlay(
                    Image("BackgroundQuiz")
                        .resizable()
                        .scaledToFill()
                        .opacity(0.3)
                )
            
            VStack(spacing: 40) {
                if showResult {
                    resultView
                } else {
                    quizView
                }
            }
            .padding()
        }
    }
    
    var quizView: some View {
        
        VStack(spacing: 20) {
            // Title
            Text("Recycling Quiz")
                .font(.largeTitle.bold())
                .foregroundColor(.black)
                .padding()
            
            // Progress Bar
            VStack {
                Text("\(Int((Double(questionIndex) / Double(selectedQuestions.count)) * 100))% Completed")
                    .font(.headline)
                    .foregroundColor(.gray)
                
                ProgressView(value: Double(questionIndex), total: Double(selectedQuestions.count))
                    .progressViewStyle(LinearProgressViewStyle(tint: Color.green))
                    .scaleEffect(x: 1, y: 5, anchor: .center)
                    .background(Color.white.opacity(0.3))
                    .clipShape(Capsule())
                    .padding(.horizontal, 40)
                    .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 3)
            }
            
            // Question Box
            Text(selectedQuestions[questionIndex].question)
                .font(.title2.bold())
                .multilineTextAlignment(.center)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.white.opacity(0.9))
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .shadow(color: Color.gray.opacity(0.3), radius: 5, x: 0, y: 3)
                .padding(.horizontal)
            
            // Answer Buttons
            VStack(spacing: 15) {
                ForEach(selectedQuestions[questionIndex].options, id: \.self) { option in
                    Button(action: {
                        checkAnswer(option)
                    }) {
                        Text(option)
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(
                                selectedAnswer == option
                                ? LinearGradient(gradient: Gradient(colors: [Color.green, Color.teal]), startPoint: .leading, endPoint: .trailing)
                                : LinearGradient(gradient: Gradient(colors: [Color.yellow.opacity(0.8), Color.green.opacity(0.7)]), startPoint: .leading, endPoint: .trailing)
                            )
                            .foregroundColor(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                            .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 3)
                    }
                    .scaleEffect(selectedAnswer == option ? 1.05 : 1.0)
                    .animation(.easeInOut(duration: 0.2), value: selectedAnswer)
                }
            }
            .padding(.horizontal)
        }
        .padding()
    }
    
    var resultView: some View {
        VStack(spacing: 25) {
            
            // Dynamic Message Based on Score
            Text(scoreMessage())
                .font(.title.bold())
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 15)
                        .fill(score >= 7 ? Color.green.opacity(0.8) : Color.orange.opacity(0.8))
                )
                .shadow(color: Color.black.opacity(0.3), radius: 10, x: 0, y: 5)
                .padding(.horizontal, 20)

            Spacer()
            
            // Score Display with Progress Bar
            VStack(spacing: 15) {
                Text("Your Score: \(score)/10")
                    .font(.title.bold())
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.white.opacity(0.9))
                    .cornerRadius(15)
                    .shadow(radius: 5)
                    .padding(.horizontal, 20)

                ProgressView(value: Double(score), total: 10)
                    .progressViewStyle(LinearProgressViewStyle(tint: score >= 7 ? Color.green : Color.orange))
                    .scaleEffect(x: 1, y: 5, anchor: .center)
                    .frame(height: 10)
                    .background(Color.white.opacity(0.3))
                    .clipShape(Capsule())
                    .padding(.horizontal, 40)
                    .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 3)
            }

            Spacer()

            // Play Again Button
            Button(action: resetQuiz) {
                Text("Play Again")
                    .font(.title2.bold())
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(
                        LinearGradient(gradient: Gradient(colors: [Color.green, Color.yellow]), startPoint: .leading, endPoint: .trailing)
                    )
                    .foregroundColor(.white)
                    .cornerRadius(15)
                    .shadow(radius: 5)
            }
            .padding(.horizontal, 40)
            .padding(.bottom, 20)
        }
        .padding()
    }

    private func scoreMessage() -> String {
        switch score {
        case 8...10:
            return "🎉 Excellent! You're a Recycling Pro!"
        case 5...7:
            return "👏 Good Job! Keep Recycling!"
        default:
            return "🌱 Keep Learning! You can do better!"
        }
    }


    
    private func checkAnswer(_ selected: String) {
        selectedAnswer = selected
        if selected == selectedQuestions[questionIndex].correctAnswer {
            score += 1
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            if questionIndex < selectedQuestions.count - 1 {
                questionIndex += 1
                selectedAnswer = nil
            } else {
                showResult = true
            }
        }
    }
    
    private func resetQuiz() {
        score = 0
        questionIndex = 0
        selectedQuestions = Array(allQuestions.shuffled().prefix(4))
        showResult = false
    }
}

struct RecyclingQuizView_Previews: PreviewProvider {
    static var previews: some View {
        RecyclingQuizView()
    }
}
