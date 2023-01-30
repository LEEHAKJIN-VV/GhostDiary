//
//  HomeView.swift
//  GhostDiary
//
//  Created by 이학진 on 2022/12/14.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var authStores: AuthStore
    @EnvironmentObject var answerStores: AnswerStore
    @EnvironmentObject var questionStores: QuestionStore
    
    @Binding var isLogin: Bool
    @State private var isLoading: Bool = true
    
    var body: some View {
        if isLoading {
            LoadingView()
                .onAppear {
                    isLogin = true
                    
                    Task {
                        if let user = authStores.user {
                            await questionStores.fetchQuestions(user: user)
                            await answerStores.readQuestionAndAnswer(user)
                            isLoading = false
                        }
                    }
                }
        } else {
            //NavigationStack {
                TabView {
                    QuestionView(isLogin: $isLogin)
                        .tabItem {
                            Label("글쓰기", systemImage: "square.and.pencil")
                        }
                    TimeLineView(isLogin: $isLogin)
                        .tabItem {
                            Label("타임라인", systemImage: "calendar")
                        }
                    AnalysisView(isLogin: $isLogin)
                        .tabItem {
                            Label("분석보고서", systemImage: "chart.bar.fill")
                        }
                //}
//                .toolbar {
//                    ToolbarItem(placement: .navigationBarTrailing) {
//                        Button(action: {
//                            answerStores.questions.removeAll()
//                            answerStores.answers.removeAll()
//
//                            authStores.signOut()
//                            isLogin = false
//                            authStores.loginStatus = .defatult
//                            authStores.googleSignOut()
//                        }, label: {
//                            Text("로그 아웃")
//                        })
//                    }
//                }
            }
        }
    }
}


struct HomeView_Previews: PreviewProvider {
    @State static var isLogin: Bool = false
    static var previews: some View {
        HomeView(isLogin: $isLogin)
            .environmentObject(AuthStore())
            .environmentObject(QuestionStore())
            .environmentObject(AnswerStore())
    }
}
