//
//  SearchPage.swift
//  NewsRecom
//
//  Created by chennann on 2023/6/12.
//

import SwiftUI


class KeyboardManager: ObservableObject {
    @Published var keyboardHeight: CGFloat = 0
    
    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: Notification) {
        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
            keyboardHeight = keyboardFrame.height
        }
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        keyboardHeight = 0
    }
}

class LoginManager: ObservableObject {
    @Published var isLoggedIn: Bool {
        didSet {
            UserDefaults.standard.set(isLoggedIn, forKey: "isLoggedIn")
        }
    }
//    @Published var userName: String = ""
    @Published  var password: String = ""
    @Published var userName: String {
        didSet {
            UserDefaults.standard.set(userName, forKey: "userName")
        }
    }
    init() {
        self.isLoggedIn = UserDefaults.standard.bool(forKey: "isLoggedIn")
        self.userName = UserDefaults.standard.string(forKey: "userName") ?? "default"
    }
}

struct SearchView: View {
    
    @State private var selectedCircleIndices: Set<Int> = []
    @StateObject private var keyboardManager = KeyboardManager()
    @StateObject var loginManager = LoginManager()
    
    @State private var selectedTab = 1
    @State private var rotationDegrees = 0.0
    @State private var dis = 0.0
    @State private var showSearch = false
    @State private var showUser = false
    @State private var showReview = false
    @State private var showMenu = false
    @State private var searchText = ""
    @State private var circleColors: [Color] = [Color("cus_green"), Color("cus_blue"), Color("cus_red"), .gray, .orange]
    @State private var circleDiameters: [CGFloat] = [70, 150, 130, 70, 100]
    @State private var circleCoordinates: [CGPoint] = [
        CGPoint(x: 90, y: 150),
        CGPoint(x: 280, y: 250),
        CGPoint(x: 90, y: 350),
        CGPoint(x: 300, y: 100),
        CGPoint(x: 270, y: 500)
    ]
    
    let circleTexts = ["球王梅西", "球迷拥抱梅西", "主办方保安被骂惨", "18岁行拘后悔", "热议勇敢惊讶"]
    private let lineColors: [Color] = [.red, .green, .blue, .orange, .purple]
    private let lineThicknesses: [CGFloat] = [2, 3, 1, 2.5, 1.5]
    let circleFonts: [Font] = [
        .system(size: 14, weight: .bold),
        .system(size: 28, weight: .bold),
        .system(size: 26, weight: .bold),
        .system(size: 14, weight: .bold),
        .system(size: 20, weight: .bold)
    ]
    
