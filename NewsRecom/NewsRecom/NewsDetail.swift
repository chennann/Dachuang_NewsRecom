//
//  NewsDetail.swift
//  NewsRecom
//
//  Created by chennann on 2023/9/18.
//

import SwiftUI

struct NewsDetail: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
        
    
    var news:String = ""
    var pic:String = ""
    var title:String = ""
    
    var body: some View {
            VStack(spacing: 20) {

                // Content
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 10) {
                        // Image
                        Image(pic)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding(.horizontal)

                        // News content
                        Text(news)
                            .padding(.horizontal)
                    }
                }
                .navigationBarTitle(title, displayMode: .large)
                .navigationBarBackButtonHidden(true)  // 隐藏默认的返回按钮
                        .navigationBarItems(leading: Button(action: {
                            self.presentationMode.wrappedValue.dismiss()
                        }) {
                            Image(systemName: "chevron.left")  // 使用你自己的图标或样式
                                .foregroundColor(Color.orange)
                                .font(.system(size: 20, weight: .bold))
                        })
            }
            .background(Color.white)  // Ensure the whole view has a white background
        }
}

struct NewsDetail_Previews: PreviewProvider {
    static var previews: some View {
        NewsDetail()
    }
}
