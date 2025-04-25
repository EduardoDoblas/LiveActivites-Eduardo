//
//  LiveActivityManger.swift
//  DinamicIsland
//
//  Created by Eduardo Villarreal on 24/04/25.
//

import Foundation
import ActivityKit

class LiveActivityManager {
    static let shared = LiveActivityManager()
    private var activity: Activity<WaitlistAttributes>?

    private init() {}

    func startActivity(waitlistName: String, position: Int, progress: Double) {
        if ActivityAuthorizationInfo().areActivitiesEnabled {
            // Define el estado inicial y atributos
            //let attributes = WaitlistAttributes(waitListName:"Dinner Queue")
            let attributes = WaitlistAttributes(waitListName: waitlistName)
            let initialState = WaitlistAttributes.Waitlist(position: position, progress: progress)
            let contentState = ActivityContent(state: initialState, staleDate: nil)
            // Inicia el Live Activity
            do {
                let activity = try Activity<WaitlistAttributes>.request(
                    attributes: attributes,
                    content: .init(state: initialState, staleDate: nil)
                )
                self.activity = activity
                print("Live activity started: \(activity.id)")
            } catch {
                print("Error al iniciar la actividad: \(error)")
            }
        }
    }

    func updateActivity(position: Int, progress: Double) {
        guard let activity = activity else {return}
        let updatedContent = WaitlistAttributes.Waitlist(position: position, progress: progress)
        Task{
            await activity.update(ActivityContent(state: updatedContent, staleDate: nil))
            print("Live activites updated...")
        }
    }

    func endActivity(position: Int, progress: Double) {
        guard let activity = activity else {return}
        let endContent = WaitlistAttributes.ContentState(position: position, progress: progress)
        Task{
            await activity.end(ActivityContent(state: endContent, staleDate: nil),dismissalPolicy: .immediate)
            print("Live activited Removed")
        }
    }
}
