//
//  ListReturnRequestsRow.swift
//  Pharmacy
//
//  Created by Rana Mahmoud on 21/07/2024.
//

import Foundation
import SwiftUI

struct ListReturnRequestsRow: View {
    var returnRequest: ReturnRequestData
    var itemsNumber: Int
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                Text("ID: \(returnRequest.id ?? 0)")
                    .font(.system(size: 16, weight: .semibold))
                
                Text("Created At: \(returnRequest.createdAt ?? 0)")
                    .font(.system(size: 14))
                
                Text("Items: \(itemsNumber)")
                    .font(.system(size: 14))
                
                Text("Status: \(returnRequest.returnRequestStatusLabel)")
                    .font(.system(size: 14))
                
                Text("Service Type: \(returnRequest.serviceType)")
                    .font(.system(size: 14))
                
                Text("Associated Wholesaler: \(returnRequest.pharmacy?.doingBusinessAs ?? "")")
                    .font(.system(size: 14))
            }
            Spacer()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal)
        .padding(.vertical, 10)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}


