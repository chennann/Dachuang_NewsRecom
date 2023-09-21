//
//  UserproView.swift
//  NewsRecom
//
//  Created by chennann on 2023/6/12.
//

import SwiftUI




struct UserproView: View {
    
    @EnvironmentObject var loginManager: LoginManager
    
    
    var body: some View {
        VStack {
            Text("用户信息")
            Text((String)(loginManager.isLoggedIn))
            Button(action: {
                loginManager.isLoggedIn = false
            }) {
                Text("退出登录")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.red)
                    .cornerRadius(10)
            }
        }
        
    }
}






struct UserproView_Previews: PreviewProvider {
    static var previews: some View {
        UserproView()
            .environmentObject(LoginManager()) 
    }
}
