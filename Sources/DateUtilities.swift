// import Foundation

// // General Thanks: AshFurrow, sstreza, Scott Lawrence, Kevin Ballard, NoOneButMe, Avi`, August Joki. Emanuele Vulcano, jcromartiej, Blagovest Dachev, Matthias Plappert,  Slava Bushtruk, Ali Servet Donmez, Ricardo1980, pip8786, Danny Thuerin, Dennis Madsen

// // Base utility
// extension NSDate {
//     /// Returns date's time interval since reference date
//     public var interval: TimeInterval { return self.timeIntervalSinceReferenceDate }

//     /// Returns common shared calendar, user's preferred calendar
//     public static var sharedCalendar = NSCalendar.autoupdatingCurrent
// }

// // Subscripting
// extension NSDateComponents {
//     /// Adds date component subscripting
//     public subscript(component: NSCalendar.Component) -> Int? {
//         switch component {
//         case .era: return self.era
//         case .year: return self.year
//         case .month: return self.month
//         case .day: return self.day
//         case .hour: return self.hour
//         case .minute: return self.minute
//         case .second: return self.second
//         case .weekday: return self.weekday
//         case .weekdayOrdinal: return self.weekdayOrdinal
//         case .quarter: return self.quarter
//         case .weekOfMonth: return self.weekOfMonth
//         case .weekOfYear: return self.weekOfYear
//         case .yearForWeekOfYear: return self.yearForWeekOfYear
//         case .nanosecond: return self.nanosecond
//         // case .calendar: return self.calendar
//         // case .timeZone: return self.timeZone
//         default: return nil
//         }
//     }
// }

// // Date component retrieval
// // Some of these are entirely pointless but I have included all components
// public extension NSDate {
//     /// Returns instance's year component
//     public var year: Int { return NSDate.sharedCalendar().component(.year, from: self) }
//     /// Returns instance's month component
//     public var month: Int { return NSDate.sharedCalendar().component(.month, from: self) }
//     /// Returns instance's day component
//     public var day: Int { return NSDate.sharedCalendar().component(.day, from: self) }
//     /// Returns instance's hour component
//     public var hour: Int { return NSDate.sharedCalendar().component(.hour, from: self) }
//     /// Returns instance's minute component
//     public var minute: Int { return NSDate.sharedCalendar().component(.minute, from: self) }
//     /// Returns instance's second component
//     public var second: Int { return NSDate.sharedCalendar().component(.second, from: self) }

//     /// Returns instance's weekday component
//     public var weekday: Int { return NSDate.sharedCalendar().component(.weekday, from: self) }
//     /// Returns instance's weekdayOrdinal component
//     public var weekdayOrdinal: Int { return NSDate.sharedCalendar().component(.weekdayOrdinal, from: self) }
//     /// Returns instance's weekOfMonth component
//     public var weekOfMonth: Int { return NSDate.sharedCalendar().component(.weekOfMonth, from: self) }
//     /// Returns instance's weekOfYear component
//     public var weekOfYear: Int { return NSDate.sharedCalendar().component(.weekOfYear, from: self) }

//     /// Returns instance's yearForWeekOfYear component
//     public var yearForWeekOfYear: Int { return NSDate.sharedCalendar().component(.yearForWeekOfYear, from: self) }

//     /// Returns instance's quarter component
//     public var quarter: Int { return NSDate.sharedCalendar().component(.quarter, from: self) }

//     /// Returns instance's nanosecond component
//     public var nanosecond: Int { return NSDate.sharedCalendar().component(.nanosecond, from: self) }
//     /// Returns instance's (meaningless) era component
//     public var era: Int { return NSDate.sharedCalendar().component(.era, from: self) }
//     /// Returns instance's (meaningless) calendar component
//     public var calendar: Int { return NSDate.sharedCalendar().component(.calendar, from: self) }
//     /// Returns instance's (meaningless) timeZone component.
//     public var timeZone: Int { return NSDate.sharedCalendar().component(.timeZone, from: self) }
// }

// // Formatters and Strings
// public extension NSDate {
//     /// Returns the current time as a Date instance
//     public static var now: NSDate { return NSDate(timeIntervalSinceNow: 0) }

