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
            Text("Demostracion de LiveActivites")
                .font(.title)
                .foregroundColor(.black)
                .padding(.top, 40)

            // Text Field for Waitlist Name
            TextField("Introducir nombre", text: $waitlistName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal, 20)

            // Text Field for Queue Position
            TextField("Ingresa la Posicion", value: $position, formatter: NumberFormatter())
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal, 20)
                .keyboardType(.numberPad)

            // Text Field for Progress
            TextField("ingresa el progreso (0.0 to 1.0)", value: $progress, formatter: NumberFormatter())
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal, 20)
                .keyboardType(.decimalPad)

            // Start Button
            Button(action: {
                LiveActivityManager.shared.startActivity(waitlistName: waitlistName, position: position, progress: progress)
                
                // Action to start the live activity will go here
            }) {
                Text("Iniciar Activity")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.yellow)
                    .cornerRadius(10)
            }
            .padding(.horizontal, 20)

            // Update Button
            Button(action: {
                LiveActivityManager.shared.updateActivity(position: position, progress: progress)
            }) {
                Text("Actualizar Activity")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding(.horizontal, 20)

            // End Button
            Button(action: {
                LiveActivityManager.shared.endActivity(position: position, progress: progress)
                
            }) {
                Text("Detener Activity")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.red)
                    .cornerRadius(10)
            }
            .padding(.horizontal, 20)

            Spacer()
        }
    }
}
