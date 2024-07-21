//
//  SplashView.swift
//  Pharmacy
//
//  Created by Rana Mahmoud on 20/07/2024.
//

import SwiftUI

struct SplashView: View {
    @Environment(\.scenePhase) var scenePhase
    let screen = UIScreen.main.bounds
    @State var showContentView = false
    @State var showLoginView = false
    @State var isAnimating: Bool = true
    private let apiManager = APIManager.shared
    @StateObject var loginViewModel = LoginViewModel()
    @StateObject var returnRequestViewModel = ReturnRequestViewModel()
    @State private var selectedReturnRequest: ReturnRequest?
    
    var body: some View {
        ZStack {
            appBgColor.ignoresSafeArea(.all)
            
            if (!showContentView) {
                KFAnimatedImage(resource: Bundle.main.url(forResource: "bill", withExtension: "gif"), repeatOnce: true) {
                    showContentView = true
                   
                      //
           
                }
                .padding(.bottom, 20)
            }
        }.onAppear{

        }.fullScreenCover(isPresented: $showContentView) {
//            if loginViewModel.isLoggedIn {
//                ReturnRequestView(viewModel: returnRequestViewModel, selectedReturnRequest: $selectedReturnRequest)
//                    .onAppear {
//                        returnRequestViewModel.authToken = loginViewModel.authToken
//                    }
//                    .fullScreenCover(item: $selectedReturnRequest) { request in
//                        ItemView(viewModel: ItemViewModel(currentReturnRequest: request, authToken: loginViewModel.authToken))
//                    }
//            } else {
                LoginView(viewModel: loginViewModel)
           // }
        }
    
    }
}