    var body: some View {
        NavigationView {
            
            ZStack {
                VStack (spacing:0) {
                    //MARK: - 头部
                    ZStack {
                        Text("宽视资讯")
                            .foregroundColor(Color.white)
                            .font(.title)
                            .bold()
                            .italic()
                        HStack {
                            Button (action:{
                                withAnimation {
                                    showMenu.toggle()
                                }
                            }) {
                                Image(systemName: "line.horizontal.3")
                                    .bold()
                                    .foregroundColor(Color.white)
                            }
                            Spacer()
                            Button (action:{
                                showUser = true;
                            }) {
                                if loginManager.isLoggedIn {
                                    Image("user_profile")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 40, height: 40)
                                        .clipShape(Circle())
                                        .padding(.trailing, 5)
                                }
                                else {
                                    Image(systemName: "person.crop.circle.badge.questionmark")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 40, height: 40)
                                        .foregroundColor(Color.white.opacity(0.6))
                                        .clipShape(Circle())
                                        .padding(.trailing, 5)
                                }
                            }
                            .sheet(isPresented: $showUser) {
                                
                                if loginManager.isLoggedIn {
                                    UserproView()
                                }
                                else {
                                    LoginView(showUser: $showUser)
                                    
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 8)
                    .background(Color("Top_color"))
                    
                    Spacer()
                    ZStack {
                        //MARK: - 画线
                        Path { path in
                            for index in 0..<circleCoordinates.count {
                                path.move(to: circleCoordinates[1])
                                path.addLine(to: circleCoordinates[index])
                            }
                        }
                        .stroke(Color.black.opacity(0.7), lineWidth: 5)
                        
                        .background(Color.clear) // 添加背景以避免圆形遮挡连线
                        
                        //MARK: - 画圆圈
                        ForEach(0..<circleCoordinates.count, id: \.self) { index in
                            Circle()
                                .fill(selectedCircleIndices.contains(index) ? circleColors[index].opacity(1.0) : circleColors[index].opacity(1.0))
                                .frame(width: circleDiameters[index], height: circleDiameters[index])
                                .position(circleCoordinates[index])
                                .shadow(color: circleColors[index], radius: selectedCircleIndices.contains(index) ? 50 : 0)
                                .onTapGesture {
                                    if selectedCircleIndices.contains(index) {
                                        selectedCircleIndices.remove(index) // 如果点击的圆圈已经被选中，则从集合中移除它
                                    } else {
                                        selectedCircleIndices.insert(index) // 否则，将其添加到集合中
                                    }
                                }
                            
                            
                            
                            //MARK: - 圆圈上的文字
                            Text(circleTexts[index])
                                .foregroundColor(.white)
                                .frame(maxWidth: circleDiameters[index])
                                .font(circleFonts[index])
                                .fontWeight(.bold)
                                .position(circleCoordinates[index])
                                .onTapGesture {
                                    if selectedCircleIndices.contains(index) {
                                        selectedCircleIndices.remove(index) // 如果点击的圆圈已经被选中，则从集合中移除它
                                    } else {
                                        selectedCircleIndices.insert(index) // 否则，将其添加到集合中
                                    }
                                }
                        }

                    }
                    .overlay(RoundedRectangle(cornerRadius: 20)
                        .fill(Color.white.opacity(0.8))
                        .frame(width: keyboardManager.keyboardHeight>0 ? 1000 : 0, height: 1000, alignment: .center)
                        .position(x: 230, y: 500))
                    //MARK: - 选中关键字
                    HStack(spacing: 10) {
                        ForEach(Array(selectedCircleIndices), id: \.self) { index in
                            let displayText = String(circleTexts[index])
                            Text(displayText)
                                .font(.system(size: 12))
                                .foregroundColor(Color.white)
                                .lineLimit(1)
                                .padding(.horizontal, 15)
                                .padding(.vertical, 5)
                                .background(circleColors[index].opacity(1.0))
                                .clipShape(Capsule())
                            
                        }
                    }
                    .padding(.top, 20)
                    .padding(.horizontal)
                    Spacer()
                    //MARK: - 搜索
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
                    Divider()
                    Spacer(minLength: keyboardManager.keyboardHeight>0 ? 0 : 60)
                    
                }
//                .frame(maxWidth: .infinity, maxHeight: .infinity)
//                .background(Color.blue)
//                .zIndex(1) // 确保主视图在顶部
                //MARK: - 前进按钮
                .background(
                    NavigationLink (destination: ContentView()) {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(selectedCircleIndices.count>0 ?
                                  RadialGradient(gradient: Gradient(colors: [Color.orange, Color.red]), center: .topLeading, startRadius: 0, endRadius: 90) :
                                    RadialGradient(gradient: Gradient(colors: [Color.secondary, Color.secondary]), center: .topLeading, startRadius: 0, endRadius: 90))
                            .frame(width: 100, height: 50)
                            .shadow(color: selectedCircleIndices.count>0 ? Color.orange : Color.gray, radius: 8, x: 0 , y: 5)
                            .offset(y: keyboardManager.keyboardHeight>0 ? 200 : 0)
                        
                            .overlay(Image(systemName: selectedCircleIndices.count>0 ? "arrowshape.forward.fill" : "arrowshape.forward.fill")
                                .foregroundColor(Color.white))
                            .font(.title2)
                            .bold()
                    }
                        .disabled(selectedCircleIndices.count>0 ? false : true)
                    
                    , alignment: .bottom)
                
                if showMenu {
                    VStack(alignment: .leading) {
                        HStack {
                            Spacer()
                            Button (action:{
                                withAnimation {
                                    showMenu.toggle()
                                }
                            }) {
                                Image(systemName: "arrow.left")
                                    .bold()
                                    .foregroundColor(Color.white)
                                    .font(.system(size: 30))
                            }
//                            Spacer()
                        }
                        VStack {
                            Button (action:{
                                
                            }) {
                                Text("按钮1")
                                    .font(.system(size: 20))
                                    .foregroundColor(Color.white)
                            }
                            .padding(.bottom, 30)
                            
                            Button (action:{
                                
                            }) {
                                Text("按钮2")
                                    .font(.system(size: 20))
                                    .foregroundColor(Color.white)
                            }
                            .padding(.bottom, 30)
                        }
                        .padding(.leading, 30)
                        .padding(.vertical, 50)
                        Spacer()
                    }
                    .frame(width: 180)
                    .padding()
                    .background(Color("Top_color"))
                    .transition(.move(edge: .leading))
                    .zIndex(1) // 确保主视图在顶部
                    .offset(x:-110)
                }
                
            }
            
        }
            .navigationViewStyle(StackNavigationViewStyle())
            .animation(.easeOut(duration: 0.16))
            .environmentObject(loginManager)
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

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