//     /// Returns an ISO 8601 formatter
//     public static var iso8601Formatter: DateFormatter = {
//         $0.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
//         $0.locale = Locale(identifier: "en_US_POSIX")
//         return $0 }(NSDateFormatter())
//     /// Returns a short style date formatter
//     public static var shortDateFormatter: NSDateFormatter = { $0.dateStyle = .short; return $0 }(NSDateFormatter())
//     /// Returns a medium style date formatter
//     public static var mediumDateFormatter: NSDateFormatter = { $0.dateStyle = .medium; return $0 }(NSDateFormatter())
//     /// Returns a long style date formatter
//     public static var longDateFormatter: NSDateFormatter = { $0.dateStyle = .long; return $0 }(NSDateFormatter())
//     /// Returns a full style date formatter
//     public static var fullDateFormatter: NSDateFormatter = { $0.dateStyle = .full; return $0 }(NSDateFormatter())
//     /// Returns a short style time formatter
//     public static var shortTimeFormatter: NSDateFormatter = { $0.timeStyle = .short; return $0 }(NSDateFormatter())
//     /// Returns a medium style time formatter
//     public static var mediumTimeFormatter: NSDateFormatter = { $0.timeStyle = .medium; return $0 }(NSDateFormatter())
//     /// Returns a long style time formatter
//     public static var longTimeFormatter: NSDateFormatter = { $0.timeStyle = .long; return $0 }(NSDateFormatter())
//     /// Returns a full style time formatter
//     public static var fullTimeFormatter: NSDateFormatter = { $0.timeStyle = .full; return $0 }(NSDateFormatter())

//     /// Represents date as ISO8601 string
//     public var iso8601String: String { return NSDate.iso8601Formatter.string(from: self) }

//     /// Returns date components as short string
//     public var shortDateString: String { return NSDate.shortDateFormatter.string(from:self) }
//     /// Returns date components as medium string
//     public var mediumDateString: String { return NSDate.mediumDateFormatter.string(from:self) }
//     /// Returns date components as long string
//     public var longDateString: String { return NSDate.longDateFormatter.string(from:self) }
//     /// Returns date components as full string
//     public var fullDateString: String { return NSDate.fullDateFormatter.string(from:self) }

//     /// Returns time components as short string
//     public var shortTimeString: String { return NSDate.shortTimeFormatter.string(from:self) }
//     /// Returns time components as medium string
//     public var mediumTimeString: String { return NSDate.mediumTimeFormatter.string(from:self) }
//     /// Returns time components as long string
//     public var longTimeString: String { return NSDate.longTimeFormatter.string(from:self) }
//     /// Returns time components as full string
//     public var fullTimeString: String { return NSDate.fullTimeFormatter.string(from:self) }

//     /// Returns date and time components as short string
//     public var shortString: String { return "\(self.shortDateString) \(self.shortTimeString)" }
//     /// Returns date and time components as medium string
//     public var mediumString: String { return "\(self.mediumDateString) \(self.mediumTimeString)" }
//     /// Returns date and time components as long string
//     public var longString: String { return "\(self.longDateString) \(self.longTimeString)" }
//     /// Returns date and time components as full string
//     public var fullString: String { return "\(self.fullDateString) \(self.fullTimeString)" }
// }

// // Standard interval reference
// // Not meant to replace `offset(_: Calendar.Component, _: Int)` to offset dates
// public extension NSDate {
//     /// Returns number of seconds per second
//     public static let second: NSTimeInterval = 1
//     /// Returns number of seconds per minute
//     public static let minute: NSTimeInterval = 60
//     /// Returns number of seconds per hour
//     public static let hour: NSTimeInterval = 3600
//     /// Returns number of seconds per 24-hour day
//     public static let day: NSTimeInterval = 86400
//     /// Returns number of seconds per standard week
//     public static let week: NSTimeInterval = 604800
// }

// // Utility for interval math
// // Not meant to replace `offset(_: Calendar.Component, _: Int)` to offset dates
// public extension Int {
//     /// Returns number of seconds in n seconds
//     public var seconds: NSTimeInterval { return NSTimeInterval(self) * NSDate.second }
//     /// Returns number of seconds in n minutes
//     public var minutes: NSTimeInterval { return NSTimeInterval(self) * NSDate.minute }
//     /// Returns number of seconds in n hours
//     public var hours: NSTimeInterval { return NSTimeInterval(self) * NSDate.hour }
//     /// Returns number of seconds in n 24-hour days
//     public var days: NSTimeInterval { return NSTimeInterval(self) * NSDate.day }
//     /// Returns number of seconds in n standard weeks
//     public var weeks: NSTimeInterval { return NSTimeInterval(self) * NSDate.week }
// }

// // Components
// public extension NSDate {
//     /// Returns set of common date components
//     public static var dateComponents: Set<NSCalendar.Component> = [.year, .month, .day, .hour, .minute, .second]
//     /// Returns set of exhaustive date components
//     public static var allComponents: Set<NSCalendar.Component> = [.era, .year, .month, .day, .hour, .minute, .second, .weekday, .weekdayOrdinal, .quarter, .weekOfMonth, .weekOfYear, .yearForWeekOfYear, .nanosecond, .calendar, .timeZone]

