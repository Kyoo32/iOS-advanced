


/* NSDate : basic syntax */

NSDate *now = [NSDate date];
NSTimeInterval secondsInWeek = 7 * 24 * 60 * 60;
NSDate *lastWeek = [NSDate dateWithTimeInterval: -secondsInWeek
                                      sinceDate: now];
NSDate *nextWeek = [NSDate dateWithTimeInterval: secondsInWeek
                                      sinceDate: now];

//it contains the date, the time of day and the time zone
//ex) 2012-11-06 02:24:00 (GMT)


/* to compare, provided by NSNumber */

NSComparisonResult result = [now compare:nextWeek];
if (result == NSOrderedAscending) {
    NSLog(@"now < nextWeek");
} else if (result == NSOrderedSame) {
    NSLog(@"now == nextWeek");
} else if (result = NSOrderedDescending) {
    NSLog(@"now > nextWeek");
}
NSDate *earlierDate = [now earlierDate:lastWeek];
NSDate *laterDate = [now laterDate:lastWeek];
NSLog(@"%@ is earlier than %@", earlierDate, laterDate);



//NSCalender is to provide a high-level API for date-related calculatinos
/* NSCalender : basic syntax */
//1.dateByAddingComponents:toDate:options:
NSDate *now = [NSDate date];
NSCalender *calender = [[NSCalender alloc]initWithCalendarIdentifier:NSGregorianCalender];
NSDateComponents *components = [[NSDateComponents alloc]init];
[components setMonth:1];
NSDate *oneMonthFromNow = [calender dateByAddingComponents:components
                                                    toDate:now
                                                   options:0];
NSLog(@"%@",oneMonthFromNow);
//This shows how the meaning of date components is entirely dependent on how it's used.
//Instead of representing a date, the above components represent a DURATION.
//Note that dateByAddingComponents:toDate:options: is a calendar-aware operation ( > NSDate’s low-level dateWithTimeInterval:sinceDate: method )


//2.components:fromDate:toDate:options:
NSDate *start = [NSDate dateWithTimeIntervalSinceReferenceDate:0];
NSDate *end = [NSDate date];
NSCalendar *calendar = [NSCalendar currentCalendar];
NSCalendarUnit units = NSWeekCalendarUnit;
NSDateComponents *components = [calendar components:units
                                           fromDate:start
                                             toDate:end
                                            options:0];
NSLog(@"It has been %ld weeks since January 1st, 2001",
      [components week]);



/* NSDateFormatter : Basic syntax */
//Whereas calendars decompose a date into an NSDateComponents object, date formatters convert between NSDate’s and NSString’s.










