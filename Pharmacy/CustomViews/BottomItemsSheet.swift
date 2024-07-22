//
//  BottomItemsSheet.swift
//  Pharmacy
//
//  Created by Rana Mahmoud on 21/07/2024.
//

import SwiftUI

struct BottomItemsSheet: View {
    @Binding var showBottomSheet: Bool
    @Binding var isPresentedUpdateItemListView:Bool
    @Binding var isPresentedDeleteItemListView:Bool

    
    var body: some View {
        VStack {
            Spacer()
            
            VStack(spacing: 20) {

                
                Button(action: {
                    showBottomSheet = false
                   
                    isPresentedUpdateItemListView = true
                }) {
                    HStack {
                        Image(systemName: "info.circle")
                        Text("Update Item")
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
                Button(action: {
                    showBottomSheet = false
                    isPresentedDeleteItemListView = true
                }) {
                    HStack {
                        Image(systemName: "trash")
                        Text("Delete Item")
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


