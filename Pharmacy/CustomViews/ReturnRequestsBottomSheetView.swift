//
//  ReturnRequestsBottomSheetView.swift
//  Pharmacy
//
//  Created by Rana Mahmoud on 21/07/2024.
//

import SwiftUI

struct ReturnRequestsBottomSheetView: View {
    @Binding var showBottomSheet: Bool
    @Binding var isPresentedWholesalerListView:Bool
    @Binding var isPresentedListItemsRequestsView:Bool
    @Binding var isPresentedReturnRequestView:Bool

    
    var body: some View {
        VStack {
            Spacer()
            
            VStack(spacing: 20) {
                Button(action: {
                    showBottomSheet = false
                    isPresentedWholesalerListView = true
                    isPresentedListItemsRequestsView = false
                    isPresentedReturnRequestView = false
                }) {
                    HStack {
                        Image(systemName: "list.bullet")
                        Text("Show List Wholesalers")
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
                
                Button(action: {
                    showBottomSheet = false
                    isPresentedWholesalerListView = false
                    isPresentedListItemsRequestsView = false
                    isPresentedReturnRequestView = true
                }) {
                    HStack {
                        Image(systemName: "info.circle")
                        Text("Show Retun Request Details")
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
                Button(action: {
                    showBottomSheet = false
                    isPresentedWholesalerListView = false
                    isPresentedListItemsRequestsView = true
                    isPresentedReturnRequestView = false
                }) {
                    HStack {
                        Image(systemName: "list.bullet")
                        Text("Show Items List")
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
                
                Button(action: {
                    showBottomSheet = false
                }) {
                    HStack {
                        Image(systemName: "xmark")
                        Text("Cancel")
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.gray)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
            }
            
            .padding()
//            .background(Color.white)
            .cornerRadius(20)
            .shadow(radius: 20)
            .padding(.horizontal)
            .frame(height: 250) // Adjust height to fit buttons
        }
        
    }
    
}

