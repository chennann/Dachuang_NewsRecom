//
//  SwiftUIView.swift
//  NewsRecom
//
//  Created by chennann on 2023/6/20.
//

import SwiftUI

struct SwiftUIView: View {
    @State private var selectedTab = 1
    @State private var rotationDegrees = 0.0
    @State private var dis = 0.0
    @State private var showSearch = false
    @State private var showUser = false
    @State private var showReview = false
    @State private var searchText = ""
    @State private var circleColors: [Color] = [Color("cus_red"), Color("cus_blue"), Color("cus_green"), .gray, Color.cyan, Color.orange]
    @State private var circleDiameters: [CGFloat] = [140, 120, 60, 90, 100, 60]
    @State private var circleCoordinates: [CGPoint] = [
        CGPoint(x: 180, y: 300),
        CGPoint(x: 110, y: 120),
        CGPoint(x: 90, y: 440),
        CGPoint(x: 300, y: 140),
        CGPoint(x: 270, y: 500),
        CGPoint(x: 330, y: 350)
    ]
    @State private var circleRadius: [CGFloat] = [15, 15, 15, 15, 15, 15]
    
    let circleTexts = ["中考", "高考", "中美关系", "鼠头鸭脖", "梅西","F1"]
    private let lineColors: [Color] = [.red, .green, .blue, .orange, .purple]
    private let lineThicknesses: [CGFloat] = [2, 3, 1, 2.5, 1.5]
    let circleFonts: [Font] = [
        .system(size: 44, weight: .bold),
        .system(size: 38, weight: .bold),
        .system(size: 12, weight: .bold),
        .system(size: 14, weight: .bold),
        .system(size: 20, weight: .bold),
        .system(size: 20, weight: .bold)
    ]
    
    var body: some View {
        VStack (spacing:0) {
            ZStack {
                Text("宽视资讯")
                    .foregroundColor(Color.white)
                    .font(.title)
                    .bold()
                    .italic()
                HStack {
                    Button (action:{
                        
                    }) {
                        Image(systemName: "line.horizontal.3")
                            .bold()
                            .foregroundColor(Color.white)
                    }
                    Spacer()
                    Button (action:{
                        showUser = true;
                    }) {
                        Image("user_profile")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 40, height: 40)
                            .clipShape(Circle())
                            .padding(.trailing, 5)
                    }
                    .sheet(isPresented: $showUser) {
                        UserproView()
                        
                    }
                }
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 8)
            .background(Color.black.opacity(0.75))
            
            Spacer()
            ZStack {
                
//                Path { path in
//                    for index in 0..<circleCoordinates.count {
//                        path.move(to: circleCoordinates[0])
//                        path.addLine(to: circleCoordinates[index])
//                    }
//                }
//                .stroke(Color.black.opacity(0.7), lineWidth: 5)
////                .stroke(lineGradient, style: StrokeStyle(lineWidth: maxLineThickness))
//                .background(Color.clear) // 添加背景以避免圆形遮挡连线
                
                ForEach(0..<circleCoordinates.count, id: \.self) { index in
                    Circle()
                        .fill(circleColors[index])
                        .frame(width: circleDiameters[index], height: circleDiameters[index])
                        .position(circleCoordinates[index])
                        .shadow(color: circleColors[index], radius: circleRadius[index])
                    Text(circleTexts[index])
                        .foregroundColor(.white)
//                        .font(.system(size: 14))
                        .font(circleFonts[index])
                        .fontWeight(.bold)
                        .position(circleCoordinates[index])
                }
                
                
            }
            HStack (spacing:15) {
                TextField("搜索", text: $searchText)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 8)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
                
                Button(action: {
                    selectedTab = 0
                    withAnimation {
                        dis = 0.0
                    }
                    search()
                }) {
                    Image(systemName: "magnifyingglass")
                        .font(.title2)
                        .foregroundColor(Color("cus_red"))
                        .bold()
                }
                .padding(.trailing, 5)
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 20)
            
//            Spacer()
//            Divider()
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
                            .shadow(color: Color.orange.opacity(selectedTab == 2 ? 0.9 : 0.3), radius: 8, x: 0 , y: 5)
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
    
    func search() {
        // 在这里执行搜索逻辑，根据searchText进行搜索操作
        print("执行搜索操作：\(searchText)")
    }
    private var lineGradient: LinearGradient {
        LinearGradient(
            gradient: Gradient(colors: lineColors),
            startPoint: .leading,
            endPoint: .trailing
        )
    }
    
    // 最大线条粗细
    private var maxLineThickness: CGFloat {
        lineThicknesses.max() ?? 0
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}
