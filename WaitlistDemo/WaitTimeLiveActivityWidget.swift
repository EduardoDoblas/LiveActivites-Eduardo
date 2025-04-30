//
//  WaitTimeLiveActivityWidget.swift
//  WaitlistDemoExtension
//
//  Created by Eduardo Villarreal on 23/04/25.
//

import Foundation
import SwiftUI
import ActivityKit
import WidgetKit

struct WaitTimeLiveActivityWidget: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: WaitlistAttributes.self) { context in
            LiveActivityContent(
                progress: context.state.progress,
                position: context.state.position,
                waitlistName: context.attributes.waitListName,
                isCompact: false // Vista expandida
            )
        } dynamicIsland: { context in
            DynamicIsland {
                // Vista expandida
                DynamicIslandExpandedRegion(.center) {
                    LiveActivityContent(
                        progress: context.state.progress,
                        position: context.state.position,
                        waitlistName: context.attributes.waitListName,
                        isCompact: true // Vista compacta adaptada
                    )
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            } compactLeading: {
                AppLogo(size: 24)
            } compactTrailing: {
                SegmentedProgressCircle(
                    progress: context.state.progress,
                    totalSegments: 4,
                    size: 24
                )
            } minimal: {
                SegmentedProgressCircle(
                    progress: context.state.progress,
                    totalSegments: 4,
                    size: 24
                )
            }
        }
    }
}

struct SegmentedProgressCircle: View {
    let progress: Double
    let totalSegments: Int
    let size: CGFloat

    var activeSegments: Int {
        Int((progress * Double(totalSegments)).rounded(.down))
    }

    var body: some View {
        ZStack {
            // Contorno blanco
            Circle()
                .stroke(Color.white.opacity(0.6), lineWidth: 1)
                .frame(width: size, height: size)

            // Dibujar segmentos
            ForEach(0..<totalSegments) { index in
                SegmentShape(
                    startAngle: Angle(degrees: Double(index) * (360.0 / Double(totalSegments))),
                    endAngle: Angle(degrees: Double(index + 1) * (360.0 / Double(totalSegments)))
                )
                .fill(index < activeSegments ? Color.green : Color.gray.opacity(0.3))
            }
        }
        .frame(width: size, height: size)
    }
}

struct SegmentShape: Shape {
    let startAngle: Angle
    let endAngle: Angle

    func path(in rect: CGRect) -> Path {
        var path = Path()
        let radius = min(rect.width, rect.height) / 2
        let center = CGPoint(x: rect.midX, y: rect.midY)

        path.addArc(center: center,
                    radius: radius,
                    startAngle: startAngle - Angle(degrees: 90),
                    endAngle: endAngle - Angle(degrees: 90),
                    clockwise: false)

        path.addLine(to: center)
        path.closeSubpath()

        return path
    }
}
