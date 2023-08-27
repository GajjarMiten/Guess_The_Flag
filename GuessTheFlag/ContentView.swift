//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Miten Gajjar on 21/08/23.
//

import SwiftUI

struct ContentView: View {
    
    @State var showingScore = false;
    @State var showingTitle = "";
    
    @State  var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State var correctCountry = Int.random(in: 0...2)
    @State var currentScore = 0
    
    
    private let totalQuestions =  8;
    @State private var currentQuestion = 1;
    
    
    var body: some View {
        ZStack{
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3),
            ], center: .top, startRadius: 200, endRadius: 400)
            .ignoresSafeArea()
            
            VStack{
                Spacer()
                Text("Guess the Flag")
                    .foregroundColor(.white)
                    .font(.largeTitle.bold())
                VStack(spacing:15){
                    VStack{
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.bold())
                        Text(countries[correctCountry])
                            .font(.largeTitle.bold())
                    }
                    
                    ForEach(0..<3){
                        index in
                        Button{
                            showResult(index)
                        }label: {
                            Image(countries[index])
                                .renderingMode(.original)
                                .clipShape(.capsule)
                                .shadow(radius: 5)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                Spacer()
                Text("Score: \(currentScore)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                Spacer()
                
            }.padding()
            
            
            
        }.alert(showingTitle, isPresented: $showingScore){
            Button("Continue", action: askQuestion)
        }message: {
            Text("Your score is \(currentScore)")
        }
    }
    func showResult(_ number:Int){
        
        if currentQuestion == totalQuestions{
            showingTitle = "Game Over!"
        }
        else if number == correctCountry {
            showingTitle = "Correct"
            currentScore+=1
        } else {
            let tappedFlagName  = countries[number];
            showingTitle = "Wrong! That's the flag of \(tappedFlagName)"
            if(currentScore>0){
                currentScore-=1
            }
        }
      
        showingScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctCountry = Int.random(in: 0...2)
        if currentQuestion >= totalQuestions {
            currentQuestion = 0;
            currentScore = 0;
        }
        currentQuestion+=1;
    }
    
    
}

#Preview {
    ContentView()
}
