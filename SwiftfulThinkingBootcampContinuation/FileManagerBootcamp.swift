//
//  FileManagerBootcamp.swift
//  SwiftfulThinkingBootcampContinuation
//
//  Created by Roman Romanov on 06.01.2026.
//

import SwiftUI

final class LocalFileManager {

	static let instance = LocalFileManager()

	private let folderName = "MyApp_Images"

	private init() {
		createFolderIfNeeded()
	}

	func createFolderIfNeeded() {
		guard
			let path = FileManager
				.default
				.urls(for: .cachesDirectory, in: .userDomainMask)
				.first?
				.appending(path: folderName)
				.path() else {
			return
		}

		if !FileManager.default.fileExists(atPath: path) {
			do {
				try FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: true)
				print("Success creating folder.")
			} catch let error {
				print("Error creating folder. \(error)")
			}
		}
	}

	func deleteFolder() {
		guard
			let path = FileManager
				.default
				.urls(for: .cachesDirectory, in: .userDomainMask)
				.first?
				.appending(path: folderName)
				.path() else {
			return
		}
		do {
			try FileManager.default.removeItem(atPath: path)
			print("Success deleting folder.")
		} catch let error {
			print("Error deleting folder. \(error)")
		}
	}

	func saveImage(image: UIImage, name: String) -> String {
		guard
			let data = image.pngData(),
			let path = getPathForImage(name: name) else {
			return "Error getting data."
		}

		do {
			try data.write(to: path)
			print(path)
			return "Success saving!"
		} catch let error {
			return "Error saving. \(error)"
		}
	}

	func getImage(name: String) -> UIImage? {
		guard
			let path = getPathForImage(name: name)?.path(),
			FileManager.default.fileExists(atPath: path)
		else {
			print("Error getting path.")
			return nil
		}
		return UIImage(contentsOfFile: path)
	}

	func deleteImage(name: String) -> String {
		guard
			let path = getPathForImage(name: name),
			FileManager.default.fileExists(atPath: path.path())
		else {
			return "Error getting path."
		}

		do {
			try FileManager.default.removeItem(at: path)
			return "Success deleting!"
		} catch let error {
			return "Error deleting image. \(error)"
		}
	}

	func getPathForImage(name: String) -> URL? {
		guard
			let path = FileManager
				.default
				.urls(for: .cachesDirectory, in: .userDomainMask)
				.first?
				.appending(path: folderName)
				.appending(path: "\(name).png") else {
			print("Error getting path.")
			return nil
		}
		return path
	}
}

@Observable
final class FileManagerViewModel {

	var image: UIImage?
	var infoMessage: String = ""

	@ObservationIgnored
	private let imageName = "Generic"

	let manager = LocalFileManager.instance

	init() {
		getImageFromAssetsFolder()
//		getImageFromFileManager()
	}

	func getImageFromAssetsFolder() {
		image = UIImage(named: imageName)
	}

	func getImageFromFileManager() {
		image = manager.getImage(name: imageName)
	}

	func saveImage() {
		guard let image else { return }
		infoMessage = manager.saveImage(image: image, name: imageName)
	}

	func deleteImage() {
		infoMessage = manager.deleteImage(name: imageName)
//		manager.deleteFolder()
	}
}

struct FileManagerBootcamp: View {

	@State private var viewModel = FileManagerViewModel()

    var body: some View {
		NavigationStack {
			VStack {
				if let image = viewModel.image {
					Image(uiImage: image)
						.resizable()
						.scaledToFill()
						.frame(width: 200, height: 200)
						.clipped()
						.clipShape(RoundedRectangle(cornerRadius: 10))
				}

				HStack {
					Button(action: {
						viewModel.saveImage()
					}) {
						Text("Save to FM")
							.foregroundStyle(.white)
							.font(.headline)
							.padding()
							.padding(.horizontal)
							.background(.blue)
							.clipShape(RoundedRectangle(cornerRadius: 10))
					}

					Button(action: {
						viewModel.deleteImage()
					}) {
						Text("Delete from FM")
							.foregroundStyle(.white)
							.font(.headline)
							.padding()
							.padding(.horizontal)
							.background(.red)
							.clipShape(RoundedRectangle(cornerRadius: 10))
					}
				}

				Text(viewModel.infoMessage)
					.font(.largeTitle)
					.fontWeight(.semibold)
					.foregroundStyle(.purple)

				Spacer()
			}
			.navigationTitle("File Manager")
		}
    }
}

#Preview {
    FileManagerBootcamp()
}
