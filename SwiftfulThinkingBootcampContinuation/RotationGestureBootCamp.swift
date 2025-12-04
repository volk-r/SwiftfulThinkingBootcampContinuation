//
//  RotationGestureBootCamp.swift
//  SwiftfulThinkingBootcampContinuation
//
//  Created by Roman Romanov on 04.12.2025.
//

import SwiftUI

struct RotationGestureBootCamp: View {

	@State var angle: Angle = Angle(degrees: 0)

    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
			.font(.largeTitle)
			.fontWeight(.semibold)
			.foregroundStyle(.white)
			.padding(50)
			.background(Color.blue.cornerRadius(10))
			.rotationEffect(angle)
			.gesture(
				RotationGesture()
					.onChanged { value in
						angle = value
					}
					.onEnded { value in
						withAnimation(.spring) {
							angle = Angle(degrees: 0)
						}
					}
			)
    }
}

#Preview {
    RotationGestureBootCamp()
}
