//
//  TypealiasBootcamp.swift
//  SwiftfulThinkingBootcampContinuation
//
//  Created by Roman Romanov on 04.01.2026.
//

import SwiftUI

struct MovieModel {
	let title: String
	let director: String
	let count: Int
}

//struct TVModel {
//	let title: String
//	let director: String
//	let count: Int
//}
typealias TVModel = MovieModel

struct TypealiasBootcamp: View {

//	@State private var item: MovieModel = MovieModel(title: "Title", director: "Joe", count: 5)
	@State private var item: TVModel = TVModel(title: "TV Title", director: "Emily", count: 10)

    var body: some View {
		VStack {
			Text(item.title)
			Text(item.director)
			Text("\(item.count)")
		}
    }
}

#Preview {
    TypealiasBootcamp()
}
