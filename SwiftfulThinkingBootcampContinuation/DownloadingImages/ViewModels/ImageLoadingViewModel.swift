//
//  ImageLoadingViewModel.swift
//  SwiftfulThinkingBootcampContinuation
//
//  Created by Roman Romanov on 06.01.2026.
//

import SwiftUI
import Combine

final class ImageLoadingViewModel: ObservableObject {

	@Published var image: UIImage?
	@Published var isLoading: Bool = false

	let urlString: String
	let imageKey: String

	private var cancellabels: Set<AnyCancellable> = []

//	private let manager = PhotoModelCacheManager.instance
	private let manager = PhotoModelFileManager.instance

	init(url: String, key: String) {
		urlString = url
		imageKey = key
		getImage()
	}

	func getImage() {
		if let savedImager = manager.get(key: imageKey) {
			image = savedImager
			print("Getting saved image!")
		} else {
			downloadImage()
			print("Downloading image now!")
		}
	}

	func downloadImage() {
		isLoading = true

		guard let url = URL(string: urlString) else {
			isLoading = false
			return
		}

		URLSession.shared.dataTaskPublisher(for: url)
			.map { UIImage(data: $0.data) }
//			.map { (data, response) -> UIImage? in
//				return UIImage(data: data)
//			}
			.receive(on: DispatchQueue.main)
			.sink { [weak self] _ in
				self?.isLoading = false
			} receiveValue: { [weak self] image in
				guard
					let self,
					let image
				else { return }
				self.image = image
				self.manager.add(key: self.imageKey, value: image)
			}
			.store(in: &cancellabels)
	}
}
