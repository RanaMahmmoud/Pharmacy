//
//  AddItemView.swift
//  Pharmacy
//
//  Created by Rana Mahmoud on 20/07/2024.
//
import SwiftUI

struct AddItemView: View {
    @ObservedObject var viewModel: ItemViewModel
    @State private var item: Item
    @Binding var showModal: Bool

    init(viewModel: ItemViewModel, item: Item? = nil, showModal: Binding<Bool>) {
        self.viewModel = viewModel
        self._showModal = showModal
        self._item = State(initialValue: item ?? Item(id: viewModel.generateRandomID(), createdAt: "", updatedAt: "", ndc: "", description: "", manufacturer: "", packageSize: "", requestType: "", name: "", strength: "", dosage: "", fullQuantity: 0.0, partialQuantity: 0.0, expirationDate: "", status: "", lotNumber: "", expectedReturnValue: 0.0, actualReturnValue: 0.0, gtin14: "", serialNumber: "", controlledSubstanceCode: "", adminComment: ""))
    }

    var body: some View {
        VStack {
            HStack {
                Button {
                    showModal.toggle()
                } label: {
                    Image(systemName: "chevron.left")
                }
                Spacer()
                Text("Add New Item")
                    .font(.system(size: 18, weight: .bold))
                Spacer()
                Image(systemName: "chevron.left").opacity(0)
            }
            .padding(.vertical, 25)
            .padding(.leading, 25)

            ScrollView {
                LazyVStack {
                    TextField("NDC", text: Binding(get: { item.ndc ?? "" }, set: { item.ndc = $0 }))
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(8)
                        .padding(.bottom, 10)

                    TextField("Description", text: Binding(get: { item.description ?? "" }, set: { item.description = $0 }))
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(8)
                        .padding(.bottom, 10)

                    TextField("Manufacturer", text: Binding(get: { item.manufacturer ?? "" }, set: { item.manufacturer = $0 }))
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(8)
                        .padding(.bottom, 10)

                    TextField("Package Size", text: Binding(get: { item.packageSize ?? "" }, set: { item.packageSize = $0 }))
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(8)
                        .padding(.bottom, 10)

                    TextField("Request Type", text: Binding(get: { item.requestType ?? "" }, set: { item.requestType = $0 }))
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(8)
                        .padding(.bottom, 10)

                    TextField("Name", text: Binding(get: { item.name ?? "" }, set: { item.name = $0 }))
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(8)
                        .padding(.bottom, 10)

                    TextField("Strength", text: Binding(get: { item.strength ?? "" }, set: { item.strength = $0 }))
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(8)
                        .padding(.bottom, 10)

                    TextField("Dosage", text: Binding(get: { item.dosage ?? "" }, set: { item.dosage = $0 }))
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(8)
                        .padding(.bottom, 10)

                    TextField("Full Quantity", value: Binding(get: { item.fullQuantity ?? 0.0 }, set: { item.fullQuantity = $0 }), formatter: NumberFormatter())
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(8)
                        .padding(.bottom, 10)

                    TextField("Partial Quantity", value: Binding(get: { item.partialQuantity ?? 0.0 }, set: { item.partialQuantity = $0 }), formatter: NumberFormatter())
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(8)
                        .padding(.bottom, 10)

                    TextField("Expiration Date", text: Binding(get: { item.expirationDate ?? "" }, set: { item.expirationDate = $0 }))
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(8)
                        .padding(.bottom, 10)

                    TextField("Status", text: Binding(get: { item.status ?? "" }, set: { item.status = $0 }))
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(8)
                        .padding(.bottom, 10)

                    TextField("Lot Number", text: Binding(get: { item.lotNumber ?? "" }, set: { item.lotNumber = $0 }))
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(8)
                        .padding(.bottom, 10)

                    HStack {
                        Spacer()
                        Button("Save Item") {
//                            if let id = viewModel.itemId {
//                                viewModel.updateItem(itemId: id, updatedItem: item)
//                            } else {
                                viewModel.addItem(item: item)
//                            }
                            showModal.toggle()
                        }
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        Spacer()
                        Button("Done") {
                            showModal.toggle()
                        }
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        Spacer()
                    }
                }
                .padding()
            }
        }
    }
}
