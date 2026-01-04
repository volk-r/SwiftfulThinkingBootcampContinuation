//
//  EscapingBootcamp.swift
//  SwiftfulThinkingBootcampContinuation
//
//  Created by Roman Romanov on 04.01.2026.
//

import SwiftUI

@Observable
final class EscapingViewModel {

	var text: String = "Hello"

	func getData() {
//		let newData = downloadData()
//		text = newData

//		downloadData2() { data in
//			self.text = data
//		}

//		downloadData3() { [weak self] data in
//			self?.text = data
//		}

//		downloadData4() { [weak self] result in
//			self?.text = result.data
//		}

		downloadData5() { [weak self] result in
			self?.text = result.data
		}
	}

	func downloadData() -> String {
		"New data!"
	}

	func downloadData2(completion: (_ data: String) -> Void) {
		completion("New data!")
	}

	func downloadData3(completion: @escaping (_ data: String) -> Void) {
		DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
			completion("New data!")
		}
	}

	func downloadData4(completion: @escaping (DownloadResult) -> ()) {
		DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
			let result = DownloadResult(data: "New data!")
			completion(result)
		}
	}

	func downloadData5(completion: @escaping DownloadCompletion) {
		DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
			let result = DownloadResult(data: "New data!")
			completion(result)
		}
	}
}

struct DownloadResult {
	let data: String
}

typealias DownloadCompletion = (DownloadResult) -> Void

struct EscapingBootcamp: View {

	@State private var viewModel = EscapingViewModel()

    var body: some View {
		Text(viewModel.text)
			.font(.largeTitle)
			.fontWeight(.semibold)
			.foregroundStyle(.blue)
			.onTapGesture {
				viewModel.getData()
			}
    }
}

#Preview {
    EscapingBootcamp()
}