//     /// Extracts common date components for date
//     public var components: DateComponents { return NSDate.sharedCalendar().dateComponents(NSDate.dateComponents, from: self) }
//     /// Extracts all date components for date
//     public var allComponents: DateComponents { return NSDate.sharedCalendar().dateComponents(NSDate.allComponents, from: self) }

//     /// Offset a date by n calendar components. Can be functionally chained
//     /// For example:
//     ///
//     /// ```
//     /// let afterThreeDays = NSDate.offset(.day, 3)
//     /// print(NSDate.now.offset(.day, 3).offset(.hour, 1).fullString)
//     /// ```
//     ///
//     /// Not all components or offsets are useful
//     public func offset(_ component: NSCalendar.Component, _ count: Int) -> NSDate {
//         var newComponent: NSDateComponents = NSDateComponents(second: 0)
//         switch component {
//         case .era: newComponent = NSDateComponents(era: count)
//         case .year: newComponent = NSDateComponents(year: count)
//         case .month: newComponent = NSDateComponents(month: count)
//         case .day: newComponent = NSDateComponents(day: count)
//         case .hour: newComponent = NSDateComponents(hour: count)
//         case .minute: newComponent = NSDateComponents(minute: count)
//         case .second: newComponent = NSDateComponents(second: count)
//         case .weekday: newComponent = NSDateComponents(weekday: count)
//         case .weekdayOrdinal: newComponent = NSDateComponents(weekdayOrdinal: count)
//         case .quarter: newComponent = NSDateComponents(quarter: count)
//         case .weekOfMonth: newComponent = NSDateComponents(weekOfMonth: count)
//         case .weekOfYear: newComponent = NSDateComponents(weekOfYear: count)
//         case .yearForWeekOfYear: newComponent = NSDateComponents(yearForWeekOfYear: count)
//         case .nanosecond: newComponent = NSDateComponents(nanosecond: count)
//         // These items complete the component vocabulary but cannot be used in this way
//         // case .calendar: newComponent = DateComponents(calendar: count)
//         // case .timeZone: newComponent = DateComponents(timeZone: count)
//         default: break
//         }

//         // If offset is not possible, return unmodified date
//         return NSDate.sharedCalendar().date(byAdding: newComponent, to: self) ?? self
//     }
// }

// // Alternative offset approach that constructs date components for offset duty
// // I find this more verbose, less readable, less functional but your mileage may vary
// extension NSDateComponents {
//     /// Returns components populated by n years
//     public static func years(_ count: Int) -> NSDateComponents { return NSDateComponents(year: count) }
//     /// Returns components populated by n months
//     public static func months(_ count: Int) -> NSDateComponents { return NSDateComponents(month: count) }
//     /// Returns components populated by n days
//     public static func days(_ count: Int) -> NSDateComponents { return NSDateComponents(day: count) }
//     /// Returns components populated by n hours
//     public static func hours(_ count: Int) -> NSDateComponents { return NSDateComponents(hour: count) }
//     /// Returns components populated by n minutes
//     public static func minutes(_ count: Int) -> NSDateComponents { return NSDateComponents(minute: count) }
//     /// Returns components populated by n seconds
//     public static func seconds(_ count: Int) -> NSDateComponents { return NSDateComponents(second: count) }
//     /// Returns components populated by n nanoseconds
//     public static func nanoseconds(_ count: Int) -> NSDateComponents { return NSDateComponents(nanosecond: count) }
// }

// /// Performs calendar math using date components as alternative
// /// to `offset(_: Calendar.Component, _: Int)`
// /// e.g.
// /// ```swift
// /// print((NSDate.now + DateComponents.days(3) + DateComponents.hours(1)).fullString)
// /// ```
// public func +(lhs: NSDate, rhs: NSDateComponents) -> NSDate {
//     return NSDate.sharedCalendar().date(byAdding: rhs, to: lhs)! // yes force unwrap. sue me.
// }

// // Date characteristics
// extension NSDate {
//     /// Returns true if date falls before current date
//     public var isPast: Bool { return self < NSDate.now }
//     /// Returns true if date falls after current date
//     public var isFuture: Bool { return self > NSDate.now }

//     /// Returns true if date falls on typical weekend
//     public var isTypicallyWeekend: Bool {
//         return NSDate.sharedCalendar().isDateInWeekend(self)
//     }
//     /// Returns true if date falls on typical workday
//     public var isTypicallyWorkday: Bool { return !self.isTypicallyWeekend }
// }

