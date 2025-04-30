//
//  LiveActivityContent.swift
//  DinamicIsland
//
//  Created by Eduardo Villarreal on 25/04/25.
//

import SwiftUI
import WidgetKit

struct LiveActivityContent: View {
    let progress: Double
    let position: Int
    let waitlistName: String

    var exampleId: String {
        "9KE325Y8XYZ123"
    }

    var estado: String {
        switch progress {
        case 0.0: return "Recibido"
        case 0.0..<0.5: return "Preparando"
        case 0.5..<1.0: return "En camino"
        default: return "Llegó"
        }
    }

    var randomCode: String {
        String("XN2201")
    }

    var estimatedDeliveryTime: String {
        let futureDate = Calendar.current.date(byAdding: .minute, value: 40, to: Date()) ?? Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: futureDate)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            // Logo + nombre + hora estimada
            HStack(spacing: 6) {
                AppLogo(size: 40)
                Text(waitlistName)
                    .font(.system(size: 20))
                    .fontWeight(.medium)
                    .foregroundColor(.white)
                    .lineLimit(1)
                Spacer()
                // Hora estimada a la derecha sin texto
                Text(estimatedDeliveryTime)
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.green.opacity(0.8))
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color.white.opacity(0.1))
                    .cornerRadius(6)
            }

            // Imagen + Labels
            HStack(alignment: .top, spacing: 8) {
                VStack(alignment: .leading, spacing: 0) {
                    Text("\(exampleId.prefix(8)): \(estado)")
                        .font(.system(size: 15))
                        .foregroundColor(.white)
                    Text("Código de entrega: \(randomCode)")
                        .font(.system(size: 15))
                        .foregroundColor(.red)
                }

                Spacer()
            }

            // Barra de pasos con círculos e imágenes
            StepProgressBarView(progress: progress)
                .padding(.top, 8)
        }
        .padding(8)
        .activityBackgroundTint(Color("WidgetBackground"))
        .activitySystemActionForegroundColor(Color.black)
    }
}

struct StepProgressBarView: View {
    let progress: Double
    private let stepCount = 4

    var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<stepCount) { index in
                HStack(spacing: 0) {
                    StepCircleView(index: index, progress: progress)
                    
                    if index < stepCount - 1 {
                        StepConnectorView(isActive: progress >= stepProgress(for: index + 1))
                    }
                }
            }
        }
    }

    private func stepProgress(for step: Int) -> Double {
        switch step {
        case 1: return 0.0
        case 2: return 0.33
        case 3: return 0.66
        case 4: return 1.0
        default: return 1.0
        }
    }
}

struct StepCircleView: View {
    let index: Int
    let progress: Double

    var isActive: Bool {
        progress >= stepProgress
    }

    var stepProgress: Double {
        switch index {
        case 0: return 0.0
        case 1: return 0.33
        case 2: return 0.66
        case 3: return 1.0
        default: return 1.0
        }
    }

    var imageName: String {
        "queue\(index + 1)"
    }

    var body: some View {
        ZStack {
            Circle()
                .fill(isActive ? Color.green.opacity(0.6) : Color.gray.opacity(0.4))
                .frame(width: 40, height: 40)
                .overlay(
                    Circle().stroke(Color.white, lineWidth: 1)
                )
            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 24, height: 24)
        }
        .frame(minWidth: 50)
    }
}

struct StepConnectorView: View {
    let isActive: Bool

    var body: some View {
        Rectangle()
            .fill(isActive ? Color.green.opacity(0.6) : Color.gray.opacity(0.4))
            .frame(height: 4)
            .frame(maxWidth: .infinity)
    }
}

struct QueueIllustration: View {
    let progress: Double

    var image: String {
        switch progress {
        case 0.0: return "queue1"
        case 0.0..<0.5: return "queue2"
        case 0.5..<1.0: return "queue3"
        default: return "queue4"
        }
    }

    var body: some View {
        if let uiImage = UIImage(named: image) {
            Image(uiImage: uiImage)
                .resizable()
                .scaledToFit()
        } else {
            Color.clear
        }
    }
}

struct AppLogo: View {
    let size: CGFloat
    var body: some View {
        Image(uiImage: UIImage(named: "AppLogo")!)
            .resizable()
            .frame(width: size, height: size)
            .scaledToFit()
            .clipShape(Circle())
    }
}

#Preview("LockScreen", as: .content, using: WaitlistAttributes(waitListName: "Nombre Ingresado")) {
    WaitTimeLiveActivityWidget()
} contentStates: {
    WaitlistAttributes.ContentState(position: 0, progress: 0.25)
    WaitlistAttributes.ContentState(position: 1, progress: 0.50)
    WaitlistAttributes.ContentState(position: 2, progress: 0.75)
    WaitlistAttributes.ContentState(position: 3, progress: 1.0)
}
