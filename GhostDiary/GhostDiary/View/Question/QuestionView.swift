//
//  QuestionView.swift
//  GhostDiary
//
//  Created by 이학진 on 2022/12/14.
//

import SwiftUI

struct QuestionView: View {
    @State var isShowingEmojiSheet: Bool = false
    @State var isShowingQuestionSheet: Bool = false
    @State var todayEmoji: String = ""
    @EnvironmentObject var questionStore: QuestionStore
    
    var body: some View {
        VStack {
            Spacer()
            GhostImageView()
            Spacer()
            
            Button {
                isShowingEmojiSheet.toggle()
            } label: {
                QuestionBoxView()
            }
            
        }
        .padding([.bottom], 60)
        .onAppear {
            questionStore.fetchQuestions()
        }
        .sheet(isPresented: $isShowingEmojiSheet) {
            CheckEmojiView(todayEmoji: $todayEmoji, isShowingEmojiSheet: $isShowingEmojiSheet, isShowingQuestionSheet: $isShowingQuestionSheet)
                .onDisappear {
                    if isShowingEmojiSheet == false {
                        isShowingQuestionSheet = true
                    }
                } // 실행하고나서 이 코드를 실행해라!, 화면이 닫힐 때
                .presentationDetents([.fraction(0.54)])
        } // 이모지 선택
        .fullScreenCover(isPresented: $isShowingQuestionSheet) {
            AnswerView(todayEmoji: $todayEmoji, question: Question(id: "4NaHZRvAel0DFgJQWHv0", number: "1", query: "오늘 점심은 어떤걸 드셨나요"))
        }
        
    }
}

struct QuestionView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionView()
    }
}
