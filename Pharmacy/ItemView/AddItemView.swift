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
    @Environment(\.presentationMode) var presentationMode

    init(viewModel: ItemViewModel, item: Item? = nil) {
        self.viewModel = viewModel
        self._item = State(initialValue: item ?? Item(id: UUID().uuidString, ndc: "", description: "", manufacturer: "", fullQuantity: 0, partialQuantity: 0, expirationDate: "", lotNumber: ""))
    }

    var body: some View {
        VStack {
            TextField("NDC", text: $item.ndc)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
                .padding(.bottom, 10)

            TextField("Description", text: $item.description)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
                .padding(.bottom, 10)

            TextField("Manufacturer", text: $item.manufacturer)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
                .padding(.bottom, 10)

            TextField("Full Quantity", value: $item.fullQuantity, formatter: NumberFormatter())
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
                .padding(.bottom, 10)

            TextField("Partial Quantity", value: $item.partialQuantity, formatter: NumberFormatter())
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
                .padding(.bottom, 10)

            TextField("Expiration Date", text: $item.expirationDate)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
                .padding(.bottom, 10)

            TextField("Lot Number", text: $item.lotNumber)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
                .padding(.bottom, 10)

            Button("Save Item") {
//                if item.id.isEmpty {
//                    viewModel.addItem(item: item)
//                } else {
//                    viewModel.updateItem(itemId: item.id, updatedItem: item)
//                }
                presentationMode.wrappedValue.dismiss()
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)

            Button("Done") {
                presentationMode.wrappedValue.dismiss()
            }
            .padding()
            .background(Color.green)
            .foregroundColor(.white)
            .cornerRadius(8)
        }
        .padding()
    }
}
