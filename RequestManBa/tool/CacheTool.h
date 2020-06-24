//
//  CacheTool.h
//  RequestManBa
//
//  Created by lifevc on 2020/6/15.
//  Copyright © 2020 maba. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


static NSString *const UserCustomizationStr = @"UserCustomizationRequest";//用户自定义的
static NSString *const ExportfileHeaderStr = @"exportFileHeaderRequest";



static NSString *const UserCustomizationEnvStr = @"UserCustomizationEnv";
static NSString *const UserCustomizationGloabStr = @"UserCustomizationGloab";

//static NSString *const ExportfileEnvStr = @"exportFileEnv";
//static NSString *const ExportfileGloabStr = @"exportFileGloab";




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

+ (void)saveData:(id)data
             key:(NSString *)key
         dirType:(NSInteger)dirType;

+ (void)saveDataWithfilePath:(id)originfilePath
                         key:(NSString *)key
                     dirType:(NSInteger)dirType;

+ (void)saveData:(id)data
             key:(NSString *)key
         dirType:(NSInteger)dirType
      completion:(void(^)(NSString *filePath))completion;

+ (void)saveData:(id)data
        filePath:(NSString *)filePath
      completion:(void(^)(NSString *filePath))completion;

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
