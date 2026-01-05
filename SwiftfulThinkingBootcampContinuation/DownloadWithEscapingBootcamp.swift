//
//  DownloadWithEscapingBootcamp.swift
//  SwiftfulThinkingBootcampContinuation
//
//  Created by Roman Romanov on 05.01.2026.
//

import SwiftUI

struct PostModel: Identifiable, Codable, Sendable {
	let userId: Int
	let id: Int
	let title: String
	let body: String
}

@Observable
final class DownloadWithEscapingViewModel {

	var posts: [PostModel] = []

	init() {
		getPosts()
	}

	func getPosts() {
		guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }

		downloadData(fromURL: url) { data in
			guard let data else { print("No data returned"); return }
			guard let newPosts = try? JSONDecoder().decode([PostModel].self, from: data) else { return }
			Task { @MainActor in
				self.posts = newPosts
			}
		}
	}

	func downloadData(fromURL url: URL, completion: @escaping (_ data: Data?) -> Void) {
		URLSession.shared.dataTask(with: url) { data, response, error in
			guard
				let data,
				error == nil,
				let response = response as? HTTPURLResponse,
				response.statusCode >= 200 && response.statusCode < 300
			else {
				print("Error downloading data!")
				completion(nil)
				return
			}

			completion(data)
		}.resume()
	}
}

struct DownloadWithEscapingBootcamp: View {

	@State private var viewModel = DownloadWithEscapingViewModel()

    var body: some View {
		List {
			ForEach(viewModel.posts) { post in
				VStack(alignment: .leading) {
					Text(post.title)
						.font(.headline)
					Text(post.body)
						.foregroundStyle(.gray)
				}
			}
		}
    }
}

#Preview {
    DownloadWithEscapingBootcamp()
}
