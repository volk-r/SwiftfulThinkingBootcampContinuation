//
//  DownloadWithCombine.swift
//  SwiftfulThinkingBootcampContinuation
//
//  Created by Roman Romanov on 05.01.2026.
//

import SwiftUI
import Combine

@Observable
final class DownloadWithCombineViewModel {

	var posts: [PostModel] = []
	var cancellable = Set<AnyCancellable>()

	init() {
		getPosts()
	}

	func getPosts() {
		guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }

		// 1. create the publisher
		// 2. subscribe publisher on background thread
		// 3. recieve on main thread
		// 4. tryMap (check that the data is good)
		// 5. decode (decode data into PostModels)
		// 6. sink (put the item into our app)
		// 7. store (cancel subscription if needed)

		URLSession.shared.dataTaskPublisher(for: url)
			// this not needed rally
//			.subscribe(on: DispatchQueue.global(qos: .background))
			.receive(on: DispatchQueue.main)
			.tryMap(handlerOutput)
			.decode(type: [PostModel].self, decoder: JSONDecoder())
			.replaceError(with: [])
			.sink(receiveValue: { [weak self] posts in
				self?.posts = posts
			})
//			.sink { completion in
//				switch completion {
//				case .finished:
//					print("finished")
//				case .failure(let error):
//					print("There was an error: \(error)")
//				}
//			} receiveValue: { [weak self] posts in
//				self?.posts = posts
//			}
			.store(in: &cancellable)
	}

	func handlerOutput(output: URLSession.DataTaskPublisher.Output) throws -> Data {
		guard
			let response = output.response as? HTTPURLResponse,
			200..<300 ~= response.statusCode else {
			throw URLError(.badServerResponse)
		}
		return output.data
	}
}

struct DownloadWithCombine: View {

	@State private var viewModel = DownloadWithCombineViewModel()

    var body: some View {
		List {
			ForEach(viewModel.posts) { post in
				VStack(alignment: .leading) {
					Text(post.title)
						.font(.headline)
					Text(post.body)
						.foregroundStyle(.gray)
				}
				.frame(maxWidth: .infinity, alignment: .leading)
			}
		}
    }
}

#Preview {
    DownloadWithCombine()
}
