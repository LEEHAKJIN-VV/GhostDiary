//
//  CustomDatePicker.swift
//  GhostDiary
//
//  Created by 이학진 on 2023/01/01.
//

import SwiftUI

struct CustomDatePicker: View {
    @EnvironmentObject var authStores: AuthStore
    @StateObject var timelineStores = TimeLineStore()
    @Binding var currentDate: Date
    
    @EnvironmentObject var answerStores: AnswerStore
    
    // Month update on arrow button
    @State var currentMonth: Int = 0
    
    let days: [String] = ["일", "월", "화", "수", "목", "금", "토"]
    
    var today: Int {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd"
        let currentToday = formatter.string(from: Date())
        return Int(currentToday) ?? -1
    }
    
    var body: some View {
        VStack(spacing: 30) {
            // Days...
            HStack(spacing: 20) {
                VStack(alignment: .leading, spacing: 10) {
                    Text(extraData()[0])
                        .font(.caption)
                        .fontWeight(.semibold)
                    Text(extraData()[1])
                        .font(.title.bold())
                }
                
                Spacer(minLength: 0)
                
                Button {
                    currentMonth -= 1
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.title2)
                }
                Button {
                    currentMonth += 1
                } label: {
                    Image(systemName: "chevron.right")
                        .font(.title2)
                }
            }
            .padding(.horizontal)
            
            // 요일 뷰
            VStack {
                HStack(spacing: 10) {
                    ForEach(days, id: \.self) { day in
                        Text(day)
                            .font(.callout)
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                    }
                }
                // 날짜 뷰
                let columns = Array(repeating: GridItem(.flexible()), count: 7)
                
                LazyVGrid(columns: columns, spacing: 15) {
                    ForEach(extractDate()) { value in
                        CardView(value: value)
                            .padding(.bottom)
                    }
                }
            }
        }
        // 날짜 변경
        .onChange(of: currentMonth) { newValue in
            currentDate = getCurrentMonth()
        }
    }
    
    @ViewBuilder
    func CardView(value: CalendarDate) -> some View {
        VStack {
            if value.day != -1 {
                VStack {
                    if value.day == today { // 오늘 날짜인 경우
                        Text("\(value.day)")
                            .font(.caption.bold())
                            .background {
                                Circle()
                                    .frame(width: 20, height: 20)
                                    .foregroundColor(.pink)
                            }
                    } else {
                        Text("\(value.day)")
                            .font(.caption.bold())
                    }
                    
                    let answers = answerStores.answers
                        .filter {$0.timestamp.getDay() == value.date.getDay() }
                        
                    if answers.count > 0 {
                        let answer = answers.first!
                        Image(answer.expression)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 30, height: 30)
                    } else {
                        Circle()
                            .frame(width: 30, height: 30)
                            .foregroundColor(Color(UIColor.systemGray6))
                    }
                }
            }
        }
        //.frame(height: 60, alignment: .top)
    }
    
    // extracting year and month for display
    func extraData() -> [String] {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko")
        formatter.dateFormat = "YYYY MMMM"
        
        let date = formatter.string(from: currentDate)
        
        print("ss : \(date.components(separatedBy: " "))")
        
        return date.components(separatedBy: " ")
    }
    
    func getCurrentMonth() -> Date {
        let calendar = Calendar.current
        
        guard let currentMonth = calendar.date(byAdding: .month, value: self.currentMonth, to: Date()) else { return Date() }
        
        return currentMonth
    }
    
    func extractDate() -> [CalendarDate] {
        // Getting Current Month Date
        
        let calendar = Calendar.current
        print("calendar: \(calendar)")
        
        let currentMonth = getCurrentMonth()
        
        var days =  currentMonth.getAllDates().compactMap { date -> CalendarDate in
            let day = calendar.component(.day, from: date)
            
            return CalendarDate(day: day, date: date)
        }

        // adding offeset days
        let firstWeekday = calendar.component(.weekday, from: days.first?.date ?? Date())
        
        for _ in 0..<firstWeekday - 1 {
            days.insert(CalendarDate(day: -1, date: Date()), at: 0)
        }
        
        return days
    }
}

struct CustomDatePicker_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
            .environmentObject(AuthStore())
            .environmentObject(AnswerStore())
    }
}
