//
//  CacheTool.m
//  RequestManBa
//
//  Created by lifevc on 2020/6/15.
//  Copyright © 2020 maba. All rights reserved.
//

#import "CacheTool.h"

@implementation CacheTool

+ (void)saveCacheData:(id)data key:(NSString *)key{
    [self saveData:data key:key dirType:CacheDriTypeCache];
}
+ (void)saveLibraryData:(id)data key:(NSString *)key{
    [self saveData:data key:key dirType:CacheDriTypeLibrary];
}
+ (void)saveDocumentData:(id)data key:(NSString *)key{
    [self saveData:data key:key dirType:CacheDriTypeDocument];
}
+ (void)saveData:(id)data key:(NSString *)key dirType:(NSInteger)dirType{
    NSString *filePath = nil;
    switch (dirType) {
        case CacheDriTypeCache:
        {
            filePath = [self userCacheDirectory];
        }
            break;
        case CacheDriTypeLibrary:
        {
            filePath = [self userLibrariesDirectory];
        }
            break;
        case CacheDriTypeDocument:
        {
            filePath = [self userDocumentDirectory];
        }
            break;
            
        default:
            break;
    }
    if (filePath) {
        [self saveData:data filePath:[filePath stringByAppendingPathComponent:key]];
    }
}
+ (void)saveData:(id)data filePath:(NSString *)filePath{
    BOOL success = [data writeToFile:filePath atomically:YES];
    NSLog(@"success == %@--存储路径 == %@",success?@"success":@"fail",filePath);
}
+ (void)saveDataWithfilePath:(id)originfilePath key:(NSString *)key dirType:(NSInteger)dirType{
    NSString *filePath = nil;
    BOOL success = false;
    switch (dirType) {
        case CacheDriTypeCache:
        {
            filePath = [self userCacheDirectory];
        }
            break;
        case CacheDriTypeLibrary:
        {
            filePath = [self userLibrariesDirectory];
        }
            break;
        case CacheDriTypeDocument:
        {
            filePath = [self userDocumentDirectory];
        }
            break;
            
        default:
            break;
    }
    if (filePath) {
        filePath = [filePath stringByAppendingPathComponent:key];
        success = [[self getJsonDataWithPath:originfilePath] writeToFile:filePath atomically:YES];
    }
    NSLog(@"success == %@--存储路径 == %@",success?@"success":@"fail",filePath);
}
+ (id)getDataWithKey:(NSString *)key{
    NSDictionary *result = nil;
    NSString *filePath = [[self userCacheDirectory] stringByAppendingPathComponent:key];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        result = [self getJsonDataWithPath:filePath];
    }
    filePath = [[self userLibrariesDirectory] stringByAppendingPathComponent:key];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        result = [self getJsonDataWithPath:filePath];
    }
    filePath = [[self userDocumentDirectory] stringByAppendingPathComponent:key];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        result = [self getJsonDataWithPath:filePath];
    }
    return result;
}
+ (NSDictionary *)getJsonDataWithPath:(id)path{
    if (!path) return nil;
    NSDictionary *dic = nil;
    NSData *jsonData = nil;
    if ([path isKindOfClass:NSURL.class]) {
        dic = [NSDictionary dictionaryWithContentsOfURL:path];
        if (dic == nil) {
            jsonData = [NSData dataWithContentsOfURL:path];
            if (jsonData) {
                dic = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:NULL];
            }
        }
    }else if ([path isKindOfClass:NSString.class]){
        dic = [NSDictionary dictionaryWithContentsOfFile:path];
        if (dic == nil) {
            jsonData = [NSData dataWithContentsOfFile:path];
            if (jsonData) {
                dic = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:NULL];
            }
        }
    }
    return dic;
}
+ (nullable NSString *)userCacheDirectory {
    NSArray<NSString *> *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    return paths.lastObject;
}
+ (nullable NSString *)userLibrariesDirectory {
    NSArray<NSString *> *paths = NSSearchPathForDirectoriesInDomains(NSAllLibrariesDirectory, NSUserDomainMask, YES);
    return paths.lastObject;
}
+ (nullable NSString *)userDocumentDirectory {
    NSArray<NSString *> *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return paths.lastObject;
}
@end
