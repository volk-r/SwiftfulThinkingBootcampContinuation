//
//  ArraysBootcamp.swift
//  SwiftfulThinkingBootcampContinuation
//
//  Created by Roman Romanov on 07.12.2025.
//

import SwiftUI

struct UserModel: Identifiable {
	let id = UUID().uuidString
	let name: String?
	let points: Int
	let isVerified: Bool
}

@Observable
final class ArrayModificationViewModel {

	var dataArray: [UserModel] = []
	var filteresArray: [UserModel] = []
	var mappedArray: [String] = []

	init() {
		getUsers()
		updateFilteredArray()
	}

	func updateFilteredArray() {
		// sort
//		filteresArray = dataArray.sorted(by: { $0.points > $1.points })
		// filter
//		filteresArray = dataArray.filter{ $0.isVerified }
		// map
//		mappedArray = dataArray.map{ $0.name ?? "ERROR" }
//		mappedArray = dataArray.compactMap{ $0.name }

		mappedArray = dataArray
			.sorted(by: { $0.points > $1.points })
			.filter{ $0.isVerified }
			.compactMap{ $0.name }
	}

	func getUsers() {
		let user1 = UserModel(name: "Nick", points: 5, isVerified: true)
		let user2 = UserModel(name: "Cris", points: 0, isVerified: false)
		let user3 = UserModel(name: nil, points: 20, isVerified: true)
		let user4 = UserModel(name: "Emily", points: 50, isVerified: false)
		let user5 = UserModel(name: "Samantha", points: 45, isVerified: true)
		let user6 = UserModel(name: "Jason", points: 23, isVerified: false)
		let user7 = UserModel(name: "Sarah", points: 76, isVerified: true)
		let user8 = UserModel(name: nil, points: 45, isVerified: false)
		let user9 = UserModel(name: "Steve", points: 1, isVerified: true)
		let user10 = UserModel(name: "Amanda", points: 100, isVerified: false)
		dataArray.append(contentsOf: [
			user1,
			user2,
			user3,
			user4,
			user5,
			user6,
			user7,
			user8,
			user9,
			user10
		])
	}
}

struct ArraysBootcamp: View {

	@State private var viewModel = ArrayModificationViewModel()

    var body: some View {
        ScrollView {
			VStack(spacing: 10) {
				ForEach(viewModel.mappedArray, id: \.self) { name in
					Text(name)
						.font(.title)
				}
//				ForEach(viewModel.filteresArray) { user in
//					VStack(alignment: .leading) {
//						Text(user.name)
//							.font(.headline)
//						HStack {
//							Text("Pints: \(user.points)")
//							Spacer()
//							if user.isVerified {
//								Image(systemName: "flame.fill")
//							}
//						}
//					}
//					.foregroundStyle(.white)
//					.padding()
//					.background(Color.blue.clipShape(RoundedRectangle(cornerRadius: 10)))
//					.padding(.horizontal)
//				}
			}
		}
    }
}

#Preview {
    ArraysBootcamp()
}
