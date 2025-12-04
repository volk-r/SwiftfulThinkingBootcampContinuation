//
//  LongPressGestureBootCamp.swift
//  SwiftfulThinkingBootcampContinuation
//
//  Created by Roman Romanov on 04.12.2025.
//

import SwiftUI

struct LongPressGestureBootCamp: View {

	@State var isCompleted: Bool = false
	@State var isSuccess: Bool = false

	var body: some View {
		VStack {
			Rectangle()
				.fill(isSuccess ? .green : .blue)
				.frame(maxWidth: isCompleted ? .infinity : 0)
				.frame(height: 55)
				.frame(maxWidth: .infinity, alignment: .leading)
				.background(.gray)

			HStack {
				Text("CLICK HERE")
					.foregroundStyle(.white)
					.padding()
					.background(.black)
					.clipShape(RoundedRectangle(cornerRadius: 10))
					.onLongPressGesture(minimumDuration: 1, maximumDistance: 50) {
						// at the min duration
						withAnimation(.easeOut) {
							isSuccess = true
						}
					} onPressingChanged: { isPressing in
						// start of press -> min duration
						if isPressing {
							withAnimation(.easeOut(duration: 1)) {
								isCompleted = true
							}
						} else {
							DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
								if !isSuccess {
									withAnimation(.easeOut) {
										isCompleted = false
									}
								}
							}
						}
					}


				Text("RESET")
					.foregroundStyle(.white)
					.padding()
					.background(.black)
					.clipShape(RoundedRectangle(cornerRadius: 10))
					.onTapGesture {
						isCompleted = false
						isSuccess = false
					}
			}
		}

//		Text(isCompleted ? "COMPLETED" : "NOT COMPLETED")
//			.padding()
//			.padding(.horizontal)
//			.background(isCompleted ? Color.green : Color.gray)
//			.clipShape(RoundedRectangle(cornerRadius: 10))
////			.onTapGesture {
////				isCompleted.toggle()
////			}
//			.onLongPressGesture(minimumDuration: 1.0, maximumDistance: 1.0) {
//				isCompleted.toggle()
//			}
	}
}

#Preview {
	LongPressGestureBootCamp()
}
