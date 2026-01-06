//
//  PhotoModel.swift
//  SwiftfulThinkingBootcampContinuation
//
//  Created by Roman Romanov on 06.01.2026.
//

import Foundation

struct PhotoModel: Identifiable, Codable {
	var albumId: Int
	var id: Int
	var title: String
	var url: String
	var thumbnailUrl: String
}