// // Date distances
// public extension NSDate {
//     /// Returns the time interval between two dates
//     static public func interval(_ date1: Date, _ date2: Date) -> NSTimeInterval {
//         return date2.interval - date1.interval
//     }
//     /// Returns a time interval between the instance and another date
//     public func interval(to date: Date) -> NSTimeInterval {
//         return NSDate.interval(self, date)
//     }

//     /// Returns the distance between two dates
//     /// using the user's preferred calendar
//     /// e.g.
//     /// ```
//     /// let date1 = NSDate.shortDateFormatter.date(from: "1/1/16")!
//     /// let date2 = NSDate.shortDateFormatter.date(from: "3/13/16")!
//     /// NSDate.distance(date1, to: date2, component: .day) // 72
//     /// ```
//     /// - Warning: Returns 0 for bad components rather than crashing
//     static public func distance(_ date1: Date, to date2: Date, component: NSCalendar.Component) -> Int {
//         return NSDate.sharedCalendar().dateComponents([component], from: date1, to: date2)[component] ?? 0
//     }

//     /// Returns the distance between the instance and another date
//     /// using the user's preferred calendar
//     /// e.g.
//     /// ```
//     /// let date1 = NSDate.shortDateFormatter.date(from: "1/1/16")!
//     /// let date2 = NSDate.shortDateFormatter.date(from: "3/13/16")!
//     /// date1.distance(to: date2, component: .day) // 72
//     /// ```
//     /// - Warning: Returns 0 for bad components rather than crashing
//     public func distance(to date: Date, component: NSCalendar.Component) -> Int {
//         return NSDate.sharedCalendar().dateComponents([component], from: self, to: date)[component] ?? 0
//     }

//     /// Returns the number of days between the instance and a given NSDate. May be negative
//     public func days(to date: Date) -> Int { return distance(to: date, component: .day) }
//     /// Returns the number of hours between the instance and a given NSDate. May be negative
//     public func hours(to date: Date) -> Int { return distance(to: date, component: .hour) }
//     /// Returns the number of minutes between the instance and a given NSDate. May be negative
//     public func minutes(to date: Date) -> Int { return distance(to: date, component: .minute) }
//     /// Returns the number of seconds between the instance and a given NSDate. May be negative
//     public func seconds(to date: Date) -> Int { return distance(to: date, component: .second) }

//     /// Returns a (days, hours, minutes, seconds) tuple representing the
//     /// time remaining between the instance and a target NSDate.
//     /// Not for exact use. For example:
//     ///
//     /// ```
//     /// let test = NSDate.now.addingTimeInterval(5.days + 3.hours + 2.minutes + 10.seconds)
//     /// print(NSDate.now.offsets(to: test))
//     /// // prints (5, 3, 2, 10 or possibly 9 but rounded up)
//     /// ```
//     ///
//     /// - Warning: returns 0 for any error when fetching component
//     public func offsets(to date: NSDate) -> (days: Int, hours: Int, minutes: Int, seconds: Int) {
//         let components = NSDate.sharedCalendar()
//             .dateComponents([.day, .hour, .minute, .second],
//                             from: self, to: NSDate.addingTimeInterval(0.5)) // round up
//         return (
//             days: components[.day] ?? 0,
//             hours: components[.hour] ?? 0,
//             minutes: components[.minute] ?? 0,
//             seconds: components[.second] ?? 0
//         )
//     }
// }

// // Utility
// public extension NSDate {
//     /// Return the nearest hour using a 24 hour clock
//     public var nearestHour: Int { return (self.offset(.minute, 30)).hour }

//     /// Return the nearest minute
//     public var nearestMinute: Int { return (self.offset(.second, 30)).minute }
// }

// // Canonical dates
// extension NSDate {

//     /// Returns a date representing midnight at the start of this day
//     public var startOfDay: NSDate {
//         let midnight = NSDateComponents(year: components.year, month: components.month, day: components.day)
//         // If offset is not possible, return unmodified date
//         return NSDate.sharedCalendar().date(from: midnight) ?? self
//     }
//     /// Returns a date representing midnight at the start of this day.
//     /// Is synonym for `startOfDay`.
//     public var today: NSDate { return self.startOfDay }
//     /// Returns a date representing midnight at the start of tomorrow
//     public var tomorrow: NSDate { return self.today.offset(.day, 1) }
//     /// Returns a date representing midnight at the start of yesterday
//     public var yesterday: NSDate { return self.today.offset(.day, -1) }

