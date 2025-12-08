//
//  CoreDataRelationships.swift
//  SwiftfulThinkingBootcampContinuation
//
//  Created by Roman Romanov on 08.12.2025.
//

import CoreData
import SwiftUI

// 3 entities
// BusinessEntity
// DepartmentEntity
// EmployeeEntity

final class CoreDataManager {

	static let instance = CoreDataManager()
	let container: NSPersistentContainer
	let context: NSManagedObjectContext

	init() {
		container = NSPersistentContainer(name: "CoreDataContainer")
		container.loadPersistentStores { description, error in
			if let error {
				print("Unable to load persistent stores: \(error)")
			}
		}
		context = container.viewContext
	}

	func saveData() {
		do {
			try context.save()
			print("Saved successfully!")
		} catch let error {
			print("Error saving Core Data. \(error.localizedDescription)")
		}
	}
}

@Observable
final class CoreDataRelationshipsViewModel {

	let manager = CoreDataManager.instance
	var businesses: [BusinessEntity] = []
	var departments: [DepartmentEntity] = []
	var employees: [EmployeeEntity] = []

	init() {
		getBusinesses()
		getDepartments()
		getEmployees()
	}

	func getBusinesses() {
		let request = NSFetchRequest<BusinessEntity>(entityName: "BusinessEntity")

		let sort = NSSortDescriptor(keyPath: \BusinessEntity.name, ascending: true)
		request.sortDescriptors = [sort]

//		let filter = NSPredicate(format: "name == %@", "Catgram")
//		request.predicate = filter

		do {
			businesses = try manager.context.fetch(request)
		} catch let error {
			print("Error fetching. \(error.localizedDescription)")
		}
	}

	func getDepartments() {
		let request = NSFetchRequest<DepartmentEntity>(entityName: "DepartmentEntity")
		do {
			departments = try manager.context.fetch(request)
		} catch let error {
			print("Error fetching. \(error.localizedDescription)")
		}
	}

	func getEmployees() {
		let request = NSFetchRequest<EmployeeEntity>(entityName: "EmployeeEntity")
		do {
			employees = try manager.context.fetch(request)
		} catch let error {
			print("Error fetching. \(error.localizedDescription)")
		}
	}

	func getEmployeesForBusiness(business: BusinessEntity) {
		let request = NSFetchRequest<EmployeeEntity>(entityName: "EmployeeEntity")

		let filter = NSPredicate(format: "business == %@", business)
		request.predicate = filter

		do {
			employees = try manager.context.fetch(request)
		} catch let error {
			print("Error fetching. \(error.localizedDescription)")
		}
	}

	func updateBusiness() {
		let existingBusiness = businesses[7]
		existingBusiness.addToDepartments(departments[1])
		save()
	}

	func addBusiness() {
		let newBusiness = BusinessEntity(context: manager.context)
		newBusiness.name = "Catgram"

		// add existing departments to s new business
//		newBusiness.departments = [departments[0], departments[1]]

		// add existing employees to a new business
//		newBusiness.employees = [employees[1], employees[2]]

		// add new business to a existing departments
//		newBusiness.addToDepartments(<#T##value: DepartmentEntity##DepartmentEntity#>)

		// add new business to existing employee
//		newBusiness.addToEmployees(<#T##value: EmployeeEntity##EmployeeEntity#>)

		save()
	}

	func addDepartment() {
		let newDepartment = DepartmentEntity(context: manager.context)
		newDepartment.name = "Finance"
		newDepartment.businesses = [businesses[0], businesses[6], businesses[7]]
//		newDepartment.employees = [employees[2]]
		newDepartment.addToEmployees(employees[2])
		save()
	}

	func addEmployee() {
		let newEmployee = EmployeeEntity(context: manager.context)
		newEmployee.age = 21
		newEmployee.dateJoined = Date()
		newEmployee.name = "John"

		newEmployee.business = businesses[7]
		newEmployee.department = departments[1]
		save()
	}

	func deleteDepartment() {
		let department = departments[1]
		manager.context.delete(department)
		save()
	}

