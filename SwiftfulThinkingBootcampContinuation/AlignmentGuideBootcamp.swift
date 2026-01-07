//
//  AlignmentGuideBootcamp.swift
//  SwiftfulThinkingBootcampContinuation
//
//  Created by Roman Romanov on 07.01.2026.
//

import SwiftUI

// https://swiftui-lab.com/alignment-guides/

struct AlignmentGuideBootcamp: View {
    var body: some View {
		VStack(alignment: .leading) {
			Text("Hello, World!")
				.background(.blue)
				.alignmentGuide(.leading) { dimension in dimension.width * 0.5 }

			Text("Some other text")
				.background(.red)
		}
		.background(.orange)
    }
}

struct AlignmentGuideChildren: View {
	var body: some View {
		VStack(alignment: .leading, spacing: 20) {
			row(title: "Row 1", showIcon: false)
			row(title: "Row 2", showIcon: true)
			row(title: "Row 3", showIcon: false)
		}
		.padding(16)
		.background(.white)
		.clipShape(RoundedRectangle(cornerRadius: 10))
		.shadow(radius: 10)
		.padding(40)
	}

	private func row(title: String, showIcon: Bool) -> some View {
		HStack(spacing: 10) {
			if showIcon {
				Image(systemName: "info.circle")
					.frame(width: 30, height: 30)
			}

			Text(title)

			Spacer()
		}
//		.background(.red)
		.alignmentGuide(.leading) { dimension in
			showIcon ? 40 : 0 // HStack spacing: 10 + frame width: 30
		}
	}
}

#Preview {
	AlignmentGuideChildren()
}

#Preview {
    AlignmentGuideBootcamp()
}
