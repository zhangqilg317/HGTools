//
//  HGTimeTool.h
//  HGTools
//
//  Created by 张奇 on 2018/2/24.
//  Copyright © 2018年 com.ebest. All rights reserved.
//

#import <Foundation/Foundation.h>

/** 时间工具 */

typedef NS_ENUM(NSUInteger, EndTimeType) {
    EndTimeTypeDay,
    EndTimeTypeWeek,
    EndTimeTypeMonth,
};

@interface HGTimeTool : NSObject

/**
 获取当前日期的字符串形式

 @param formate 日期格式 ex.yyyy-MM-dd HH:mm:ss
 @return 字符串日期
 */
+ (NSString *)currentTimeWithFormate:(NSString *)formate;

@end
