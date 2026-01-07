//
//  AccessibilityTextBootcamp.swift
//  SwiftfulThinkingBootcampContinuation
//
//  Created by Roman Romanov on 06.01.2026.
//

import SwiftUI

struct AccessibilityTextBootcamp: View {

	@Environment(\.sizeCategory) var sizeCategory

    var body: some View {
		NavigationStack {
			List {
				ForEach(0..<10) {_ in 
					VStack(alignment: .leading, spacing: 8) {
						HStack {
							Image(systemName: "heart.fill")
								.font(.system(size: 20))
							Text("Welcome to my app")
						}
						.font(.title)

						Text("This is some longest text that expands to multiple lines.")
//							.font(.system(size: 20))
							.font(.headline)
							.frame(maxWidth: .infinity, alignment: .leading)
							.lineLimit(3)
							.minimumScaleFactor(sizeCategory.customMinScaleFactor)
					}
//					.frame(height: 100)
					.background(.red)
				}
			}
			.listStyle(.plain)
			.navigationTitle("Hello, world!")
		}
    }
}

extension ContentSizeCategory {
	var customMinScaleFactor: CGFloat {
		switch self {
		case .extraSmall, .small, .medium:
			return 1
		case .large, .extraLarge, .extraExtraLarge:
			return 0.8
		default:
			return 0.6
		}
	}
}

#Preview {
    AccessibilityTextBootcamp()
}
