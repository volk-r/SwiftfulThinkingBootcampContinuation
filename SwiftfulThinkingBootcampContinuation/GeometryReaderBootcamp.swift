//
//  GeometryReaderBootcamp.swift
//  SwiftfulThinkingBootcampContinuation
//
//  Created by Roman Romanov on 05.12.2025.
//

import SwiftUI

struct GeometryReaderBootcamp: View {

	func getPercentage(geo: GeometryProxy, containerWidth: CGFloat) -> Double {
		let maxDistance = containerWidth / 2
		let currentX = geo.frame(in: .global).midX
		return 1 - (currentX / maxDistance)
	}

	var body: some View {
		GeometryReader { outerGeo in
			ScrollView(.horizontal, showsIndicators: false) {
				HStack {
					ForEach(1..<20) { index in
						GeometryReader { geometry in
							let pct = getPercentage(geo: geometry, containerWidth: outerGeo.size.width)
							RoundedRectangle(cornerRadius: 20)
								// Example usage: map percentage to a subtle Y-axis 3D rotation
								.rotation3DEffect(
									Angle(degrees: 40 * pct),
									axis: (x: 0, y: 1, z: 0)
								)
						}
						.frame(width: 300, height: 250)
						.padding()
					}
				}
				.padding(35)
			}
		}
//		GeometryReader { geometry in
//			HStack(spacing: 0) {
//				Rectangle()
//					.fill(.red)
//					.frame(width: geometry.size.width * 0.6666)
//
//				Rectangle().fill(.blue)
//			}
//			.ignoresSafeArea()
//		}
	}
}

#Preview {
	GeometryReaderBootcamp()
}
