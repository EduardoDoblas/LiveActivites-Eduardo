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
    
    var body: some View {
        VStack {
            HStack {
                Text(waitlistName)
                    .font(.system(size: 20))
                    .fontWeight(.medium)
                    .foregroundColor(Color(.black))
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
                .foregroundColor(Color(.black))
            
            RoundedRectangle(cornerRadius: 20)
                .frame(width: boxWidth)
                .foregroundColor(Color(.red))
            
        }
    }
}
struct QueuePostion: View {
    let position: Int
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .firstTextBaseline) {
                Text("\(position)")
                    .font(.system(size: 36, weight: .semibold))
                    .lineSpacing(48)
                    .foregroundColor(.black)
                Text(" Esta es una prueba")
                    .font(.system(size: 18, weight: .semibold))
                    .lineSpacing(26)
                    .foregroundColor(.black)
            }
            Text("de Texto :D")
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(.black)
        }
    }
}
struct QueueIllustration : View {
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
        if let uiImage = UIImage(named: image) {
            Image(uiImage: uiImage)
                .resizable()
                .frame(width: 100, height: 100)
                .scaledToFit()
        } else {
            Image(uiImage: UIImage(named: image)!)
                .resizable().frame(width: 100, height: 100)
                .scaledToFit()
        }
        
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
            .tint(Color(.red))
    }
}

#Preview("LockScreen", as: .content, using: WaitlistAttributes(waitListName: "Nombre Ingresado")) {
    WaitTimeLiveActivityWidget()
} contentStates: {
    for i in stride(from: 4, through: 1, by: -1) {
        let progress = (10 - Double(i)) / 10.0
        WaitlistAttributes.ContentState(position: i, progress: progress)
    }
}


