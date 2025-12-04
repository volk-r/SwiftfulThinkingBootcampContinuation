//
//  DragGestureBootcamp.swift
//  SwiftfulThinkingBootcampContinuation
//
//  Created by Roman Romanov on 04.12.2025.
//

import SwiftUI

struct DragGestureBootcamp: View {

	@State var offset: CGSize = .zero
	@State private var screenWidth: CGFloat = 0

	var body: some View {
		GeometryReader { proxy in
			ZStack {
				Color.clear
					.onAppear {
						screenWidth = proxy.size.width
					}

				VStack {
					Text("\(offset.width)")
					Spacer()
				}

				RoundedRectangle(cornerRadius: 20)
					.frame(width: 300, height: 500)
					.offset(offset)
					.scaleEffect(getScaleAmount())
					.rotationEffect(Angle(degrees: getRotationAmount()))
					.gesture(
						DragGesture()
							.onChanged { value in
								withAnimation(.spring) {
									offset = value.translation
								}
							}
							.onEnded { value in
								withAnimation(.spring) {
									offset = .zero
								}
							}
					)
			}
		}
	}

	func getScaleAmount() -> CGFloat {
		let max = screenWidth / 2
		let currentAmount = abs(offset.width)
		let percentage = currentAmount / max
		return 1.0 - min(percentage, 0.5) * 0.5
	}

	func getRotationAmount() -> CGFloat {
		let max = screenWidth / 2
		let currentAmount = offset.width
		let percentage = currentAmount / max
		let percentageAsDouble = Double(percentage)
		let maxAngle: Double = 10
		return percentageAsDouble * maxAngle
	}
}

#Preview {
	DragGestureBootcamp()
}
