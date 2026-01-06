//
//  DownloadingImageView.swift
//  SwiftfulThinkingBootcampContinuation
//
//  Created by Roman Romanov on 06.01.2026.
//

import SwiftUI

struct DownloadingImageView: View {

	@StateObject private var loader: ImageLoadingViewModel

	init(url: String, key: String) {
		_loader = StateObject(wrappedValue: ImageLoadingViewModel(url: url, key: key))
	}

    var body: some View {
		ZStack {
			if loader.isLoading {
				ProgressView()
			} else if let image = loader.image {
				Image(uiImage: image)
					.resizable()
					.clipShape(Circle())
			}
		}
    }
}

#Preview {
	DownloadingImageView(url: "https://images.pexels.com/photos/31374567/pexels-photo-31374567.jpeg", key: "1")
		.frame(width: 400, height: 400)
}
