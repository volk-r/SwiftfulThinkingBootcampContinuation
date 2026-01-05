//
//  TimerBootcamp.swift
//  SwiftfulThinkingBootcampContinuation
//
//  Created by Roman Romanov on 05.01.2026.
//

import SwiftUI
import Combine

struct TimerBootcamp: View {

//	let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
	let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()

	// Current time
	/*
	@State private var currentDate = Date()
	private var dateFormatter: DateFormatter {
		let formatter = DateFormatter()
//		formatter.dateStyle = .medium
		formatter.timeStyle = .medium
		return formatter
	}
	 */

	// Countdown
	/*
	@State private var count: Int = 10
	@State private var finishedText: String?
	 */

	// Countdown to Date
	/*
	@State private var timeRemaining: String = ""
	let futureDate: Date = Calendar.current.date(byAdding: .day, value: 1, to: Date()) ?? Date()

	func updateTimeRemaining() {
		let remaining = Calendar.current.dateComponents([.hour, .minute, .second], from: Date(), to: futureDate)
		let hour = remaining.hour ?? 0
		let minute = remaining.minute ?? 0
		let second = remaining.second ?? 0
		timeRemaining = "\(hour):\(minute):\(second)"
	}
	*/

	// Animation counter
	@State private var count: Int = 1

    var body: some View {
		ZStack {
			RadialGradient(
				gradient: Gradient(colors: [Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)), Color(#colorLiteral(red: 0.09019608051, green: 0, blue: 0.3019607961, alpha: 1))]),
				center: .center,
				startRadius: 5,
				endRadius: 500
			)
			.ignoresSafeArea()

//			Text(dateFormatter.string(from: currentDate))
//			Text(finishedText ?? "\(count)")
//			Text(timeRemaining)
//				.font(.system(size: 100, weight: .semibold, design: .rounded))
//				.foregroundStyle(.white)
//				.lineLimit(1)
//				.minimumScaleFactor(0.1)

//			HStack(spacing: 15) {
//				Circle()
//					.offset(y: count == 1 ? -20 : 0)
//				Circle()
//					.offset(y: count == 2 ? -20 : 0)
//				Circle()
//					.offset(y: count == 3 ? -20 : 0)
//			}
//			.frame(width: 150)
//			.foregroundStyle(.white)

			TabView(selection: $count,
					content: {
				Rectangle()
					.foregroundColor(.red)
					.tag(1)

				Rectangle()
					.foregroundColor(.blue)
					.tag(2)

				Rectangle()
					.foregroundColor(.green)
					.tag(3)

				Rectangle()
					.foregroundColor(.orange)
					.tag(4)

				Rectangle()
					.foregroundColor(.pink)
					.tag(5)
			})
			.frame(height: 200)
			.tabViewStyle(PageTabViewStyle())
		}
//		.onReceive(timer) { value in
//			currentDate = value
//		}
//		.onReceive(timer) { _ in
//			if count <= 1 {
//				finishedText = "Wow!"
//			} else {
//				count -= 1
//			}
//		}
//		.onReceive(timer) { _ in
//			updateTimeRemaining()
//		}
		.onReceive(timer) { _ in
//			withAnimation(.easeIn(duration: 0.5)) {
			withAnimation {
//				count = count == 3 ? 0 : count + 1
				count = count == 5 ? 1 : count + 1
			}
		}
    }
}

#Preview {
    TimerBootcamp()
}
