//
//  ContentView.swift
//  DinamicIsland
//
//  Created by Eduardo Villarreal on 23/04/25.
//

import SwiftUI

struct LiveActivityDemoView: View {
    @State private var waitlistName: String = "Soriana-Triana"
    @State private var position: Int = 10
    @State private var initialPosition: Int = 10
    @State private var progress: Double = 0.0
    @State private var stepTime: Double = 0.5
    @State private var timer: Timer? = nil
    @State private var isRunning = false

    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    @State private var alertTitle: String = ""

    private let positionFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .none
        return formatter
    }()

    var body: some View {
        VStack {
            VStack(spacing: 20) {
                Text("Prueba de Live Activity")
                    .font(.title)
                    .foregroundColor(.gray)
                    .padding(.top, 40)

                TextField("Nombre de la tienda", text: $waitlistName)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
                    .foregroundColor(.black)
                    .textFieldStyle(PlainTextFieldStyle())
                    .padding(.horizontal, 40)

                TextField("Posición", value: $position, formatter: positionFormatter)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
                    .foregroundColor(.black)
                    .keyboardType(.numberPad)
                    .disabled(isRunning)
                    .padding(.horizontal, 40)

                Picker("Duración", selection: $stepTime) {
                    ForEach([0.5, 1.0, 1.5, 2.0, 2.5, 3.0, 5.0, 10.0], id: \.self) { time in
                        Text("\(time, specifier: "%.1f") segundos").tag(time)
                    }
                }
                .pickerStyle(WheelPickerStyle())
                .frame(height: 100)
                .padding(.horizontal, 40)
                .foregroundColor(.black)

                HStack(spacing: 20) {
                    actionButton(title: "Iniciar", color: .green, action: startActivity)
                    actionButton(title: "Detener", color: .red, action: stopActivity)
                    actionButton(title: "Actualizar", color: .blue, action: updateActivity)
                }
                .padding(.top, 20)
            }
            .background(Color.gray.opacity(0.1).edgesIgnoringSafeArea(.all))
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
        .onDisappear {
            stopActivity()
        }
    }

    func actionButton(title: String, color: Color, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Text(title)
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .frame(width: 100, height: 50)
                .background(color)
                .cornerRadius(25)
        }
    }

    func startActivity() {
        guard !isRunning else {
            alertTitle = "Ya en ejecución"
            alertMessage = "La actividad ya se está ejecutando."
            showAlert = true
            return
        }

        initialPosition = position
        progress = 0.0
        LiveActivityManager.shared.startActivity(waitlistName: waitlistName, position: position, progress: progress)

        isRunning = true
        timer = Timer.scheduledTimer(withTimeInterval: stepTime, repeats: true) { _ in
            if position > 0 {
                position -= 1
                progress = 1 - (Double(position) / Double(initialPosition))
                LiveActivityManager.shared.updateActivity(position: position, progress: progress)
            } else {
                stopActivity()
            }
        }

        alertTitle = "Actividad Iniciada"
        alertMessage = "La actividad ha comenzado correctamente."
        showAlert = true
    }

    func updateActivity() {
        LiveActivityManager.shared.updateActivity(position: position, progress: progress)
        alertTitle = "Actividad Actualizada"
        alertMessage = "La actividad ha sido actualizada correctamente."
        showAlert = true
    }

    func stopActivity() {
        isRunning = false
        timer?.invalidate()
        timer = nil
        LiveActivityManager.shared.endActivity(position: position, progress: progress)
        alertTitle = "Actividad Detenida"
        alertMessage = "La actividad ha sido detenida correctamente."
        showAlert = true
    }
}

struct LiveActivityDemoView_Previews: PreviewProvider {
    static var previews: some View {
        LiveActivityDemoView()
    }
}
