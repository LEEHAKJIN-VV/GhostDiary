//
//  HomeView.swift
//  GhostDiary
//
//  Created by 이학진 on 2022/12/14.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var authStores: AuthStore
    @Binding var isLogin: Bool
    
    var body: some View {
//        VStack {
//            Button("logOut") {
//                authStores.signOut()
//                isLogin = false
//                authStores.loginStatus = .defatult
//                authStores.googleSignOut()
//            }
//
//            Spacer()
//            GhostImageView()
//            Spacer()
//            QuestionBoxView()
//                .padding(.bottom, 30)
//            //offset이였는데 학진님 아이디어 굳..
//        }
//        .onAppear {
//            isLogin = true
//        }
        NavigationStack {
            TabView {
                QuestionView()
                    .tabItem {
                        Label("글쓰기", systemImage: "square.and.pencil")
                    }
                CalendarView()
                    .tabItem {
                        Label("타임라인", systemImage: "calendar")
                    }
                AnalysisView()
                    .tabItem {
                        Label("분석보고서", systemImage: "chart.bar.fill")
                    }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        authStores.signOut()
                        isLogin = false
                        authStores.loginStatus = .defatult
                        authStores.googleSignOut()
                    }, label: {
                        Text("로그 아웃")
                    })
                }
            }
        }
        .onAppear {
            isLogin = true
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    @State static var isLogin: Bool = false
    static var previews: some View {
        HomeView(isLogin: $isLogin)
            .environmentObject(AuthStore())
    }
}
