//
//  PhotoModelFileManager.swift
//  SwiftfulThinkingBootcampContinuation
//
//  Created by Roman Romanov on 06.01.2026.
//

import Foundation
import SwiftUI

final class PhotoModelFileManager {

	static let instance = PhotoModelFileManager()

	let folderName = "downloading_photos"

	private init() {
		createFolderIfNeeded()
	}

	func createFolderIfNeeded() {
		guard let url = getFolderPath() else { return }

		if !FileManager.default.fileExists(atPath: url.path) {
			do {
				try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true)
				print("Created folder!")
			} catch let error {
				print("Error creating folder. \(error)")
			}
		}
	}

	private func getFolderPath() -> URL? {
		FileManager
			.default
			.urls(for: .cachesDirectory, in: .userDomainMask)
			.first?
			.appending(path: folderName)
	}

	private func getFolderPath(key: String) -> URL? {
		guard let folder = getFolderPath() else {
			return nil
		}
		return folder.appending(path: key + ".png")
	}

	func add(key: String, value: UIImage) {
		guard
			let data = value.pngData(),
			let url = getFolderPath(key: key)
		else {
			return
		}

		do {
			try data.write(to: url)
		} catch let error {
			print("Error saving to file manager. \(error)")
		}
	}

	func get(key: String) -> UIImage? {
		guard
			let url = getFolderPath(key: key),
			FileManager.default.fileExists(atPath: url.path) else {
			return nil
		}
		return UIImage(contentsOfFile: url.path)
	}
}
