//
//  LocalNotificationBootcamp.swift
//  SwiftfulThinkingBootcampContinuation
//
//  Created by Roman Romanov on 07.12.2025.
//

import CoreLocation
import SwiftUI
import UserNotifications

class NotificationManager {

	static let instance = NotificationManager()

	func requestAuthorization() {
		let options: UNAuthorizationOptions = [.alert, .badge, .sound]
		UNUserNotificationCenter.current().requestAuthorization(options: options) { granted, error in
			if let error {
				print("ERROR: \(error)")
			} else {
				print("SUCCESS")
			}
		}
	}

	func scheduleNotification() {
		let content = UNMutableNotificationContent()
		content.title = "Hello, World!"
		content.subtitle = "Swiftful Thinking Bootcamp"
		content.sound = .default
		content.badge = 1
		content.body = "This is a test notification."

		// time
//		let trigger = UNTimeIntervalNotificationTrigger(
//			timeInterval: 5,
//			repeats: false
//		)

		// calendar
//		var dateComponents = DateComponents()
//		dateComponents.calendar = Calendar.current
//		dateComponents.hour = 11
//		dateComponents.minute = 49
//		let trigger = UNCalendarNotificationTrigger(
//			dateMatching: dateComponents,
//			repeats: true
//		)

		// location
		let coordinates = CLLocationCoordinate2D(
			latitude: 40.00,
			longitude: 50.00
		)
		let region = CLCircularRegion(
			center: coordinates,
			radius: 100,
			identifier: UUID().uuidString
		)
		region.notifyOnEntry = true
		region.notifyOnExit = true
		let trigger = UNLocationNotificationTrigger(
			region: region,
			repeats: true
		)

		let request = UNNotificationRequest(
			identifier: UUID().uuidString,
			content: content,
			trigger: trigger
		)
		UNUserNotificationCenter.current().add(request)
	}

	func cancelNotification() {
		UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
		UNUserNotificationCenter.current().removeAllDeliveredNotifications()
	}
}

struct LocalNotificationBootcamp: View {

	@Environment(\.scenePhase) var scenePhase

    var body: some View {
		VStack(spacing: 40) {
			Button("Request permission") {
				NotificationManager.instance.requestAuthorization()
			}
			Button("Schedule notification") {
				NotificationManager.instance.scheduleNotification()
			}
			Button("Cancel notification") {
				NotificationManager.instance.cancelNotification()
			}
		}
		.onChange(of: scenePhase) { oldValue, newValue in
			if newValue == .active {
				UNUserNotificationCenter.current().setBadgeCount(0)
			}
		}

    }
}

#Preview {
    LocalNotificationBootcamp()
}
