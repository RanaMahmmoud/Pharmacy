//
//  BottomSheetView.swift
//  Pharmacy
//
//  Created by Rana Mahmoud on 20/07/2024.
//

import SwiftUI

struct BottomSheetView: View {
    @Binding var showBottomSheet: Bool
    @Binding var destination: PharmacyListView.Destination?
    @Binding var isPresentedWholesalerListView:Bool
    @Binding var isPresentedListReturnRequestsView:Bool
    @Binding var isPresentedReturnRequestView:Bool

    
    var body: some View {
        VStack {
            Spacer()
            
            VStack(spacing: 20) {
                Button(action: {
                    destination = .wholesalers
                    showBottomSheet = false
                    isPresentedWholesalerListView = true
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
                    destination = .returnRequests
                    showBottomSheet = false
                    isPresentedReturnRequestView = true
                }) {
                    HStack {
                        Image(systemName: "info.circle")
                        Text("Show Pharmacy Details")
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
                Button(action: {
                    destination = .returnRequests
                    showBottomSheet = false
                    isPresentedListReturnRequestsView = true
                }) {
                    HStack {
                        Image(systemName: "list.bullet")
                        Text("Show List Return Requests")
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

struct PrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(.white)
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.blue)
            .cornerRadius(10)
    }
}

struct CancelButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(.black)
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.gray)
            .cornerRadius(10)
    }
}


