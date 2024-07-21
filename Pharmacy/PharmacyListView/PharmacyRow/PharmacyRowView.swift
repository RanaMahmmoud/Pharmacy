import SwiftUI

struct PharmacyRowView: View {
    var pharmacy: Pharmacy
    
    var body: some View {
        HStack {
            ZStack {
                Image("listicon")
                    .resizable()
                    .frame(width: 60, height: 60)
                    .clipped()
            }
            
            VStack(alignment: .leading, spacing: 5) {
                Text(pharmacy.doingBusinessAs ?? "")
                    .font(.system(size: 16, weight: .semibold))
                
                Text("Returns: \(pharmacy.numberOfReturns ?? 0)")
                    .font(.system(size: 14))
                
                Text("Enabled: \(pharmacy.enabled == true ? "Yes" : "No")")
                    .font(.system(size: 14))
                    .foregroundColor(pharmacy.enabled == true ? .green : .red)
            }
           Spacer()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
        .padding(.horizontal)
        .padding(.vertical, 10)
        .padding(.horizontal, 15)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}
