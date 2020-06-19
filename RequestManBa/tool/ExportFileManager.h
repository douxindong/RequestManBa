//
//  ExportFileManager.h
//  RequestManBa
//
//  Created by lifevc on 2020/6/15.
//  Copyright © 2020 maba. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef void (^completionBlock)(NSURL *url);
typedef void (^completionBlock2)(void);
@interface ExportFileManager : NSObject
@property (nonatomic, copy) completionBlock completion;
@property (nonatomic, copy) completionBlock2 completion2;
@property (nonatomic, strong) UIViewController *vc;
+ (instancetype)sharedInstance;

- (void)presentDocumentCloudCompletion:(completionBlock)completion;
- (void)presentVC:(UIViewController *)vc documentInteractionWithFilePath:(NSString *)filePath completion:(completionBlock2)completion;
@end

NS_ASSUME_NONNULL_END
