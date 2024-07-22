//
//  LoginView.swift
//  Pharmacy
//
//  Created by Rana Mahmoud on 20/07/2024.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject var viewModel: LoginViewModel
    @State private var visible = false
    @State private var color = Color.black.opacity(0.7)
    @State private var title = "Error"
    @FocusState private var focusedField: Field?

    enum Field {
        case username
        case password
    }

    var body: some View {
        ScrollView {
            LazyVStack {
                Image("pharma")
                    .resizable()
                    .frame(width: 300.0, height: 255.0, alignment: .top)
                
                Text("Sign in to your account")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.top, 15)
                
                TextField("Username or Email", text: $viewModel.username)
                    .autocapitalization(.none)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 6).stroke(Color.gray, lineWidth: 2))
                    .padding(.top, 0)
                    .focused($focusedField, equals: .username)
                    .submitLabel(.next)
                    .onSubmit {
                        focusedField = .password
                    }
                
                HStack(spacing: 15) {
                    if visible {
                        TextField("Password", text: $viewModel.password)
                            .autocapitalization(.none)
                            .focused($focusedField, equals: .password)
                            .submitLabel(.done)
                            .onSubmit {
                                viewModel.login()
                            }
                    } else {
                        SecureField("Password", text: $viewModel.password)
                            .autocapitalization(.none)
                            .focused($focusedField, equals: .password)
                            .submitLabel(.done)
                            .onSubmit {
                                viewModel.login()
                            }
                    }
                    
                    Button(action: {
                        visible.toggle()
                    }) {
                        Image(systemName: visible ? "eye.slash.fill" : "eye.fill")
                            .foregroundColor(color)
                            .opacity(0.8)
                    }
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 6).stroke(Color.gray, lineWidth: 2))
                .padding(.top, 10)
                
                Button(action: {
                    viewModel.login()
                }) {
                    Text("Sign in")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .padding(.vertical)
                        .frame(width: UIScreen.main.bounds.width - 30)
                }
                .background(Color.blue)
                .cornerRadius(6)
                .padding(.top, 15)
                .alert(isPresented: Binding<Bool>(
                    get: { !viewModel.errorMessage.isEmpty },
                    set: { _ in viewModel.errorMessage = "" }
                )) {
                    Alert(
                        title: Text(title),
                        message: Text(viewModel.errorMessage),
                        dismissButton: .default(Text("OK").fontWeight(.semibold))
                    )
                }
                
                if viewModel.isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .padding(.top, 15)
                }
            }
        }
        .padding()
        .fullScreenCover(isPresented: $viewModel.isLoggedIn) {
            PharmacyListView(viewModel: PharmacyListViewModel()).environmentObject(viewModel)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(viewModel: LoginViewModel())
    }
}
