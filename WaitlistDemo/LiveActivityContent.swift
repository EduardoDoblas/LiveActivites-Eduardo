//
//  LiveActivityContent.swift
//  DinamicIsland
//
//  Created by Eduardo Villarreal on 25/04/25.
//

//
//  LiveActivityContent.swift
//  WaitlistDemoExtension
//

import SwiftUI
import WidgetKit

struct LiveActivityContent: View {
    let progress: Double
    let position: Int
    let waitlistName: String
    var isCompact: Bool = false

    var exampleId: String { "9KE325Y8XYZ123" }

    var estado: String {
        switch progress {
        case 0.0: return "Recibido"
        case 0.0..<0.5: return "Preparando"
        case 0.5..<1.0: return "En camino"
        default: return "Llegó"
        }
    }

    var randomCode: String { "XN2201" }

    var estimatedDeliveryTime: String {
        let futureDate = Calendar.current.date(byAdding: .minute, value: 40, to: Date()) ?? Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: futureDate)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: isCompact ? 4 : 6) {
            HStack(spacing: 6) {
                AppLogo(size: isCompact ? 28 : 40)
                Text(waitlistName)
                    .font(.system(size: isCompact ? 14 : 20))
                    .fontWeight(.medium)
                    .foregroundColor(.white)
                    .lineLimit(1)
                Spacer()
                Text(estimatedDeliveryTime)
                    .font(.system(size: isCompact ? 12 : 18, weight: .bold))
                    .foregroundColor(.green.opacity(0.8))
                    .padding(.horizontal, 6)
                    .padding(.vertical, 2)
                    .background(Color.white.opacity(0.1))
                    .cornerRadius(6)
            }

            HStack(alignment: .top, spacing: 8) {
                VStack(alignment: .leading, spacing: 0) {
                    Text("\(exampleId.prefix(8)): \(estado)")
                        .font(.system(size: isCompact ? 12 : 15))
                        .foregroundColor(.white)
                    Text("Código de entrega: \(randomCode)")
                        .font(.system(size: isCompact ? 12 : 15))
                        .foregroundColor(.red)
                }
                Spacer()
            }

            StepProgressBarView(progress: progress, isCompact: isCompact)
                .padding(.top, isCompact ? 4 : 8)
        }
        .padding(8)
        .activityBackgroundTint(Color("WidgetBackground"))
        .activitySystemActionForegroundColor(Color.black)
    }
}

struct StepProgressBarView: View {
    let progress: Double
    var isCompact: Bool = false
    private let stepCount = 4

    var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<stepCount) { index in
                HStack(spacing: 0) {
                    StepCircleView(index: index, progress: progress, isCompact: isCompact)
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
    var isCompact: Bool = false

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
                .frame(width: isCompact ? 24 : 40, height: isCompact ? 24 : 40)
                .overlay(Circle().stroke(Color.white, lineWidth: 1))

            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(width: isCompact ? 14 : 24, height: isCompact ? 14 : 24)
        }
        .frame(minWidth: isCompact ? 32 : 50)
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
