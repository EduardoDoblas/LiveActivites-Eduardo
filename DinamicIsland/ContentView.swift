//
//  ContentView.swift
//  DinamicIsland
//
//  Created by Eduardo Villarreal on 23/04/25.
//

import SwiftUI
struct LiveActivityDemoView: View {
    @State private var waitlistName: String = ""
    @State private var position: Int = 0
    @State private var progress: Double = 0.0

    var body: some View {
        VStack(spacing: 20) {
            Text("Live Activity Demo")
                .font(.title)
                .foregroundColor(.white) // White text for better contrast
                .padding(.top, 40)

            // Text Field for Waitlist Name
            TextField("Enter Waitlist Name", text: $waitlistName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal, 20)

            // Text Field for Queue Position
            TextField("Enter Queue Position", value: $position, formatter: NumberFormatter())
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal, 20)
                .keyboardType(.numberPad)

            // Text Field for Progress
            TextField("Enter Progress (0.0 to 1.0)", value: $progress, formatter: NumberFormatter())
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal, 20)
                .keyboardType(.decimalPad)

            // Start Button
            Button(action: {
                LiveActivityManager.shared.startActivity(waitlistName: waitlistName, position: position, progress: progress)
                
                // Action to start the live activity will go here
            }) {
                Text("Start Activity")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.gray) // Grayscale background
                    .cornerRadius(10)
            }
            .padding(.horizontal, 20)

            // Update Button
            Button(action: {
                LiveActivityManager.shared.updateActivity(position: position, progress: progress)
                // Action to update the live activity will go here
            }) {
                Text("Update Activity")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color(white: 0.7)) // Slightly lighter gray
                    .cornerRadius(10)
            }
            .padding(.horizontal, 20)

            // End Button
            Button(action: {
                LiveActivityManager.shared.endActivity(position: position, progress: progress)
                // Action to end the live activity will go here
                
            }) {
                Text("End Activity")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color(white: 0.5)) // Even lighter gray
                    .cornerRadius(10)
            }
            .padding(.horizontal, 20)

            Spacer()
        }
    }
}
