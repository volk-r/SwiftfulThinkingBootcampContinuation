//
//  DownloadingImagesRow.swift
//  SwiftfulThinkingBootcampContinuation
//
//  Created by Roman Romanov on 06.01.2026.
//

import SwiftUI

struct DownloadingImagesRow: View {

	let model: PhotoModel

    var body: some View {
		HStack {
//			DownloadingImageView(url: model.url, key: model.id.description)
			DownloadingImageView(url: "https://images.pexels.com/photos/31374567/pexels-photo-31374567.jpeg", key: model.id.description)
				.frame(width: 75, height: 75)
			VStack(alignment: .leading) {
				Text(model.title)
					.font(.headline)

				Text(model.url)
					.foregroundStyle(.gray)
					.italic()
			}
			.frame(maxWidth: .infinity, alignment: .leading)
		}
    }
}

#Preview(traits: .sizeThatFitsLayout) {
	DownloadingImagesRow(
		model: PhotoModel(
			albumId: 1,
			id: 1,
			title: "title",
			url: "https://images.pexels.com/photos/31374567/pexels-photo-31374567.jpeg",
			thumbnailUrl: "thumbnail url here"
		)
	)
}