//     /// Returns today's date at the midnight starting the day
//     public static var today: NSDate { return NSDate.now.startOfDay }
//     /// Returns tomorrow's date at the midnight starting the day
//     public static var tomorrow: NSDate { return NSDate.today.offset(.day, 1) }
//     /// Returns yesterday's date at the midnight starting the day
//     public static var yesterday: NSDate { return NSDate.today.offset(.day, -1) }

//     /// Returns a date representing a second before midnight at the end of the day
//     public var endOfDay: NSDate { return self.tomorrow.startOfDay.offset(.second, -1) }
//     /// Returns a date representing a second before midnight at the end of today
//     public static var endOfToday: NSDate { return NSDate.now.endOfDay }

//     /// Determines whether two days share the same date
//     public static func sameDate(_ date1: NSDate, _ date2: NSDate) -> Bool {
//         return NSDate.sharedCalendar().isDate(date1, inSameDayAs: date2)
//     }

//     /// Returns true if this date is the same date as today for the user's preferred calendar
//     public var isToday: Bool { return NSDate.sharedCalendar().isDateInToday(self) }
//     /// Returns true if this date is the same date as tomorrow for the user's preferred calendar
//     public var isTomorrow: Bool { return NSDate.sharedCalendar().isDateInTomorrow(self) }
//     /// Returns true if this date is the same date as yesterday for the user's preferred calendar
//     public var isYesterday: Bool { return NSDate.sharedCalendar().isDateInYesterday(self) }

//     /// Returns the start of the instance's week of year for user's preferred calendar
//     public var startOfWeek: NSDate {
//         let components = self.allComponents
//         let startOfWeekComponents = NSDateComponents(weekOfYear: components.weekOfYear, yearForWeekOfYear: components.yearForWeekOfYear)
//         // If offset is not possible, return unmodified date
//         return NSDate.sharedCalendar().date(from: startOfWeekComponents) ?? self
//     }
//     /// Returns the start of the current week of year for user's preferred calendar
//     public static var thisWeek: NSDate {
//         return NSDate.now.startOfWeek
//     }

//     /// Returns the start of next week of year for user's preferred calendar
//     public var nextWeek: NSDate { return self.offset(.weekOfYear, 1) }
//     /// Returns the start of last week of year for user's preferred calendar
//     public var lastWeek: NSDate { return self.offset(.weekOfYear, -1) }
//     /// Returns the start of next week of year for user's preferred calendar relative to date
//     public static var nextWeek: NSDate { return NSDate.now.offset(.weekOfYear, 1) }
//     /// Returns the start of last week of year for user's preferred calendar relative to date
//     public static var lastWeek: NSDate { return NSDate.now.offset(.weekOfYear, -1) }

//     /// Returns true if two weeks likely fall within the same week of year
//     /// in the same year, or very nearly the same year
//     public static func sameWeek(_ date1: Date, _ date2: Date) -> Bool {
//         return date1.startOfWeek == date2.startOfWeek
//     }

//     /// Returns true if date likely falls within the current week of year
//     public var isThisWeek: Bool { return NSDate.sameWeek(self, NSDate.thisWeek) }
//     /// Returns true if date likely falls within the next week of year
//     public var isNextWeek: Bool { return NSDate.sameWeek(self, NSDate.nextWeek) }
//     /// Returns true if date likely falls within the previous week of year
//     public var isLastWeek: Bool { return NSDate.sameWeek(self, NSDate.lastWeek) }

//     /// Returns the start of year for the user's preferred calendar
//     public static var thisYear: NSDate {
//         let components = NSDate.now.components
//         let theyear = NSDateComponents(year: components.year)
//         // If offset is not possible, return unmodified date
//         return NSDate.sharedCalendar().date(from: theyear) ?? NSDate.now
//     }
//     /// Returns the start of next year for the user's preferred calendar
//     public static var nextYear: NSDate { return thisYear.offset(.year, 1) }
//     /// Returns the start of previous year for the user's preferred calendar
//     public static var lastYear: NSDate { return thisYear.offset(.year, -1) }

//     /// Returns true if two dates share the same year component
//     public static func sameYear(_ date1: NSDate, _ date2: NSDate) -> Bool {
//         return date1.allComponents.year == date2.allComponents.year
//     }

//     /// Returns true if date falls within this year for the user's preferred calendar
//     public var isThisYear: Bool { return NSDate.sameYear(self, NSDate.thisYear) }
//     /// Returns true if date falls within next year for the user's preferred calendar
//     public var isNextYear: Bool { return NSDate.sameYear(self, NSDate.nextYear) }
//     /// Returns true if date falls within previous year for the user's preferred calendar
//     public var isLastYear: Bool { return NSDate.sameYear(self, NSDate.lastYear) }
// }
