//
//  ContentView.swift
//  BMI Calculator
//
//  Created by KavemanRSA on 3/12/25.
//

import SwiftUI

class Person {
    var height: Float
    var weight: Float
    
    init(height: Float, weight: Float) {
        self.height = height
        self.weight = weight
    }
    
    // Function to calculate BMI
    func bmi() -> Float {
        return weight / (height * height)
    }
    
    // Function to interpret BMI
    func bmiLabel() -> String {
        let category = WeightCategory.category(bmi: bmi())
        return category.rawValue
    }
}

// Enum for weight categories
enum WeightCategory: String {
    case underweight = "Underweight"
    case normal = "Normal"
    case overweight = "Overweight"
    
    static func category(bmi: Float) -> WeightCategory {
        if bmi < 19 {
            return .underweight
        } else if bmi <= 24.9 {
            return .normal
        } else {
            return .overweight
        }
    }
}

// Subclass representing a specific user
class User: Person {
    init(weight: Float, height: Float) {
        super.init(height: height, weight: weight)
    }
}

// SwiftUI View
struct ContentView: View {
    @State private var weight = ""
    @State private var height = ""
    @State private var bmiResult = ""
    @State private var interpretation = ""
    
    var body: some View {
        VStack {
            Spacer().frame(height: 20)
            
            Text("ACME Applications")
                .font(.title3)
                .fontWeight(.bold)
            
            Spacer().frame(height: 20)
            
            Text("BMI Calculator")
                .font(.title)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .center)
            
            Spacer().frame(height: 20)
            
            // Weight input field
            TextField("Enter weight (kg)", text: $weight)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Spacer().frame(height: 8)
            
            // Height input field
            TextField("Enter height (m)", text: $height)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Spacer().frame(height: 16)
            
            // Button to calculate BMI
            Button(action: {
                if let weightValue = Float(weight), let heightValue = Float(height),
                   heightValue > 0 && heightValue < 4.0 {
                    let user = User(weight: weightValue, height: heightValue)
                    let bmi = user.bmi()
                    bmiResult = String(format: "Your BMI is %.2f", bmi)
                    interpretation = user.bmiLabel()
                } else {
                    bmiResult = "Please enter valid values"
                    interpretation = ""
                }
            }) {
                Text("Calculate my BMI")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            
            Spacer().frame(height: 8)
            
            // Display the BMI result
            if !bmiResult.isEmpty {
                Text(bmiResult)
                    .font(.title2)
                    .fontWeight(.bold)
                Text(interpretation)
                    .font(.title3)
                    .foregroundColor(.red)
            }
            
            Spacer().frame(height: 16)
            
            Text("Developed by SomeRandomGuy")
                .font(.footnote)
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .padding()
        .background(LinearGradient(gradient: Gradient(colors: [.white, .gray]), startPoint: .top, endPoint: .bottom))
        .edgesIgnoringSafeArea(.all)
    }
}

// Preview the UI
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

