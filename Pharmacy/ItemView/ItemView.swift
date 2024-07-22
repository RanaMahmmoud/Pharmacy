//
//  ItemsView.swift
//  Pharmacy
//
//  Created by Rana Mahmoud on 20/07/2024.
//

import SwiftUI

struct ItemView: View {
    @ObservedObject var viewModel: ItemViewModel

    var body: some View {
        VStack {
//            ForEach(viewModel.items) { item in
//                VStack(alignment: .leading) {
//                    Text("NDC: \(item.ndc)")
//                    Text("Description: \(item.description)")
//                    Text("Manufacturer: \(item.manufacturer)")
//                    Text("Full Quantity: \(item.fullQuantity)")
//                    Text("Partial Quantity: \(item.partialQuantity)")
//                    Text("Expiration Date: \(item.expirationDate)")
//                    Text("Lot Number: \(item.lotNumber)")
//                }
//                .padding()
//                .background(Color.gray.opacity(0.1))
//                .cornerRadius(8)
//                .padding(.bottom, 8)
//            }
//
//            NavigationLink(destination: AddItemView(viewModel: viewModel)) {
//                Text("Add Item")
//                    .padding()
//                    .background(Color.blue)
//                    .foregroundColor(.white)
//                    .cornerRadius(8)
//            }
//
//            if let errorMessage = viewModel.errorMessage {
//                Text(errorMessage)
//                    .foregroundColor(.red)
//                    .padding()
//            }
        }
        .onAppear {
//            viewModel.fetchItems()
        }
        .navigationTitle("Items")
    }
}
