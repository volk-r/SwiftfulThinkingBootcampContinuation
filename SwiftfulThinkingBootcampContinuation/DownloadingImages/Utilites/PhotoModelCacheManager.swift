//
//  PhotoModelCacheManager.swift
//  SwiftfulThinkingBootcampContinuation
//
//  Created by Roman Romanov on 06.01.2026.
//

import Foundation
import SwiftUI

final class PhotoModelCacheManager {

	static let instance = PhotoModelCacheManager()

	private var photoCache: NSCache<NSString, UIImage> = {
		var cache = NSCache<NSString, UIImage>()
		cache.countLimit = 200
		cache.totalCostLimit = 1024 * 1024 * 200 // 200 mb
		return cache
	}()

	private init() {}

	func add(key: String, value: UIImage) {
		photoCache.setObject(value, forKey: key as NSString)
	}

	func get(key: String) -> UIImage? {
		photoCache.object(forKey: key as NSString)
	}
}
