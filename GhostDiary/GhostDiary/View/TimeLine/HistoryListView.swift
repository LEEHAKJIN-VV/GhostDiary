//
//  HistoryListView.swift
//  GhostDiary
//
//  Created by 이학진 on 2022/12/14.
//

import SwiftUI

struct HistoryListView: View {
    @EnvironmentObject var authStores: AuthStore
    @EnvironmentObject var answerStores: AnswerStore
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            ForEach(answerStores.answers.indices, id: \.self) { idx in
                HistoryListCellView(question: answerStores.questions[idx], answer: answerStores.answers[idx])
            }
        }
        
    }
}

struct HistoryListView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryListView()
            .environmentObject(AuthStore())
            .environmentObject(AnswerStore())
    }
}
