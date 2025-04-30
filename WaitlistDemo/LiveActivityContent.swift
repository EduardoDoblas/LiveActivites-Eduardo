//
//  LiveActivityContent.swift
//  DinamicIsland
//
//  Created by Eduardo Villarreal on 25/04/25.
//

import SwiftUI
import WidgetKit

struct LiveActivityContent : View {
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
        String(format: "%04d", Int.random(in: 0..<10000))
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {

            // Logo + nombre
            HStack(spacing: 6) {
                AppLogo(size: 40)
                Text(waitlistName)
                    .font(.system(size: 20))
                    .fontWeight(.medium)
                    .foregroundColor(.white)
                    .lineLimit(1)
                Spacer()
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
                QueueIllustration(progress: progress)
                    .frame(width: 50, height: 50)
                    .offset(x: 80, y: -24) // Leve hacia la izquierda
                //Spacer()
            }

            // Barra de progreso más gruesa
            HorizontalProgressBar(level: progress)
                .frame(height: 8)
                .frame(maxWidth: .infinity)
                .offset(y: -10)

        }
        .padding(8)
        .activityBackgroundTint(Color("WidgetBackground"))
        .activitySystemActionForegroundColor(Color.black)
    }
}

struct HorizontalProgressBar: View {
    var level: Double

    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            let boxWidth = width * level

            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 60)
                    .fill(Color(.black))
                RoundedRectangle(cornerRadius: 60)
                    .fill(Color(.green))
                    .frame(width: boxWidth)
            }
        }
    }
}

struct QueueIllustration : View {
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
            Image(uiImage: UIImage(named: image)!)
                .resizable()
                .scaledToFit()
        }
    }
}

struct AppLogo : View {
    let size: CGFloat
    var body: some View {
        Image(uiImage: UIImage(named: "AppLogo")!)
            .resizable()
            .frame(width: size, height: size)
            .scaledToFit()
            .clipShape(Circle())
    }
}

struct MinimalProgresBar: View {
    let progress: Double
    let position: Int
    let size: CGFloat
    var body: some View {
        ProgressView(value: progress, total: 1) {
            Text("\(position)")
        }
        .frame(width: size, height: size)
        .progressViewStyle(.circular)
        .tint(Color(.red))
    }
}

// MARK: - Preview

#Preview("LockScreen", as: .content, using: WaitlistAttributes(waitListName: "Nombre Ingresado")) {
    WaitTimeLiveActivityWidget()
} contentStates: {
    WaitlistAttributes.ContentState(position: 0, progress: 0.25)
    WaitlistAttributes.ContentState(position: 1, progress: 0.50)
    WaitlistAttributes.ContentState(position: 2, progress: 0.75)
    WaitlistAttributes.ContentState(position: 3, progress: 1.0)
}
