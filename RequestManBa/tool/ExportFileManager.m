//
//  ExportFileManager.m
//  RequestManBa
//
//  Created by lifevc on 2020/6/15.
//  Copyright © 2020 maba. All rights reserved.
//

#import "ExportFileManager.h"

@interface ExportFileManager ()<UIDocumentPickerDelegate,UIDocumentInteractionControllerDelegate>

@end

@implementation ExportFileManager
+ (instancetype)sharedInstance {
    static ExportFileManager *_sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[ExportFileManager alloc] init];
    });
    
    return _sharedInstance;
}
- (void)presentDocumentCloudCompletion:(completionBlock)completion{
    _completion = completion;
    NSArray *documentTypes = @[@"public.text",
                               @"public.content",
                               @"public.source-code",
                               @"public.image",
                               @"public.audiovisual-content",
                               @"com.adobe.pdf",
                               @"com.apple.keynote.key",
                               @"com.microsoft.word.doc",
                               @"com.microsoft.excel.xls",
                               @"com.microsoft.powerpoint.ppt"];
    
    UIDocumentPickerViewController *documentPickerViewController = [[UIDocumentPickerViewController alloc] initWithDocumentTypes:documentTypes inMode:UIDocumentPickerModeImport];
    documentPickerViewController.delegate = self;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:documentPickerViewController animated:YES completion:nil];
}
- (void)presentVC:(UIViewController *)vc documentInteractionWithFilePath:(NSString *)filePath completion:(completionBlock2)completion{
    _completion2 = completion;
    _vc = vc;
    UIDocumentInteractionController *documentController = [UIDocumentInteractionController interactionControllerWithURL:[NSURL fileURLWithPath:filePath]];
    documentController.delegate = self;
    //            [documentController presentOpenInMenuFromRect:CGRectZero inView:self.view animated:YES];
    [documentController presentPreviewAnimated:YES];
}
#pragma mark - UIDocumentPickerDelegate
- (void)documentPicker:(UIDocumentPickerViewController *)controller didPickDocumentAtURL:(NSURL *)url {
    CBInvokeBlock(_completion,url);
//    NSArray *array = [[url absoluteString] componentsSeparatedByString:@"/"];
//    NSString *fileName = [array lastObject];
//    fileName = [fileName stringByRemovingPercentEncoding];
//    NSLog(@"--->>>>%@",fileName);
//    //在此已获取到文件，可对文件进行需求上的操作
////    if ([self iCloudEnable]) {
//        NSDictionary *dic = [NSDictionary dictionaryWithContentsOfURL:url];
////        NSString *filePath = [[CacheTool userCacheDirectory] stringByAppendingPathComponent:@"default.plist"];
////        BOOL success = [dic writeToFile:filePath atomically:YES];
//    [CacheTool saveData:dic key:@"default.plist" dirType:CacheDriTypeCache];
////        NSLog(@"%@",success?@"success":@"fail");
////    }
}
//- (void)documentPicker:(UIDocumentPickerViewController *)controller didPickDocumentsAtURLs:(NSArray <NSURL *>*)urls{
//    NSLog(@"urls == %@",urls);
//}
 
//- (BOOL)iCloudEnable {
//    NSFileManager *manager = [NSFileManager defaultManager];
//    NSURL *url = [manager URLForUbiquityContainerIdentifier:nil];
//    if (url != nil) {
//        return YES;
//    }
//    NSLog(@"iCloud 不可用");
//    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"icloud" message:@"iCloud 不可用, 不能选择文件上传" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//    [alert show];
//    return NO;
//}
#pragma mark - UIDocumentInteractionControllerDelegate
- (void)documentInteractionControllerWillPresentOptionsMenu:(UIDocumentInteractionController *)controller
{
    // 页面显示后响应
    NSLog(@"9 %s", __func__);
}
 
- (void)documentInteractionControllerDidDismissOptionsMenu:(UIDocumentInteractionController *)controller
{
    // 取消时响应
    NSLog(@"10 %s", __func__);
}
 
- (UIViewController *)documentInteractionControllerViewControllerForPreview:(UIDocumentInteractionController *)controller
{
    NSLog(@"1 %s", __func__);
    return _vc;
}
 
- (UIView *)documentInteractionControllerViewForPreview:(UIDocumentInteractionController *)controller
{
    NSLog(@"2 %s", __func__);
    return _vc.view;
}
 
- (CGRect)documentInteractionControllerRectForPreview:(UIDocumentInteractionController *)controller
{
    NSLog(@"3 %s", __func__);
    return _vc.view.frame;
}
 
// 文件分享面板退出时调用
- (void)documentInteractionControllerDidDismissOpenInMenu:(UIDocumentInteractionController *)controller
{
    NSLog(@"4 %s", __func__);
    NSLog(@"dismiss");
}
 
// 文件分享面板弹出的时候调用
- (void)documentInteractionControllerWillPresentOpenInMenu:(UIDocumentInteractionController *)controller
{
    NSLog(@"5 %s", __func__);
    NSLog(@"WillPresentOpenInMenu");
}
 
// 当选择一个文件分享App的时候调用
- (void)documentInteractionController:(UIDocumentInteractionController *)controller willBeginSendingToApplication:(nullable NSString *)application
{
    NSLog(@"6 %s", __func__);
    NSLog(@"begin send : %@", application);
}
 
// Preview presented/dismissed on document.  Use to set up any HI underneath.
- (void)documentInteractionControllerWillBeginPreview:(UIDocumentInteractionController *)controller
{
    NSLog(@"7 %s", __func__);
}
- (void)documentInteractionControllerDidEndPreview:(UIDocumentInteractionController *)controller
{
    // 完成时响应
    NSLog(@"8 %s", __func__);
}
 
- (void)documentInteractionController:(UIDocumentInteractionController *)controller didEndSendingToApplication:(nullable NSString *)application
{
    NSLog(@"11 %s", __func__);
}

@end
