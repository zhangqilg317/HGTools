//
//  HGTimeTool.m
//  HGTools
//
//  Created by 张奇 on 2018/2/24.
//  Copyright © 2018年 com.ebest. All rights reserved.
//

#import "HGTimeTool.h"

@implementation HGTimeTool
/**
 获取当前日期的字符串形式
 
 @param formate 日期格式 ex.yyyy-MM-dd HH:mm:ss
 @return 字符串日期
 */
+ (NSString *)currentTimeWithFormate:(NSString *)formate{
    NSDate *now = [NSDate date];
    NSDateFormatter *nowFormate = [[NSDateFormatter alloc] init];
    nowFormate.dateFormat = formate;
    NSString *nowTime = [nowFormate stringFromDate:now];
    return nowTime;
}

/**
 获取当前系统时间的时间戳

 @return 时间戳
 */
+(NSInteger)getNowTimestamp{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    //设置时区,这个对于时间的处理有时很重要
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setTimeZone:timeZone];
    NSDate *datenow = [NSDate date];//现在时间
    NSLog(@"设备当前的时间:%@",[formatter stringFromDate:datenow]);
    //时间转时间戳的方法:
    NSInteger timeSp = [[NSNumber numberWithDouble:[datenow timeIntervalSince1970]] integerValue];
    NSLog(@"设备当前的时间戳:%ld",(long)timeSp); //时间戳的值
    return timeSp;
}

/**
 将某个时间转化成时间戳

 @param formatTime 时间字符串
 @param format 时间格式
 @return 时间戳
 */
+(NSInteger)timeSwitchTimestamp:(NSString *)formatTime andFormatter:(NSString *)format{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:format]; //(@"YYYY-MM-dd hh:mm:ss") ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setTimeZone:timeZone];
    NSDate* date = [formatter dateFromString:formatTime]; //------------将字符串按formatter转成nsdate
    //时间转时间戳的方法:
    NSInteger timeSp = [[NSNumber numberWithDouble:[date timeIntervalSince1970]] integerValue];
    NSLog(@"将某个时间转化成 时间戳&&&&&&&timeSp:%ld",(long)timeSp); //时间戳的值
    return timeSp;
}

/**
 将某个时间戳转化成时间

 @param timestamp 时间戳
 @param format 格式
 @return 时间字符串
 */
+(NSString *)timestampSwitchTime:(NSInteger)timestamp andFormatter:(NSString *)format{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:format]; // （@"YYYY-MM-dd hh:mm:ss"）----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setTimeZone:timeZone];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:timestamp];
    NSLog(@"1296035591  = %@",confromTimesp);
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    //NSLog(@"&&&&&&&confromTimespStr = : %@",confromTimespStr);
    return confromTimespStr;
}

+ (NSString *)currentCycleEndTimeStrWithType:(EndTimeType)type
                             withCurrentDate:(NSString *)currentDateStr {
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorian components:NSCalendarUnitWeekday | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:[self cycleDateFromString:currentDateStr]];
    switch (type) {
        case EndTimeTypeDay:
            [components setDay:([components day]+1)];
            break;
        case EndTimeTypeWeek:
            [components setDay:([components day]+7)];
            break;
        case EndTimeTypeMonth:
            [components setMonth:([components month]+1)];
            break;
        default:
            break;
    }
    
    NSDate *beginningOfWeek = [gregorian dateFromComponents:components];
    NSDateFormatter *dateday = [[NSDateFormatter alloc] init];
    [dateday setDateFormat:@"yyy-MM-dd"];
    return [dateday stringFromDate:beginningOfWeek];
}

/**
 将时间日期字符串 转化为 对应的  date

 @param dateStr 时间字符串
 @return 时间
 */
+ (NSDate *)cycleDateFromString:(NSString *)dateStr{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm"];
    NSDate *destDate= [dateFormatter dateFromString:dateStr];
    return destDate;
}


/**
 比较两个时间的先后关系
 1.oneDay 比 anotherDay 晚
 -1 oneDay 比 anotherDay 早
 0 oneDay = anotherDay

 @param oneDay 第一个日期
 @param anotherDay 第二个日期
 @param format 时间格式
 @return 返回比较结果
 */
+ (int)compareOneDay:(NSString *)oneDay withAnotherDay:(NSString *)anotherDay format:(NSString *)format {
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:format];
    NSDate *dateA = [dateFormat dateFromString:oneDay];
    NSDate *dateB = [dateFormat dateFromString:anotherDay];
    NSComparisonResult result = [dateA compare:dateB];
    if (result == NSOrderedDescending) {
        //NSLog(@"oneDay比 anotherDay时间晚");
        return 1;
    }
    else if (result == NSOrderedAscending){
        //NSLog(@"oneDay比 anotherDay时间早");
        return -1;
    }
    //NSLog(@"两者时间是同一个时间");
    return 0;
}



+ (void)getTimeDetailWithFormate:(NSString *)formate{
    // 2、拿现在的时间和过去时间或者将来时间对比，计算出相差多少天，多少年，多少秒等等；
    NSDate *now = [NSDate date];
    NSDateFormatter *nowFormate = [[NSDateFormatter alloc] init];
    nowFormate.dateFormat = formate;
    NSString *nowTime = [nowFormate stringFromDate:now];
    
    NSDate *beforTime = [nowFormate dateFromString:@"2014-06-14 19:25:00"];
    NSCalendar *calender = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    //世纪
    NSInteger era  = kCFCalendarUnitEra;
    //年
    NSInteger year = kCFCalendarUnitYear;
    //月
    NSInteger month = kCFCalendarUnitMonth;
    //小时
    NSInteger hour = kCFCalendarUnitHour;
    //分钟
    NSInteger minute = kCFCalendarUnitMinute;
    //秒
    NSInteger second = kCFCalendarUnitSecond;
    
    NSDateComponents *compsEra = [calender components:era fromDate:beforTime toDate:now options:0];
    NSDateComponents *compsYear = [calender components:year fromDate:beforTime toDate:now options:0];
    NSDateComponents *compsMonth = [calender components:month fromDate:beforTime toDate:now options:0];
    NSDateComponents *compsHour = [calender components:hour fromDate:beforTime toDate:now options:0];
    NSDateComponents *compsMinute = [calender components:minute fromDate:beforTime toDate:now options:0];
    NSDateComponents *compsSecond = [calender components:second fromDate:beforTime toDate:now options:0];
    
    NSLog(@"相差世纪个数 = %ld",[compsEra era]);
    NSLog(@"相差年个数 = %ld",[compsYear year]);
    NSLog(@"相差月个数 = %ld",[compsMonth month]);
    NSLog(@"相差小时个数 = %ld",[compsHour hour]);
    NSLog(@"相差分钟个数 = %ld",[compsMinute minute]);
    NSLog(@"相差秒个数 = %ld",[compsSecond second]);
    /*
    // 3、获取时间戳（相对于1970年）
    CGFloat timestamp = now.timeIntervalSince1970;
    NSLog(@"距离1970年有多少秒 = %f",timestamp);
    
    // 4、计算距离现在有多少秒
    CGFloat sinceNow = beforTime.timeIntervalSinceNow;
    NSLog(@"距离现在有多少秒 = %f",fabs(sinceNow));
     */
}
@end
