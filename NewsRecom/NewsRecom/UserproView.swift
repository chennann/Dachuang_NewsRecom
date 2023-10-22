//
//  UserproView.swift
//  NewsRecom
//
//  Created by chennann on 2023/6/12.
//

import SwiftUI




struct UserproView: View {
    
    @EnvironmentObject var loginManager: LoginManager

    
    
    @State private var parameterNames: [String] = ["准确性", "时效性", "全面性"]
    @State private var parameterValues: [Double] = [34, 92, 23]
    
//    private let values = Array(0..<100)
    
    
    var body: some View {
        VStack (spacing: 0) {
            HStack {
                Text("用户信息")
                    .font(.system(size: 40))
                    .bold()
                Spacer()
            }
            .padding(.horizontal, 30)
            .padding(.top, 30)
            .padding(.bottom, 10)
//            Text((String)(loginManager.isLoggedIn))
            HStack (spacing: 0) {
                Text("用户名：")
                    .bold()
                    .padding(.leading)
                Spacer()
                Text(loginManager.userName)
                    .padding(.trailing)
                    .foregroundColor(Color.black.opacity(0.6))
            }
            .frame(width: 370, height: 50)
            .background(RoundedRectangle(cornerRadius: 8).fill(Color.secondary.opacity(0.1)))
            .padding(.vertical)
            Divider()
            
            HStack {
                Text("推荐设置")
                    .font(.system(size: 40))
                    .bold()
                Spacer()
            }
            .padding(.horizontal, 30)
            .padding(.top, 30)
            .padding(.bottom, 30)
            
            
            
            VStack {
                ForEach(0..<parameterNames.count, id: \.self) { index in
                    VStack {
                        HStack {
                            Text(self.parameterNames[index])
                                .bold()
                                .font(.system(size: 20))
                            Spacer()
                            Text("\(Int(self.parameterValues[index]))")
                                .bold()
                                .font(.system(size: 20))
                        }
                        .padding(.horizontal, 30)
                        Slider(value: $parameterValues[index], in: 0...100, step: 1, minimumValueLabel: Text("0").foregroundColor(Color.gray),
                               maximumValueLabel: Text("100").foregroundColor(Color.gray)) {}
                            .frame(minWidth: 100)
                            .accentColor(Color("cus_orange"))
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 8).fill(Color.secondary.opacity(0.1)))
                }
            }
            .padding(.horizontal, 30)
            
            
            
            
            
            Spacer()
            
            
            Button(action: {
                loginManager.isLoggedIn = false
            }) {
                Text("退出登录")
                    .frame(width: 200)
                    .bold()
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
