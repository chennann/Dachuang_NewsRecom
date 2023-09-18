//
//  ReviewView.swift
//  NewsRecom
//
//  Created by chennann on 2023/6/12.
//

import SwiftUI

struct ReviewView: View {
    @State private var selectedTab = 1
    @State private var rotationDegrees = 0.0
    @State private var dis = 0.0
    @State private var showSearch = false
    @State private var showUser = false
    @State private var showReview = false
    
    let history: [String] = [
        "浏览记录 1",
        "浏览记录 2",
        "浏览记录 3",
        "浏览记录 4",
        "浏览记录 5",
        "浏览记录 1",
        "浏览记录 2",
        "浏览记录 3",
        "浏览记录 4",
        "浏览记录 5",
        "浏览记录 1",
        "浏览记录 2",
        "浏览记录 3",
        "浏览记录 4",
        "浏览记录 5"
    ]
    var body: some View {
        VStack {
            NavigationView {
                ScrollView (.vertical, showsIndicators: false) {
                    ForEach(reviewArray, id:\.self) {item in
                        VStack {
                            VStack (spacing:0) {
                                HStack {
                                    NavigationLink(item, destination: Text("news here"))
                                        .foregroundColor(Color.black)
                                    Spacer()
                                    
                                }
                                .padding([.top, .leading, .trailing])
                                .padding(.bottom, 10)
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(LinearGradient(gradient: Gradient(colors: [Color("cus_red"), Color.clear]), startPoint: .topLeading, endPoint: .bottomTrailing))
                                    .frame(height: 2)
                                
                                
                            }
                            //                        .frame(height: 150)
                            .background(RoundedRectangle(cornerRadius: 8)
                                .fill(Color.white)
//                                .shadow(radius: 5, x:3, y:0)
                            )
                        }
                        .padding(.horizontal)
                    }
                }
                .navigationBarTitle("新闻回溯")
                .navigationBarTitleDisplayMode(.large)
                
            }
            
            Spacer()
            Divider()
            HStack {
                //                    Button(action: {
                //                        selectedTab = 1
                //                        withAnimation {
                //                            rotationDegrees += 360.0
                //                            dis = 0.0
                //                        }
                //                    }) {
                //                        Image(systemName: "arrow.clockwise")
                //                            .foregroundColor(Color.secondary)
                //                            .rotationEffect(.degrees(rotationDegrees))
                //                    }
                Spacer()
                Button(action:{
                    selectedTab = 2
                    withAnimation {
                        dis = -10.0
                        
                    }
                    
                }) {
                    Image(systemName: "arrow.uturn.left")
                        .foregroundColor(selectedTab == 2 ? .black : .white)
                        .background(RoundedRectangle(cornerRadius: 10)
                            .fill(RadialGradient(gradient: Gradient(colors: [Color.orange, Color.red]), center: .topLeading, startRadius: 0, endRadius: 90))
                            .frame(width: 100, height: 50, alignment: .center)
                            .shadow(color: Color.orange.opacity(selectedTab == 2 ? 0.9 : 0.0), radius: 8, x: 0 , y: 5)
                        )
                    
                }
                .buttonStyle(PlainButtonStyle())
                .offset(y: dis)
                Spacer()
                //                    NavigationLink("asd", destination:SearchPage())
                //                    Button(action:{
                //                        selectedTab = 3
                //                        withAnimation {
                //                            dis = 0.0
                //                        }
                //                    }) {
                //                        Image(systemName: "magnifyingglass")
                //                            .foregroundColor(selectedTab == 3 ? .black : .secondary)
                //
                //                    }
            }
            .padding(.horizontal, 60)
            .font(.title2)
            .bold()
            .padding(.top, 20)
            .padding(.bottom, -5)
            .background(Color.white)
        }
    }
    var reviewArray: [String] {
        if let filePath = Bundle.main.path(forResource: "review", ofType: "txt") {
            do {
                let contents = try String(contentsOfFile: filePath)
                return contents.components(separatedBy: "\n")
            } catch {
                print("Error reading file: \(error)")
            }
        }
        return []
    }
}



struct ReviewView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewView()
    }
}
