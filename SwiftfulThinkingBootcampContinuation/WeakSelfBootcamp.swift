//
//  WeakSelfBootcamp.swift
//  SwiftfulThinkingBootcampContinuation
//
//  Created by Roman Romanov on 04.01.2026.
//

import SwiftUI

enum Route: Hashable {
	case second
}

struct WeakSelfBootcamp: View {

	@State private var path = NavigationPath()

	@AppStorage("count") private var count: Int?

	init() {
		count = 0
	}

	var body: some View {
		NavigationStack(path: $path) {
			Button("Navigate") {
				path.append(Route.second)
			}
			.navigationTitle("Screen One")
			.navigationDestination(for: Route.self) { route in
				switch route {
				case .second:
					WeakSelfSecondScreen()
				}
			}
		}
		.overlay(
			Text("\(count ?? 0)")
				.font(.largeTitle)
				.padding()
				.background(
					Color.green
						.clipShape(RoundedRectangle(cornerRadius: 10))
				)
			, alignment: .topTrailing
		)
	}
}

struct WeakSelfSecondScreen: View {

	@State private var viewModel = WeakSelfSecondScreenViewModel()

	var body: some View {
		VStack {
			Text("Second View")
				.font(.largeTitle)
				.foregroundColor(.red)
				.navigationTitle("Screen Two")

			if let data = viewModel.data {
				Text(data)
			}
		}
	}
}

@Observable
class WeakSelfSecondScreenViewModel {

	var data: String?

	init() {
		print("INITIALIZE NOW")
		let currentCount = UserDefaults.standard.integer(forKey: "count")
		UserDefaults.standard.set(currentCount + 1, forKey: "count")
		getData()
	}

	deinit {
		print("DEINITIALIZE NOW")
		let currentCount = UserDefaults.standard.integer(forKey: "count")
		UserDefaults.standard.set(currentCount - 1, forKey: "count")
	}

	func getData() {
		DispatchQueue.main.asyncAfter(deadline: .now() + 500) { [weak self] in
			self?.data = "NEW DATA!!!"
		}
	}
}

#Preview {
	WeakSelfBootcamp()
}
