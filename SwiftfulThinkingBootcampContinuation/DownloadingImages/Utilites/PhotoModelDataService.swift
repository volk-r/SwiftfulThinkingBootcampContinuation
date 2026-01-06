//
//  PhotoModelDataService.swift
//  SwiftfulThinkingBootcampContinuation
//
//  Created by Roman Romanov on 06.01.2026.
//

import Foundation
import Combine

final class PhotoModelDataService {

	static let instance = PhotoModelDataService()

	@Published var photoModels: [PhotoModel] = []

	private var cancellables: Set<AnyCancellable> = []

	private init() {
		downloadData()
	}

	func downloadData() {
		guard let url = URL(string: "https://jsonplaceholder.typicode.com/photos") else { return }

		URLSession.shared.dataTaskPublisher(for: url)
			.subscribe(on: DispatchQueue.global(qos: .background))
			.receive(on: DispatchQueue.main)
			.tryMap(handleOutput)
			.decode(type: [PhotoModel].self, decoder: JSONDecoder())
			.sink { completion in
				switch completion {
				case .failure(let error):
					print("Error downloading data. \(error)")
				case .finished:
					break
				}
			} receiveValue: { [weak self] photoModels in
				self?.photoModels = photoModels
			}
			.store(in: &cancellables)
	}

	private func handleOutput(output: URLSession.DataTaskPublisher.Output) throws -> Data {
		guard
			let response = output.response as? HTTPURLResponse,
			200..<300 ~= response.statusCode else {
			throw URLError(.badServerResponse)
		}
		return output.data
	}
}
