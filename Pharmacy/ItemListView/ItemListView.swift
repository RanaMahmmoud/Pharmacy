//
//  ItemListView.swift
//  Pharmacy
//
//  Created by Rana Mahmoud on 21/07/2024.
//

import SwiftUI

struct ItemListView: View {
    @ObservedObject var viewModel: ItemListViewModel
    @EnvironmentObject var loginViewModel: LoginViewModel
    @Binding var showModal: Bool
    @State var showBottomSheet: Bool = false
    @State var isPresentedAddItemListView: Bool = false
    @State var isPresentedUpdateItemListView: Bool = false
    @State var isPresentedDeleteItemListView: Bool = false
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    showModal.toggle()
                } label: {
                    Image(systemName: "chevron.left")
                }
                HStack {
                    Spacer()
                    Text("Items")
                        .font(.system(size: 18, weight: .bold))
                    Spacer()
                }
                Spacer()
                Button {
                    isPresentedAddItemListView = true
                } label: {
                    HStack(spacing: 10) {
                        Image(systemName: "plus")
                        Text("Add Item")
                    }
                }
            }
            .padding(.vertical, 25)
            .padding(.horizontal, 25)
            
            if viewModel.isLoading && viewModel.items.count > 0 {
                ProgressView("Loading Items...")
            } else if !viewModel.errorMessage.isEmpty {
                Text(viewModel.errorMessage)
                    .foregroundColor(.red)
                    .padding()
            } else {
                ScrollView {
                    VStack(spacing: 15) {
                        ForEach(viewModel.items) { item in
                            ItemRowView(item: item, showBottomSheet: $showBottomSheet)
                                .environmentObject(viewModel)
                        }
                    }
                    .padding(.horizontal)
                }
            }
            Spacer()
        }
        .fullScreenCover(isPresented: $isPresentedAddItemListView) {
            AddItemView(
                viewModel: ItemViewModel(
                    returnRequestId: viewModel.selectedRequestId,
                    pharmacyId: viewModel.selectedPharamcyId,
                    authToken: loginViewModel.authToken
                ),
                showModal: $isPresentedAddItemListView
            )
        }
        .bottomSheet(isPresented: $showBottomSheet, height: 400) {
            if showBottomSheet {
                BottomItemsSheet(
                    showBottomSheet: $showBottomSheet,
                    isPresentedUpdateItemListView: $isPresentedUpdateItemListView,
                    isPresentedDeleteItemListView: $isPresentedDeleteItemListView
                )
            }
        }
        .fullScreenCover(isPresented: $isPresentedUpdateItemListView) {
            if let item = viewModel.selectedItem {
                UpdateItemView(
                    viewModel: ItemViewModel(
                        returnRequestId: viewModel.selectedRequestId,
                        pharmacyId: viewModel.selectedPharamcyId,
                        authToken: loginViewModel.authToken
                    ),
                    item: item,
                    showModal: $isPresentedUpdateItemListView
                )
            }
        }
        .onAppear {
            viewModel.fetchItemsRequests(
                authToken: loginViewModel.authToken,
                pharmacyId: viewModel.selectedPharamcyId,
                requestId: viewModel.selectedRequestId
            )
        }
        .onChange(of: isPresentedDeleteItemListView) { newValue in
            if newValue, let item = viewModel.selectedItem {
                viewModel.deleteItem(
                    authToken: loginViewModel.authToken,
                    pharmacyId: viewModel.selectedPharamcyId,
                    requestId: viewModel.selectedRequestId,
                    itemId: item.id ?? 0
                )
                isPresentedDeleteItemListView = false // Reset the state after deletion
            }
        }
    }
}

struct ItemRowView: View {
    var item: Item
    @Binding var showBottomSheet: Bool
    @EnvironmentObject var viewModel: ItemListViewModel
    
    var body: some View {
        Button {
            viewModel.selectedItem = item
            showBottomSheet = true
        } label: {
            HStack {
                VStack(alignment: .leading, spacing: 5) {
                    Text("NDC: \(item.ndc ?? "")")
                        .font(.headline)
                    Text("Description: \(item.description ?? "")")
                        .font(.subheadline)
                    Text("Manufacturer: \(item.manufacturer ?? "")")
                        .font(.subheadline)
                    Text("Package Size: \(item.packageSize ?? "")")
                        .font(.subheadline)
                    Text("Request Type: \(item.requestType ?? "")")
                        .font(.subheadline)
                    Text("Name: \(item.name ?? "")")
                        .font(.subheadline)
                    Text("Strength: \(item.strength ?? "")")
                        .font(.subheadline)
                    Text("Dosage: \(item.dosage ?? "")")
                        .font(.subheadline)
                    Text("Full Quantity: \(item.fullQuantity ?? 0, specifier: "%.2f")")
                        .font(.subheadline)
                    Text("Partial Quantity: \(item.partialQuantity ?? 0, specifier: "%.2f")")
                        .font(.subheadline)
                    Text("Expiration Date: \(item.expirationDate ?? "")")
                        .font(.subheadline)
                    Text("Status: \(item.status ?? "")")
                        .font(.subheadline)
                        .foregroundColor(item.status == "PENDING" ? .orange : .green)
                    Text("Lot Number: \(item.lotNumber ?? "")")
                        .font(.subheadline)
                    Text("Expected Return Value: \(item.expectedReturnValue ?? 0, specifier: "%.2f")")
                        .font(.subheadline)
                    Text("Actual Return Value: \(item.actualReturnValue ?? 0, specifier: "%.2f")")
                        .font(.subheadline)
                }
                Spacer()
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}
