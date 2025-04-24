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
struct WaitTimeLiveActivityWidget : Widget{
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: WaitlistAttributes.self) { context in
            
            LiveActivityContent(progress: context.state.progress,
                                           position: context.state.position,
                                           waitlistName: context.attributes.waitListName)
            
        } dynamicIsland: { context in
            DynamicIsland {
                
                DynamicIslandExpandedRegion(.leading) {
                    AppLogo(size: 48)
                }
                DynamicIslandExpandedRegion(.trailing) {
                    MinimalProgresBar(progress: context.state.progress, position: context.state.position, size: 48)
                }
                DynamicIslandExpandedRegion(.center) {
                    
                    Text("your position in queue")
                        .font(.system(size: 12, weight: .medium))
                        .foregroundStyle(Color("TextPrmary"))
                              }
                    
                              
            } compactLeading: {
                AppLogo(size: 24)
            } compactTrailing: {
                MinimalProgresBar(progress: context.state.progress, position: context.state.position, size: 24)
            } minimal: {
                MinimalProgresBar(progress: context.state.progress, position: context.state.position, size: 24)
            }
        }
    }
}
#Preview("Preview", as: .content, using: WaitlistAttributes.init(waitListName: "Dinner Queue")){
    WaitTimeLiveActivityWidget()
}contentStates: {
    WaitlistAttributes.ContentState(position: 10, progress: 0.1)
    WaitlistAttributes.ContentState(position: 5, progress: 0.5)
}
