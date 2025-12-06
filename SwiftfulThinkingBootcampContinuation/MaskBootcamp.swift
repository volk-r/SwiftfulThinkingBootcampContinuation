//
//  MaskBootcamp.swift
//  SwiftfulThinkingBootcampContinuation
//
//  Created by Roman Romanov on 06.12.2025.
//

import SwiftUI

struct MaskBootcamp: View {

	@State var rating: Int = 0

    var body: some View {
		ZStack {
			starsView
				.overlay(overlayView.mask(starsView))
		}
    }

	private var overlayView: some View {
		GeometryReader { geometry in
			ZStack(alignment: .leading) {
				Rectangle()
//					.foregroundStyle(.yellow)
					.fill(LinearGradient(colors: [.yellow, .red], startPoint: .leading, endPoint: .trailing))
					.frame(width: CGFloat(rating) / 5 * geometry.size.width)
			}
		}
		.allowsHitTesting(false)
	}

	private var starsView: some View {
		HStack {
			ForEach(1...5, id: \.self) { index in
				Image(systemName: "star.fill")
					.font(.largeTitle)
					.foregroundStyle(.gray)
					.onTapGesture {
						withAnimation(.easeOut) {
							rating = index
						}
					}
			}
		}
	}
}

#Preview {
    MaskBootcamp()
}
