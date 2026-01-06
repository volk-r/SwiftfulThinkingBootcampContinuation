//
//  DownloadingImagesBootcamp.swift
//  SwiftfulThinkingBootcampContinuation
//
//  Created by Roman Romanov on 06.01.2026.
//

import SwiftUI

struct DownloadingImagesBootcamp: View {

	@StateObject private var viewModel = DownloadingImagesViewModel()

    var body: some View {
		NavigationView {
			List {
				ForEach(viewModel.dataArray) { model in
					DownloadingImagesRow(model: model)
				}
			}
			.listStyle(.plain)
			.navigationTitle("Downloading Images!")
		}
    }
}

#Preview {
    DownloadingImagesBootcamp()
}
