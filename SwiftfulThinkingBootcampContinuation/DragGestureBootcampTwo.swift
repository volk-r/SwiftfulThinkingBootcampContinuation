//
//  DragGestureBootcampTwo.swift
//  SwiftfulThinkingBootcampContinuation
//
//  Created by Roman Romanov on 04.12.2025.
//

import SwiftUI

struct DragGestureBootcampTwo: View {

	@State private var startingOffsetY: CGFloat = 0
	@State private var currentDragOffsetY: CGFloat = 0
	@State private var endingOffsetY: CGFloat = 0

	var body: some View {
		GeometryReader { proxy in
			ZStack {
				Color.green.ignoresSafeArea()

				MySignUpView()
					.offset(y: startingOffsetY)
					.offset(y: currentDragOffsetY)
					.offset(y: endingOffsetY)
					.gesture(
						DragGesture()
							.onChanged { value in
								withAnimation(.spring) {
									currentDragOffsetY = value.translation.height
								}
							}
							.onEnded { value in
								withAnimation(.spring) {
									if currentDragOffsetY < -150 {
										endingOffsetY = -startingOffsetY
									} else if endingOffsetY != 0 && currentDragOffsetY > 150 {
										endingOffsetY = 0
									}
									currentDragOffsetY = 0
								}
							}
					)
			}
			.ignoresSafeArea(edges: .bottom)
			.onAppear {
				startingOffsetY = proxy.size.height * 0.94
			}
		}
	}

	struct MySignUpView: View {
		var body: some View {
			VStack(spacing: 20) {
				Image(systemName: "chevron.up")
					.padding(.top)
				Text("Sign up")
					.font(.headline)
					.fontWeight(.semibold)

				Image(systemName: "flame.fill")
					.resizable()
					.scaledToFit()
					.frame(width: 100, height: 100)

				Text("This is description for our app. This is my favourite SwiftUI course and I recommend to all of my friends to subscribe to volk-r!")
					.multilineTextAlignment(.center)

				Text("CREATE AN ACCOUNT")
					.foregroundStyle(.white)
					.padding()
					.padding(.horizontal)
					.background(
						Color.black.clipShape(
							RoundedRectangle(cornerRadius: 10)
						)
					)
				Spacer()
			}
			.frame(maxWidth: .infinity)
			.background(
				Color.white.clipShape(
					RoundedRectangle(cornerRadius: 30)
				)
			)
		}
	}
}

#Preview {
	DragGestureBootcampTwo()
}
