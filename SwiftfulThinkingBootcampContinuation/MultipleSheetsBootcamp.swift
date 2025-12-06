//
//  MultipleSheetsBootcamp.swift
//  SwiftfulThinkingBootcampContinuation
//
//  Created by Roman Romanov on 06.12.2025.
//

import SwiftUI

struct RandomModel: Identifiable {
	let id = UUID().uuidString
	let title: String
}

// Solutions:
// 1 - use a binding
// 2 - use multiple .sheets (deprecated)
// 3 - use $item

struct MultipleSheetsBootcamp: View {

	@State var selectedModel: RandomModel?

    var body: some View {
		ScrollView {
			VStack(spacing: 20) {
				ForEach(1..<50) { index in
					Button("Button \(index)") {
						selectedModel = RandomModel(title: "\(index)")
					}
				}
			}
			.sheet(item: $selectedModel) { model in
				NextScreen(selectedModel: model)
			}
		}
    }
}

struct NextScreen: View {

	let selectedModel: RandomModel

	var body: some View {
		Text(selectedModel.title)
			.font(.largeTitle)
	}
}

#Preview {
    MultipleSheetsBootcamp()
}