	func save() {
		businesses.removeAll()
		departments.removeAll()
//		employees.removeAll()

		DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
			self.manager.saveData()
			self.getBusinesses()
			self.getDepartments()
//			self.getEmployees()
		}
	}
}

struct CoreDataRelationships: View {

	@State private var viewModel = CoreDataRelationshipsViewModel()

    var body: some View {
		NavigationView {
			ScrollView{
				VStack(spacing: 20) {
					Button {
						viewModel.deleteDepartment()
//						viewModel.getEmployeesForBusiness(business: viewModel.businesses[0])
					} label: {
						Text("Perform Action")
							.foregroundStyle(.white)
							.frame(height: 55)
							.frame(maxWidth: .infinity)
							.background(Color.blue.clipShape(RoundedRectangle(cornerRadius: 10)))
					}

					ScrollView(.horizontal, showsIndicators: true) {
						HStack(alignment: .top) {
							ForEach(viewModel.businesses) { business in
								BusinessView(entity: business)
							}
						}
					}

					ScrollView(.horizontal, showsIndicators: true) {
						HStack(alignment: .top) {
							ForEach(viewModel.departments) { department in
								DepartmentView(entity: department)
							}
						}
					}

					ScrollView(.horizontal, showsIndicators: true) {
						HStack(alignment: .top) {
							ForEach(viewModel.employees) { employee in
								EmployeeView(entity: employee)
							}
						}
					}
				}
				.padding()
			}
			.navigationTitle("Relationships")
		}
    }
}

struct BusinessView: View {

	let entity: BusinessEntity

	var body: some View {
		VStack(alignment: .leading, spacing: 20) {
			Text("Name: \(entity.name ?? "")")
				.bold()

			if let departments = entity.departments?.allObjects as? [DepartmentEntity] {
				Text("Departments:")
					.bold()
				ForEach(departments) { department in
					Text(department.name ?? "")
				}
			}

			if let employees = entity.employees?.allObjects as? [EmployeeEntity] {
				Text("Employees:")
					.bold()
				ForEach(employees) { employee in
					Text(employee.name ?? "")
				}
			}
		}
		.padding()
		.frame(maxWidth: 300, alignment: .leading)
		.background(.gray.opacity(0.3))
		.clipShape(RoundedRectangle(cornerRadius: 10))
		.shadow(radius: 10)
	}
}

struct DepartmentView: View {

	let entity: DepartmentEntity

	var body: some View {
		VStack(alignment: .leading, spacing: 20) {
			Text("Name: \(entity.name ?? "")")
				.bold()

			if let businesses = entity.businesses?.allObjects as? [BusinessEntity] {
				Text("businesses:")
					.bold()
				ForEach(businesses) { business in
					Text(business.name ?? "")
				}
			}

			if let employees = entity.employees?.allObjects as? [EmployeeEntity] {
				Text("Employees:")
					.bold()
				ForEach(employees) { employee in
					Text(employee.name ?? "")
				}
			}
		}
		.padding()
		.frame(maxWidth: 300, alignment: .leading)
		.background(.green.opacity(0.5))
		.clipShape(RoundedRectangle(cornerRadius: 10))
		.shadow(radius: 10)
	}
}

struct EmployeeView: View {

	let entity: EmployeeEntity

	var body: some View {
		VStack(alignment: .leading, spacing: 20) {
			Text("Name: \(entity.name ?? "")")
				.bold()

			Text("Age: \(entity.age)")
			Text("Date joined: \(entity.dateJoined ?? Date())")

			Text("Business:")
				.bold()

			Text(entity.business?.name ?? "")

			Text("Department:")
				.bold()

			Text(entity.department?.name ?? "")
		}
		.padding()
		.frame(maxWidth: 300, alignment: .leading)
		.background(.blue.opacity(0.5))
		.clipShape(RoundedRectangle(cornerRadius: 10))
		.shadow(radius: 10)
	}
}

#Preview {
    CoreDataRelationships()
}
