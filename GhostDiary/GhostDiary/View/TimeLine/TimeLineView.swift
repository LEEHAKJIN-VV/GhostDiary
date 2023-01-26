//
//  TimeLineView.swift
//  GhostDiary
//
//  Created by 이학진 on 2022/12/31.
//

import SwiftUI

struct TimeLineView: View {
    @EnvironmentObject var answersStores: AnswerStore
    @State private var tabSelection: Int = 1
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .trailing) {
                if answersStores.answers.count > 0 {
                    Spacer()
                    TimeLineCustomTabBar(selection: $tabSelection)
                        .padding()
                    
                    switch tabSelection {
                    case 1:
                        CalendarView()
                    case 2:
                        HistoryListView()
                            .navigationBarBackButtonHidden(true)
                    default:
                        CalendarView()
                    }
                } else {
                    //TODO: - Empty뷰 추가
                    TimeLineEmptyView()
                }
            }
            .navigationTitle("Ghost Diary")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct TimeLineView_Previews: PreviewProvider {
    static var previews: some View {
        TimeLineView()
            .environmentObject(AnswerStore())
    }
}
