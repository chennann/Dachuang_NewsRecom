//
//  ContentView.swift
//  NewsRecom
//
//  Created by chennann on 2023/6/11.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 1
    @State private var rotationDegrees = 0.0
    @State private var dis = 0.0
    @State private var showSearch = false
    @State private var showUser = false
    @State private var showReview = false
    
    var body: some View {
        NavigationView {
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
                
                ScrollView (.vertical, showsIndicators: false) {
                    VStack {
                        ForEach(newsArray, id: \.title) { news in
                            VStack (spacing:0) {
                                HStack {
                                    VStack (alignment: .leading) {
                                        Text(news.title)
                                            .padding(.top, 5)
                                            .font(.title2)
                                            .bold()
                                            
                                        Spacer()
                                        Text(news.summary)
                                            .lineLimit(2)
                                    }
                                    .padding(.trailing, 20)
                                    Spacer()
                                    Image(news.pic)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
//                                    RoundedRectangle(cornerRadius: 10)
//                                        .fill(
//                                            RadialGradient(gradient: Gradient(colors: [Color.orange, Color("cus_red")]), center: .topLeading, startRadius: 0, endRadius: 90)
//                                        )
//                                        .frame(width: 100)
                                }
                                .padding([.top, .leading, .trailing])
                                .padding(.bottom, 10)
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(LinearGradient(gradient: Gradient(colors: [news.color, Color.clear]), startPoint: .topLeading, endPoint: .bottomTrailing))
                                    .frame(height: 5)


                            }
                            .frame(height: 150)
                            .background(RoundedRectangle(cornerRadius: 8)
                                .fill(Color.white)
                                .shadow(radius: 8, x:5, y:5)
                            )
                        }
                    }
                    .padding(.horizontal)
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
            //        .background(Color.secondary)
        }
    }
    
//    var newsArray: [String] {
//        if let filePath = Bundle.main.path(forResource: "news", ofType: "txt") {
//            do {
//                let contents = try String(contentsOfFile: filePath)
//                return contents.components(separatedBy: "\n")
//            } catch {
//                print("Error reading file: \(error)")
//            }
//        }
//        return []
//    }
    
    
//    var newsArray: [(title: String, summary: String)] {
//        if let filePath = Bundle.main.path(forResource: "news", ofType: "txt") {
//            do {
//                let contents = try String(contentsOfFile: filePath)
//                let lines = contents.components(separatedBy: "\n")
//
//                var newsData: [(title: String, summary: String)] = []
//
//                for line in lines {
//                    let components = line.components(separatedBy: " ")
//                    if components.count >= 2 {
//                        let title = components[0]
//                        let summary = components[1..<components.count].joined(separator: " ")
//                        newsData.append((title: title, summary: summary))
//                    }
//                }
//
//                return newsData
//            } catch {
//                print("Error reading file: \(error)")
//            }
//        }
//        return []
//    }

//    var newsArray: [(title: String, summary: String, color: Color)] {
//        if let filePath = Bundle.main.path(forResource: "news", ofType: "txt") {
//            do {
//                let contents = try String(contentsOfFile: filePath)
//                let lines = contents.components(separatedBy: "\n")
//
//                var newsData: [(title: String, summary: String, color: Color)] = []
//
//                for line in lines {
//                    let components = line.components(separatedBy: " ")
//                    if components.count >= 3 {
//                        let colorString = components[0]
//                        let title = components[1]
//                        let summary = components[2..<components.count].joined(separator: " ")
//
//                        let color = parseColor(from: colorString)
//
//                        newsData.append((title: title, summary: summary, color: color))
//                    }
//                }
//
//                return newsData
//            } catch {
//                print("Error reading file: \(error)")
//            }
//        }
//        return []
//    }
    var newsArray: [(title: String, summary: String, color: Color, pic: String)] {
        if let filePath = Bundle.main.path(forResource: "news", ofType: "txt") {
            do {
                let contents = try String(contentsOfFile: filePath)
                let lines = contents.components(separatedBy: "\n")
                
                var newsData: [(title: String, summary: String, color: Color, pic: String)] = []
                
                for line in lines {
                    let components = line.components(separatedBy: " ")
                    if components.count >= 4 {
                        let colorString = components[0]
                        let title = components[1]
                        let summary = components[2]
                        let pic = components[3]
                        
                        let color = parseColor(from: colorString)
                        
                        newsData.append((title: title, summary: summary, color: color, pic: pic))
                    }
                }
                
                return newsData
            } catch {
                print("Error reading file: \(error)")
            }
        }
        return []
    }
    func parseColor(from string: String) -> Color {
        if string == "red" {
            return Color("cus_red").opacity(0.7)
        } else if string == "blue" {
//            return Color("cus_blue").opacity(0.7)
            return Color.gray.opacity(0.7)
        } else if string == "green" {
            return Color("cus_green").opacity(0.7)
        } else {
            return .black.opacity(0.7)
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
