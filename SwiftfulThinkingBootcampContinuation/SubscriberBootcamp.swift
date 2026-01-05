//
//  SubscriberBootcamp.swift
//  SwiftfulThinkingBootcampContinuation
//
//  Created by Roman Romanov on 05.01.2026.
//

import SwiftUI
import Combine

@Observable
final class SubscriberViewModel {

	var count: Int = 0  {
		didSet { countSubject.send(count) }
	}
	var textFieldText: String = "" {
		didSet {
			textFieldSubject.send(textFieldText)
		}
	}
	var textIsValid: Bool = false  {
		didSet {
			textIsValidSubject.send(textIsValid)
		}
	}
	var showButton: Bool = false

	@ObservationIgnored
	private let textFieldSubject = CurrentValueSubject<String, Never>("")

	@ObservationIgnored
	private let countSubject = CurrentValueSubject<Int, Never>(0)
	@ObservationIgnored
	private let textIsValidSubject = CurrentValueSubject<Bool, Never>(false)

	@ObservationIgnored
	private var cancellables = Set<AnyCancellable>()

	init() {
		setupTimer()
		addTextFieldSubscriber()
		addButtonSubscriber()
	}

	func addTextFieldSubscriber() {
		textFieldSubject
			.debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
			.map { $0.count > 3 }
//			.assign(to: \.textIsValid, on: self)
			.sink { [weak self] isValid in
				self?.textIsValid = isValid
			}
			.store(in: &cancellables)
	}

	func setupTimer() {
		Timer
			.publish(every: 1, on: .main, in: .common)
			.autoconnect()
			.sink { [weak self] _ in
				guard let self else { return }
				self.count += 1
			}
			.store(in: &cancellables)
	}

	func addButtonSubscriber() {
		textIsValidSubject
			.combineLatest(countSubject)
			.sink { [weak self] isValid, count in
				self?.showButton = isValid && count >= 10
			}
			.store(in: &cancellables)
	}
}

struct SubscriberBootcamp: View {

	@State private var viewModel = SubscriberViewModel()

    var body: some View {
		VStack {
			Text("\(viewModel.count)")
				.font(.largeTitle)

			Text(viewModel.textIsValid.description)

			TextField("Type something here...", text: $viewModel.textFieldText)
				.padding(.leading)
				.frame(height: 55)
				.font(.headline)
				.background(Color(#colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)))
				.clipShape(RoundedRectangle(cornerRadius: 10))
				.overlay(
					ZStack {
						Image(systemName: "xmark")
							.foregroundStyle(.red)
							.opacity(
								viewModel.textFieldText.count < 1 ? 0 :
								viewModel.textIsValid ? 0 : 1)

						Image(systemName: "checkmark")
							.foregroundStyle(.green)
							.opacity(viewModel.textIsValid ? 1 : 0)
					}
					.font(.headline)
					.padding(.trailing)

					, alignment: .trailing
				)

			Button(action: {}) {
				Text("Submit".uppercased())
					.font(.headline)
					.frame(height: 55)
					.frame(maxWidth: .infinity)
					.foregroundStyle(.white)
					.background(.blue)
					.clipShape(RoundedRectangle(cornerRadius: 10))
					.opacity(viewModel.showButton ? 1 : 0.5)
			}
			.disabled(!viewModel.showButton)
		}
		.padding()
    }
}

#Preview {
    SubscriberBootcamp()
}
