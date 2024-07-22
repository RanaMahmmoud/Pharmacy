//
//  ListReturnRequestsView.swift
//  Pharmacy
//
//  Created by Rana Mahmoud on 21/07/2024.
//

import SwiftUI
import BottomSheet

struct ListReturnRequestsView: View {
    @ObservedObject var viewModel: ListReturnRequestsViewModel
    @EnvironmentObject var loginViewModel: LoginViewModel
    let pharmacyId: Int
    @State private var showReturnRequest = false
    @State private var selectedRequest:ReturnRequestData?
    @Binding var showModal: Bool
    @State private var isPresentedWholesalerListView: Bool = false
    @State private var isPresentedListItemsRequestsView: Bool = false
    @State private var isPresentedReturnRequestView: Bool = false
    @State private var showRequestBottomSheet = false
    
    
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
                        
                        Text("Return Requests")
                            .font(.system(size: 18, weight: .bold))
                        
                        Spacer()
                        
                    }
                    Spacer()
                }.padding(.vertical,25)
                    .padding(.leading,25)
                
                
                if viewModel.isLoading {
                    Spacer()
                    ProgressView("Loading Return Requests...")
                    Spacer()
                } else if !viewModel.errorMessage.isEmpty {
                    Text(viewModel.errorMessage)
                        .foregroundColor(.red)
                        .padding()
                } else {
                    ScrollView {
                        VStack(spacing: 15) {
                            ForEach(viewModel.returnRequests) { returnRequest in
                                if let requestData = returnRequest.returnRequest {
                                    ListReturnRequestsRow(returnRequest: requestData, itemsNumber: returnRequest.numberOfItems ?? 0)
                                        .onTapGesture {
                                            
                                        selectedRequest = requestData
                                        showRequestBottomSheet = true
                                        viewModel.selectedPharamcyId = requestData.pharmacy?.id ?? 0
                                        viewModel.selectedRequestId = requestData.id ?? 0
                                       
                                    }

                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                }
                Spacer()
            }  .onAppear {
                viewModel.fetchReturnRequests(authToken: loginViewModel.authToken, pharmacyId: pharmacyId)
            }
            .bottomSheet(isPresented: $showRequestBottomSheet, height: 300) {
                if(showRequestBottomSheet){
                    ReturnRequestsBottomSheetView(showBottomSheet: $showRequestBottomSheet ,isPresentedWholesalerListView: $isPresentedWholesalerListView,isPresentedListItemsRequestsView: $isPresentedListItemsRequestsView, isPresentedReturnRequestView: $isPresentedReturnRequestView)
                }
          }
        
            .bottomSheet(isPresented: $isPresentedReturnRequestView, height: 230) {
    
                if(isPresentedReturnRequestView){
                    ReturnRequestView(viewModel: ReturnRequestViewModel(), pharmacyId: viewModel.selectedPharamcyId, requestId:  viewModel.selectedRequestId ,authToken: loginViewModel.authToken)
                    
                }
            }
            .fullScreenCover(isPresented: $isPresentedWholesalerListView, content: {
            
                    WholesalerListView(viewModel: WholesalerViewModel(), pharmacyId: viewModel.selectedPharamcyId,showModal: $isPresentedWholesalerListView)
                        .environmentObject(loginViewModel)
                
            })
            .fullScreenCover(isPresented: $isPresentedListItemsRequestsView, content: {
             
                ItemListView(viewModel: ItemListViewModel(selectedRequestId:viewModel.selectedRequestId  ,selectedPharamcyId:viewModel.selectedPharamcyId ), showModal: $isPresentedListItemsRequestsView)
                    .environmentObject(loginViewModel)
            })
    }
}

