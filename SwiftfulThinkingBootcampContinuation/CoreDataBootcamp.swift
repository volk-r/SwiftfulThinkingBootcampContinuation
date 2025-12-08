//
//  CoreDataBootcamp.swift
//  SwiftfulThinkingBootcampContinuation
//
//  Created by Roman Romanov on 08.12.2025.
//

import CoreData
import Combine
import SwiftUI

final class CoreDataViewModel: ObservableObject {

	@Published var saveEntities: [FruitEntity] = []

	private let container: NSPersistentContainer

	init() {
		container = NSPersistentContainer(name: "FruitsContainer")
		container.loadPersistentStores { description, error in
			if let error {
				print("ERROR LOADING CORE DATA. \(error)")
			}
		}
		fetchFruits()
	}

	func fetchFruits() {
		let request = NSFetchRequest<FruitEntity>(entityName: "FruitEntity")
		do {
			saveEntities = try container.viewContext.fetch(request)
		} catch let error {
			print("Error fetching. \(error)")
		}
	}

	func updateFruit(entity: FruitEntity) {
		let currentName = entity.name ?? ""
		let newName = currentName + "!"
		entity.name = newName
		saveData()
	}

	func addFruit(text: String) {
		let newFruit = FruitEntity(context: container.viewContext)
		newFruit.name = text
		saveData()
	}

	func deleteFruit(indexSet: IndexSet) {
		guard let index = indexSet.first else { return }
		let entity = saveEntities[index]
		container.viewContext.delete(entity)
		saveData()
	}

	func saveData() {
		do {
			try container.viewContext.save()
			fetchFruits()
		} catch let error {
			print("Error saving. \(error)")
		}
	}
}

struct CoreDataBootcamp: View {

	@StateObject private var viewModel = CoreDataViewModel()
	@State private var textFiledText: String = ""

    var body: some View {
		NavigationView {
			VStack(spacing: 20) {
				TextField("Add fruit text...", text: $textFiledText)
					.font(.headline)
					.padding(.leading)
					.frame(height: 55)
					.background(Color(#colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)))
					.clipShape(RoundedRectangle(cornerRadius: 10))
					.padding(.horizontal)

				Button {
					guard !textFiledText.isEmpty else { return }
					viewModel.addFruit(text: textFiledText)
					textFiledText = ""
				} label: {
					Text("Save")
						.font(.headline)
						.foregroundStyle(.white)
						.frame(height: 55)
						.frame(maxWidth: .infinity)
						.background(Color(#colorLiteral(red: 1, green: 0.1857388616, blue: 0.5733950138, alpha: 1)))
						.clipShape(RoundedRectangle(cornerRadius: 10))
				}
				.padding(.horizontal)

				List {
					ForEach(viewModel.saveEntities) { entity in
						Text(entity.name ?? "NO NAME")
							.onTapGesture {
								viewModel.updateFruit(entity: entity)
							}
					}
					.onDelete(perform: viewModel.deleteFruit)
				}
				.listStyle(PlainListStyle())
			}
			.navigationTitle("Fruits")
		}
    }
}

#Preview {
    CoreDataBootcamp()
}
