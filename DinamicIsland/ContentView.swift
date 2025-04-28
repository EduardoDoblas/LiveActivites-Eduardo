//
//  ContentView.swift
//  DinamicIsland
//
//  Created by Eduardo Villarreal on 23/04/25.
//

import SwiftUI
struct LiveActivityDemoView: View {
    @State var waitlistName: String = ""
    @State var position: Int = 1
    @State var progress: Double = 0.0
    @State var stepTime: Double = 0.5
    @State var timer: Timer? = nil
    @State var isRunning = false

    var body: some View {
        VStack(spacing: 20) {
            Text("Demostracion de LiveActivites")
                .font(.title)
                .foregroundColor(.black)
                .padding(.top, 40)

            // Text Field para el nombre
            TextField("Introducir nombre", text: $waitlistName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal, 20)

            // Text Field para la posición (fijo, no se moverá)
            TextField("Ingresa la Posición", value: $position, formatter: NumberFormatter())
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal, 20)
                .keyboardType(.numberPad)
                .disabled(isRunning) // Desactivar el TextField si el temporizador está corriendo

            // Picker para el tiempo entre pasos (de 0.5 a 60 segundos)
            Picker("Seleccionar tiempo entre pasos", selection: $stepTime) {
                ForEach([0.5, 1.0, 1.5, 2.0, 2.5, 3.0, 5.0, 10.0], id: \.self) { time in
                    Text("\(time, specifier: "%.1f") segundos")
                        .tag(time)
                }
            }
            .pickerStyle(WheelPickerStyle())
            .frame(height: 150)
            .padding(.horizontal, 20)

            // Botón para iniciar la actividad
            Button(action: {
                startActivity()
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
            .disabled(isRunning) // Desactivar si ya está corriendo

            // Botón para actualizar la actividad
            Button(action: {
                updateActivity()
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

            // Botón para detener la actividad
            Button(action: {
                stopActivity()
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
            .disabled(!isRunning) // Desactivar si no está corriendo

            Spacer()
        }
    }

    // Iniciar actividad
    func startActivity() {
        LiveActivityManager.shared.startActivity(waitlistName: waitlistName, position: position, progress: progress)
        
        // Iniciar el temporizador para decrementar la posición
        isRunning = true
        timer = Timer.scheduledTimer(withTimeInterval: stepTime, repeats: true) { _ in
            if position > 0 {
                position -= 1 // Reducir la posición en cada paso
                progress = 1 - (Double(position) / 10.0) // Calcula el progreso (esto puede cambiar según tu lógica)
                LiveActivityManager.shared.updateActivity(position: position, progress: progress)
            } else {
                stopActivity() // Detener cuando llegue a 0
            }
        }
    }

    // Actualizar actividad
    func updateActivity() {
        LiveActivityManager.shared.updateActivity(position: position, progress: progress)
    }

    // Detener actividad
    func stopActivity() {
        LiveActivityManager.shared.endActivity(position: position, progress: progress)
        isRunning = false
        timer?.invalidate() // Detener el temporizador
    }
}

