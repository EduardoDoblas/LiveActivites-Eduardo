//
//  LiveActivityConten.swift
//  WaitlistDemoExtension
//
//  Created by Eduardo Villarreal on 23/04/25.
//

import SwiftUI
import WidgetKit
struct LiveActivityContent : View {
    let progress: Double
    let position: Int
    let waitlistName: String

    var body: some View {
        VStack {
            HStack {
                Text(waitlistName)
                    .font(.system(size: 13))
                    .fontWeight(.medium)
                    .foregroundColor(Color("TextSecondary"))
                    .lineLimit(1)
                
                Spacer()
                AppLogo(size: 24)
            }
            HStack {
                VStack(alignment: .leading) {
                    QueuePostion(position: position)
                    HorizontalProgressBar(level: progress).frame(height: 8)
                }
                Spacer()
                QueueIllustration(position: position)
            }

        }.padding(16)
            .activityBackgroundTint(Color("WidgetBackground"))
            .activitySystemActionForegroundColor(Color.black)
    }
}

struct HorizontalProgressBar: View {
    var level: Double

    var body: some View {
        GeometryReader { geometry in
            let frame = geometry.frame(in: .local)
            let boxWidth = frame.width * level

            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(Color("ContainerHigh"))

            RoundedRectangle(cornerRadius: 20)
                .frame(width: boxWidth)
                .foregroundColor(Color("PrimaryColor"))

        }
    }
}

struct QueuePostion: View {
    let position: Int

    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .firstTextBaseline) {
                Text("\(position)")
                    .font(.system(size: 36, weight: .semibold)).lineSpacing(48).foregroundColor(Color("TextPrimary"))
                Text(" is your current")
                    .font(.system(size: 18, weight: .semibold))
                    .lineSpacing(26).foregroundColor(Color("TextPrimary"))
            }
            Text("position in the queue")
                .font(.system(size: 18, weight: .semibold)).foregroundColor(Color("TextPrimary"))
        }
    }
}

struct QueueIllustration :View {
    let position: Int

    var image: String {
        if position < 5 {
            return "queue4"
        } else if position < 9 {
            return "queue3"
        } else if position < 25 {
            return "queue2"
        } else {
            return "queue1"
        }
    }

    var body: some View {
        Image(uiImage: UIImage(named: image)!)
            .resizable().frame(width: 100, height: 100)
            .scaledToFit()
    }
}

struct AppLogo :View {
    let size: CGFloat
    var body: some View {
        Image(uiImage: UIImage(named: "AppLogo")!)
            .resizable().frame(width: size, height: size)
            .scaledToFit()
            .clipShape(.circle)
    }
}
struct MinimalProgresBar: View {
    let progress: Double
    let position: Int
    let size: CGFloat
    var body: some View
    {
        ProgressView(value: progress, total: 1){
            Text("\(position)")
        }.frame(width:size, height: size)
            .progressViewStyle(.circular)
            .tint(Color("PrimaryColor"))
    }
}
//#Preview("LockScreen", as: .content, using: WaitTimeDemoAttributes.preview) {
//    WaitTimeDemoLiveActivity()
//} contentStates: {
//    for i in stride(from: 10, through: 1, by: -1) {
//        let progress = (10 - Double(i)) / 10.0
//        WaitTimeDemoAttributes.ContentState(currentPositionInQueue: i, progress: progress)
//    }
//}
