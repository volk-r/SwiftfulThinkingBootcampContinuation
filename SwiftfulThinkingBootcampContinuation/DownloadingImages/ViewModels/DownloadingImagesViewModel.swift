//
//  DownloadingImagesViewModel.swift
//  SwiftfulThinkingBootcampContinuation
//
//  Created by Roman Romanov on 06.01.2026.
//

import Foundation
import Combine

final class DownloadingImagesViewModel: ObservableObject {

	@Published var dataArray: [PhotoModel] = []

	private let dataService = PhotoModelDataService.instance

	private var cancellables: Set<AnyCancellable> = []

	init() {
		addSubscribers()
	}

	func addSubscribers() {
		dataService.$photoModels
			.sink { [weak self] photoModels in
				self?.dataArray = photoModels
			}
			.store(in: &cancellables)
	}
}
