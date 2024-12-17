//
//  Date+Additions.swift

import Foundation

extension Date {
    func toString(format: Format) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format.rawValue
        return dateFormatter.string(from: self)
    }
    
    func addOrSubtract(component: Calendar.Component, value: Int) -> Date {
        let calendar = Calendar.current
        if let modifiedDate = calendar.date(byAdding: component, value: value, to: self) {
            return modifiedDate
        } else {
            return self
        }
    }
    
    func isToday() -> Bool {
        let calendar = Calendar.current
        return calendar.isDateInToday(self)
    }
    
    func getCalendarComponent(period component: Calendar.Component) -> Int {
        let calendar = Calendar.current
        return calendar.component(component, from: self)
    }
    
    func isWeekend() -> Bool {
        let calendar = Calendar(identifier: .iso8601)
        let weekday = calendar.component(.weekday, from: self)
        return weekday == 7 || weekday == 1 // Суббота (7) и воскресенье (1) - выходные дни в Польше
    }
    
    func differenceBetweenDatesInHoursAndMinutes(from startDate: Date, to endDate: Date) -> (hours: Int, minutes: Int)? {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour, .minute], from: startDate, to: endDate)
        
        guard let hours = components.hour, let minutes = components.minute else {
            return nil
        }
        
        return (hours, minutes)
    }
    
    var startOfWeek: Date {
        let calendar: Calendar = {
            var calendar = Calendar.current
            calendar.locale = Locale(identifier: "pl_PL")
            calendar.firstWeekday = 3 // Понедельник
            return calendar
        }()
        
        let components = calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)
        return calendar.date(from: components)!
    }
}

extension Date {
    static var today: Date {
        let currentDate = Date()
        let calendar = Calendar.current
        return calendar.startOfDay(for: currentDate)
    }
    
    static func differenceBetweenDates(from startDate: Date,
                                       to endDate: Date,
                                       component: Calendar.Component) -> Int? {
        let calendar = Calendar.current
        let components = calendar.dateComponents([component], from: startDate, to: endDate)
        let value = components.value(for: component)
        
        return value
    }
}

extension Date {
    enum Format: String {
        case ddMMyyyy = "dd.MM.yyyy"
        case ddMMyy = "dd.MM.yy"
        case llll = "LLLL"
        case yyyy = "yyyy"
        case llllYYYY = "LLLL yyyy"
        case mmYY = "MM.yy"
        case hhmm = "HH'h' mm'm'"
        case HHMM = "HH:mm"
        case ddMMYYHHmm = "dd.MM.yy HH:mm"
        case dayOfWeek = "EEEE"
        case month = "MMMM"
    }
}
