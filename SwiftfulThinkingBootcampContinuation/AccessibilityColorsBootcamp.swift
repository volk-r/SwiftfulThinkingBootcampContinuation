//
//  AccessibilityColorsBootcamp.swift
//  SwiftfulThinkingBootcampContinuation
//
//  Created by Roman Romanov on 07.01.2026.
//

import SwiftUI

struct AccessibilityColorsBootcamp: View {

	@Environment(\.accessibilityReduceTransparency) private var reduceTransparency
	@Environment(\.colorSchemeContrast) private var colorSchemeContrast
	@Environment(\.accessibilityDifferentiateWithoutColor) private var differentiateWithoutColor
	@Environment(\.accessibilityInvertColors) private var invertColors

    var body: some View {
		NavigationStack {
			VStack {
				Button("Button 1") {
					
				}
				.foregroundStyle(colorSchemeContrast == .increased ? .white : .primary)
				.buttonStyle(.borderedProminent)
				
				Button("Button 2") {
					
				}
				.foregroundStyle(.primary)
				.buttonStyle(.borderedProminent)
				.tint(.orange)
				
				Button("Button 3") {
					
				}
				.foregroundStyle(.white)
				.foregroundStyle(.primary)
				.buttonStyle(.borderedProminent)
				.tint(.green)
				
				Button("Button 4") {
					
				}
				.foregroundStyle(differentiateWithoutColor ? .white : .green)
				.foregroundStyle(.primary)
				.buttonStyle(.borderedProminent)
				.tint(differentiateWithoutColor ? .black : .purple)
			}
			.font(.largeTitle)
//			.navigationTitle("Hi")
			.frame(maxWidth: .infinity, maxHeight: .infinity)
			.background(reduceTransparency ? .black : .black.opacity(0.5))
		}
    }
}

#Preview {
    AccessibilityColorsBootcamp()
}
