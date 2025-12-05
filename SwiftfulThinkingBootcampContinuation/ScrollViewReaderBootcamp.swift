//
//  ScrollViewReaderBootcamp.swift
//  SwiftfulThinkingBootcampContinuation
//
//  Created by Roman Romanov on 05.12.2025.
//

import SwiftUI

struct ScrollViewReaderBootcamp: View {

	@State var scrollToIndex: Int = 0
	@State var textFieldText: String = ""

    var body: some View {
		VStack {
			TextField("Enter a # here...", text: $textFieldText)
				.frame(height: 55)
				.border(.gray)
				.padding(.horizontal)
				.keyboardType(.numberPad)

			Button("SCROLL NOW") {
				if let index = Int(textFieldText) {
					scrollToIndex = index
				}
			}

			ScrollView {
				ScrollViewReader { proxy in
					ForEach(1..<50) { index in
						Text("This is item #\(index)")
							.font(.headline)
							.frame(height: 200)
							.frame(maxWidth: .infinity)
							.background(.white)
							.clipShape(RoundedRectangle(cornerRadius: 10))
							.shadow(radius: 10)
							.padding()
							.id(index)
					}
					.onChange(of: scrollToIndex) { oldValue, newValue in
						withAnimation(.spring) {
							proxy.scrollTo(newValue, anchor: .top)
						}
					}
				}
			}
		}
    }
}

#Preview {
    ScrollViewReaderBootcamp()
}
