//
//  LoginView.swift
//  NewsRecom
//
//  Created by chennann on 2023/9/21.
//

import SwiftUI

struct LoginView: View {
    
    @EnvironmentObject var loginManager: LoginManager
    @Binding var showUser: Bool
    @State var uname: String = ""
    @State var upwd: String = ""
    @State var showPassword: Bool = false
    
    var body: some View {
        ZStack {
            RadialGradient(gradient: Gradient(colors: [Color.orange, Color.red]), center: .topTrailing, startRadius: 80, endRadius: 600)
                .ignoresSafeArea()
            VStack {
                HStack {
                    Image(systemName: "eye")
                    Text("宽视资讯")
                }
                .foregroundColor(Color.white)
                .bold()
                .font(.system(size: 80))
                VStack (spacing: 20) {
                    TextField("username", text: $uname)
                        .frame(width: 320, height: 25)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 8)
                        .background(Color.white.opacity(0.6))
                        .cornerRadius(8)
                    ZStack(alignment: .trailing) {
                        if showPassword {
                            TextField("password", text: $upwd)
                                .frame(width: 320, height: 25)
                                .padding(.horizontal, 10)
                                .padding(.vertical, 8)
                                .background(Color.white.opacity(0.6))
                                .cornerRadius(8)
                        } else {
                            SecureField("password", text: $upwd)
                                .frame(width: 320, height: 25)
                                .padding(.horizontal, 10)
                                .padding(.vertical, 8)
                                .background(Color.white.opacity(0.6))
                                .cornerRadius(8)
                        }

                        Button(action: {
                            showPassword.toggle()
                        }) {
                            Image(systemName: showPassword ? "eye.slash.fill" : "eye.fill")
                                .foregroundColor(showPassword ? .gray : .gray)
                        }
                        .padding(.trailing, 10)
                    }
                    
                    
                    
                    
                }
                .padding(.horizontal, 50)
                .padding(.vertical, 30)
                
                Button(action: {
                    loginManager.isLoggedIn = true
                    showUser = false
                    loginManager.userName = uname
                }) {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.yellow)
                        .frame(width: 200, height: 50)
                        .overlay (
                            Text("登录")
                                .foregroundColor(Color.black)
                                .bold()
                                .font(.system(size: 20)))

                }
                .frame(width: 200)
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(showUser: .constant(false))
            .environmentObject(LoginManager())
    }
}
