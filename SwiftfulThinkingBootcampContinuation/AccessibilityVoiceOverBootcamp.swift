//
//  AccessibilityVoiceOverBootcamp.swift
//  SwiftfulThinkingBootcampContinuation
//
//  Created by Roman Romanov on 07.01.2026.
//

import SwiftUI

struct AccessibilityVoiceOverBootcamp: View {

	@State private var isActive: Bool = false

    var body: some View {
		NavigationStack {
			Form {
				Section {
					Toggle("Volume", isOn: $isActive)

					HStack {
						Text("Volume")
						Spacer()
//						Text(isActive ? "ON" : "OFF")
						Text(isActive ? "TRUE" : "FALSE")
							.accessibilityHidden(true)
					}
//					.background(.black.opacity(0.001))
					.contentShape(Rectangle())
					.onTapGesture {
						isActive.toggle()
					}
					.accessibilityElement(children: .combine)
					.accessibilityAddTraits(.isButton)

					.accessibilityValue(isActive ? "is on" : "is off")

					.accessibilityHint("Double tap to toggle settings.")
					.accessibilityAction {
						isActive.toggle()
					}

				} header: {
					Text("PREFERENCES")
				}

				Section {
					Button("Favorites") {

					}
					.accessibilityRemoveTraits(.isButton)

					Button {

					} label: {
						Image(systemName: "heart.fill")
					}
					.accessibilityLabel("Favorites")

					Text("Favorites")
						.accessibilityAddTraits(.isButton)
						.onTapGesture {

						}
				} header: {
					Text("APPLICATIONS")
				}

				VStack {
					Text("CONTENT")
						.frame(maxWidth: .infinity, alignment: .leading)
						.foregroundStyle(.secondary)
						.font(.caption)
						.accessibilityAddTraits(.isHeader)

					ScrollView(.horizontal) {
						HStack(spacing: 8) {
							ForEach(0..<10) { x in
								VStack {
									Image("Generic")
										.resizable()
										.scaledToFill()
										.frame(width: 100, height: 100)
										.clipShape(RoundedRectangle(cornerRadius: 10))

									Text("Item \(x)")
								}
								.onTapGesture {

								}
								.accessibilityElement(children: .combine)
								.accessibilityAddTraits(.isButton)
								.accessibilityLabel("Item \(x). Image of generic code.")
								.accessibilityHint("Double tap to open.")
								.accessibilityAction {

								}
							}
						}
					}
					.scrollIndicators(.never)
				}
			}
			.navigationTitle("Settings")
		}
    }
}

#Preview {
    AccessibilityVoiceOverBootcamp()
}
