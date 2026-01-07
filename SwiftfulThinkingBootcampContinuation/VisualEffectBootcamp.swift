//
//  VisualEffectBootcamp.swift
//  SwiftfulThinkingBootcampContinuation
//
//  Created by Roman Romanov on 07.01.2026.
//

import SwiftUI

@available(iOS 17, *)
struct VisualEffectBootcamp: View {

	@State private var showSpacer: Bool = false

    var body: some View {
		ScrollView {
			VStack(spacing: 30) {
				ForEach(0..<100) { index in
					Rectangle()
						.frame(width: 300, height: 200)
						.frame(maxWidth: .infinity)
						.background(.orange)
						.visualEffect { content, geometry in
							content
								.offset(x: geometry.frame(in: .global).minY * 0.5)
						}
				}
			}
		}

//		VStack {
//			Text("Hello, World! xdvxd xdvxd xdvxd xdvxd")
//				.padding()
//				.background(.red)
//				.visualEffect { content, geometry in
//					content
//						.grayscale(geometry.frame(in: .global).minY <= 300 ? 1 : 0)
////						.grayscale(geometry.size.width >= 200 ? 1 : 0)
//				}
//
//			if showSpacer {
//				Spacer()
//			}
//		}
//		.animation(.easeIn, value: showSpacer)
//		.onTapGesture {
//			showSpacer.toggle()
//		}
    }
}

@available(iOS 17, *)
#Preview {
    VisualEffectBootcamp()
}
