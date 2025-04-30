//
//  WaitTimeLiveActivityWidget.swift
//  WaitlistDemoExtension
//
//  Created by Eduardo Villarreal on 23/04/25.
//

import Foundation
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
                waitlistName: context.attributes.waitListName
            )
        } dynamicIsland: { context in
            DynamicIsland {
                // Vista expandida: usamos el mismo contenido del widget directamente
                DynamicIslandExpandedRegion(.center) {
                    LiveActivityContent(
                        progress: context.state.progress,
                        position: context.state.position,
                        waitlistName: context.attributes.waitListName
                    )
                    .frame(maxWidth: .infinity, maxHeight: 160) // Altura ajustada
                    .padding(.horizontal, 8)
                }
            } compactLeading: {
                AppLogo(size: 24)
            } compactTrailing: {
                MinimalProgressBar(
                    progress: context.state.progress,
                    position: context.state.position,
                    size: 24
                )
            } minimal: {
                MinimalProgressBar(
                    progress: context.state.progress,
                    position: context.state.position,
                    size: 24
                )
            }
        }
    }
}

struct MinimalProgressBar: View {
    let progress: Double
    let position: Int
    let size: CGFloat

    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.gray.opacity(0.3), lineWidth: 4)
                .frame(width: size, height: size)

            Circle()
                .trim(from: 0, to: progress)
                .stroke(Color.green, style: StrokeStyle(lineWidth: 4, lineCap: .round))
                .rotationEffect(.degrees(-90))
                .frame(width: size, height: size)

            Text("\(position)")
                .font(.system(size: size * 0.4, weight: .bold))
                .foregroundColor(.white)
        }
    }
}
#Preview {
    MinimalProgressBar(progress: <#T##Double#>, position: <#T##Int#>, size: <#T##CGFloat#>)
}
