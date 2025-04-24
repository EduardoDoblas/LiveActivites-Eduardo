//
//  WaitlistAttributes.swift
//  WaitlistDemoExtension
//
//  Created by Eduardo Villarreal on 23/04/25.
//

import Foundation
import ActivityKit
struct WaitlistAttributes : ActivityAttributes {
    public typealias Waitlist = ContentState
    public struct ContentState: Codable, Hashable{
        var position: Int
        var progress: Double
    }
    var waitListName: String
}
