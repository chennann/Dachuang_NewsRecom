//
//  UserproView.swift
//  NewsRecom
//
//  Created by chennann on 2023/6/12.
//

import SwiftUI




struct UserproView: View {
    
    @State private var isLoggedOut = false
    
    var body: some View {
        
    

                //                 已登录，显示用户信息
                VStack(spacing: 20) {
                    Text("个人信息")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Text("用户名：John Doe")
                    
                    Text("设置：...")
                    
                    Text((String)(isLoggedOut))
                    
                    Button(action: {
                        isLoggedOut = true
                    }) {
                        Text("退出登录")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.red)
                            .cornerRadius(10)
                    }
                }
                .padding()
                .alert(isPresented: $isLoggedOut) {
                    Alert(
                        title: Text("确认退出登录"),
                        message: Text("您确定要退出登录吗？"),
                        primaryButton: .cancel(Text("取消")),
                        secondaryButton: .destructive(Text("退出"), action: {
                            // 执行退出登录操作
                            isLoggedOut.toggle()
                        })
                    )
                }
        
        
        
    }
}






struct UserproView_Previews: PreviewProvider {
    static var previews: some View {
        UserproView()
    }
}
