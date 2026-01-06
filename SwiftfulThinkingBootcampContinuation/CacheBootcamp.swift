//
//  CacheBootcamp.swift
//  SwiftfulThinkingBootcampContinuation
//
//  Created by Roman Romanov on 06.01.2026.
//

import SwiftUI

final class CacheManager {

	static let instance = CacheManager()

	var imageCache: NSCache<NSString, UIImage> = {
		let cache = NSCache<NSString, UIImage>()
		cache.countLimit = 100
		cache.totalCostLimit = 1024 * 1024 * 100 // 100 mb
		return cache
	}()

	private init() {}

	func add(image: UIImage, name: String) -> String {
		imageCache.setObject(image, forKey: name as NSString)
		return "Added to cache!"
	}

	func remove(name: String) -> String {
		imageCache.removeObject(forKey: name as NSString)
		return "Remove from cache!"
	}

	func get(name: String) -> UIImage? {
		imageCache.object(forKey: name as NSString)
	}
}

@Observable
final class CacheViewModel {

	var startingImage: UIImage?
	var cachedImage: UIImage?
	var infoMessage: String = ""

	private let imageName: String = "Generic"
	private let manager = CacheManager.instance

	init() {
		getImageFromAssetsFolder()
	}

	func getImageFromAssetsFolder() {
		startingImage = UIImage(named: imageName)
	}

	func saveToCache () {
		guard let image = startingImage else { return }
		infoMessage = manager.add(image: image, name: imageName)
	}

	func removeFromCache() {
		infoMessage = manager.remove(name: imageName)
	}

	func getFromCache() {
		if let returnedImage = manager.get(name: imageName) {
			cachedImage = returnedImage
			infoMessage = "Got image from Cache"
		} else {
			infoMessage = "Image not found in Cache"
		}
	}
}

struct CacheBootcamp: View {

	@State private var viewModel = CacheViewModel()

    var body: some View {
		NavigationView {
			VStack {
				if let image = viewModel.startingImage {
					Image(uiImage: image)
						.resizable()
						.scaledToFill()
						.frame(width: 200, height: 200)
						.clipped()
						.clipShape(RoundedRectangle(cornerRadius: 10))
				}

				Text(viewModel.infoMessage)
					.font(.headline)
					.foregroundStyle(.purple)

				HStack {
					Button {
						viewModel.saveToCache()
					} label: {
						Text("Save to Cache")
							.font(.headline)
							.foregroundStyle(.white)
							.padding()
							.background(.blue)
							.clipShape(RoundedRectangle(cornerRadius: 10))
					}

					Button {
						viewModel.removeFromCache()
					} label: {
						Text("Delete from Cache")
							.font(.headline)
							.foregroundStyle(.white)
							.padding()
							.background(.red)
							.clipShape(RoundedRectangle(cornerRadius: 10))
					}

					Button {
						viewModel.getFromCache()
					} label: {
						Text("Get from Cache")
							.font(.headline)
							.foregroundStyle(.white)
							.padding()
							.background(.green)
							.clipShape(RoundedRectangle(cornerRadius: 10))
					}
				}

				if let image = viewModel.cachedImage {
					Image(uiImage: image)
						.resizable()
						.scaledToFill()
						.frame(width: 200, height: 200)
						.clipped()
						.clipShape(RoundedRectangle(cornerRadius: 10))
				}

				Spacer()
			}
			.navigationTitle("Cache Bootcamp")
		}
    }
}

#Preview {
    CacheBootcamp()
}
