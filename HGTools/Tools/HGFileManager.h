//
//  HGFileManager.h
//  HGTools
//
//  Created by 张奇 on 2019/7/1.
//  Copyright © 2019 com.ebest. All rights reserved.
//

#import <Foundation/Foundation.h>

/** 文件管理 */
@interface HGFileManager : NSObject

/** 把对象归档存到沙盒里 */
+(void)saveObject:(id)object byFileName:(NSString*)fileName;

/** 通过文件名从沙盒中找到归档的对象 */
+(id)getObjectByFileName:(NSString*)fileName;

/** 根据文件名删除沙盒中的 plist 文件 */
+(void)removeFileByFileName:(NSString*)fileName;

/** 存储用户偏好设置 到 NSUserDefults */
+(void)saveUserData:(id)data forKey:(NSString*)key;

/** 读取用户偏好设置 */
+(id)readUserDataForKey:(NSString*)key;

/** 删除用户偏好设置 */
+(void)removeUserDataForkey:(NSString*)key;

@end

