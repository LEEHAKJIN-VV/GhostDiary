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
        .sheet(isPresented: $isShowingEmojiSheet) {
            CheckEmojiView(isShowingEmojiSheet: $isShowingEmojiSheet, isShowingQuestionSheet: $isShowingQuestionSheet)
                .onDisappear {
                    if isShowingEmojiSheet == false {
                        isShowingQuestionSheet = true
                    }
                } // 실행하고나서 이 코드를 실행해라!, 화면이 닫힐 때
                .presentationDetents([.fraction(0.4)])
        } // 이모지 선택
        .fullScreenCover(isPresented: $isShowingQuestionSheet) {
            AnswerView()
        }
        
    }
}

struct QuestionView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionView()
    }
}
