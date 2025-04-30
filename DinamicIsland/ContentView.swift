import SwiftUI

struct LiveActivityDemoView: View {
    @State private var waitlistName: String = "Soriana-Triana"
    @State private var position: Int = 4
    @State private var initialPosition: Int = 4
    @State private var progress: Double = 0.0
    @State private var stepTime: Double = 6.0
    @State private var timer: Timer? = nil
    @State private var isRunning = false

    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    @State private var alertTitle: String = ""

    var body: some View {
        VStack {
            Text("Simulación Live Activity")
                .font(.title2)
                .fontWeight(.semibold)
                .padding(.top, 40)
                .foregroundColor(.black)

            Spacer()

            HStack {
                Spacer()
                VStack(spacing: 30) {
                    actionButton(title: "Iniciar", color: .green, action: startActivity)
                    actionButton(title: "Detener", color: .red, action: stopActivity)
                }
                Spacer()
            }

            Spacer()
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }

    func actionButton(title: String, color: Color, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Text(title)
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .frame(width: 150, height: 150)
                .background(color)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 1))
                .shadow(radius: 10)
        }
    }

    func startActivity() {
        guard !isRunning else {
            alertTitle = "Ya en ejecución"
            alertMessage = "La actividad ya se está ejecutando."
            showAlert = true
            return
        }

        position = 4
        progress = 0.0
        LiveActivityManager.shared.startActivity(waitlistName: waitlistName, position: position, progress: progress)

        isRunning = true
        timer = Timer.scheduledTimer(withTimeInterval: stepTime, repeats: true) { _ in
            if position > 0 {
                position -= 1
                progress = 1 - (Double(position) / Double(initialPosition))
                LiveActivityManager.shared.updateActivity(position: position, progress: progress)

                if position == 0 {
                    stopActivity()
                }
            }
        }

        alertTitle = "Actividad Iniciada"
        alertMessage = "La actividad ha comenzado correctamente."
        showAlert = true
    }

    func stopActivity() {
        guard isRunning else { return }

        isRunning = false
        timer?.invalidate()
        timer = nil
        LiveActivityManager.shared.endActivity(position: position, progress: progress)

        alertTitle = "Actividad Terminada"
        alertMessage = "La actividad ha sido detenida correctamente."
        showAlert = true
    }
}

struct LiveActivityDemoView_Previews: PreviewProvider {
    static var previews: some View {
        LiveActivityDemoView()
    }
}
