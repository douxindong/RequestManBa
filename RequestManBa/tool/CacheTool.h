//
//  CacheTool.h
//  RequestManBa
//
//  Created by lifevc on 2020/6/15.
//  Copyright © 2020 maba. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


static NSString *const UserCustomizationStr = @"UserCustomization.json";//用户自定义的
static NSString *const ExportfileHeaderStr = @"exportfileheader.json";

typedef NS_ENUM(NSUInteger, CacheDriType) {
    CacheDriTypeCache,
    CacheDriTypeLibrary,
    CacheDriTypeDocument,
};

@interface CacheTool : NSObject

#pragma mark - file 存放原数据
+ (void)saveCacheData:(id)data key:(NSString *)key;
+ (void)saveLibraryData:(id)data key:(NSString *)key;
+ (void)saveDocumentData:(id)data key:(NSString *)key;
+ (void)saveData:(id)data key:(NSString *)key dirType:(NSInteger)dirType;
+ (void)saveDataWithfilePath:(id)originfilePath key:(NSString *)key dirType:(NSInteger)dirType;
#pragma mark 获取原数据
+ (id)getDataWithKey:(NSString *)key;
+ (NSDictionary *)getJsonDataWithPath:(NSString *)path;
//创建默认的plist
//导入的新建plist



+ (nullable NSString *)userCacheDirectory;
+ (nullable NSString *)userLibrariesDirectory;
+ (nullable NSString *)userDocumentDirectory;
@end

NS_ASSUME_NONNULL_END
