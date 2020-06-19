//
//  FileListViewController.m
//  RequestManBa
//
//  Created by lifevc on 2020/6/15.
//  Copyright © 2020 maba. All rights reserved.
//

#import "FileListViewController.h"
#import "HistoryViewController.h"
#import "DetailViewController.h"
@interface FileListViewController ()<UITableViewDelegate,UITableViewDataSource,YBPopupMenuDelegate>
@property (nonatomic, strong) UIButton *rightNavBtn;
//导出https://blog.csdn.net/worthyzhang/article/details/44939893?utm_medium=distribute.pc_relevant.none-task-blog-baidujs-2

@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) NSMutableArray <NSString *>*filePathList;
@end

@implementation FileListViewController

- (UITableView *)tableview
{
    if (!_tableview) {
        _tableview = [[UITableView alloc] init];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.tableFooterView = [UIView new];
    }
    return _tableview;
}
- (NSMutableArray<NSString *> *)filePathList{
    if (_filePathList == nil) {
        _filePathList = [NSMutableArray array];
    }
    return _filePathList;
}
- (UIButton *)rightNavBtn{
    if (_rightNavBtn == nil) {
        _rightNavBtn = [UIButton buttonWithType:UIButtonTypeContactAdd];
        [_rightNavBtn addTarget:self action:@selector(addClick) forControlEvents:UIControlEventTouchUpInside];
//        _rightNavBtn.tintColor = [UIColor blackColor];
    }
    return _rightNavBtn;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.rightNavBtn];
    
    [self.view addSubview:self.tableview];
    [self.tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [self loadData];
    
}
#pragma mark - YBPopupMenuDelegate
- (void)ybPopupMenuDidSelectedAtIndex:(NSInteger)index ybPopupMenu:(YBPopupMenu *)ybPopupMenu
{
    switch (index) {
        case 0:
        {
            [[ExportFileManager sharedInstance] presentDocumentCloudCompletion:^(NSURL * _Nonnull url) {
                NSArray *array = [[url absoluteString] componentsSeparatedByString:@"/"];
                NSString *fileName = [array lastObject];
                fileName = [fileName stringByRemovingPercentEncoding];
                NSLog(@"--->>>>%@",fileName);
                
                
                
                [CacheTool saveDataWithfilePath:url key:[NSString stringWithFormat:@"%@.%@",ExportfileHeaderStr,url.pathComponents.lastObject] dirType:CacheDriTypeCache];
                
                [self loadData];
            }];
        }
            break;
        case 1:
        {
            NSLog(@"新建请求");
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"create collection" message:nil preferredStyle:UIAlertControllerStyleAlert];
            //定义第一个输入框；
            [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
                textField.placeholder = @"collection name";
                textField.clearButtonMode = UITextFieldViewModeWhileEditing;
            }];
            [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil]];
            //增加确定按钮；
            [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                //获取第1个输入框；
                UITextField *textField = alertController.textFields.firstObject;
                NSLog(@"textField.text == %@",textField.text);
                if (textField.text.length) {
                    NSDictionary *dic = [Tools getJsonDataFromBundleWithName:@"temp.postman_collection.json"];
                    [CacheTool saveData:[dic jsonPrettyStringEncoded] key:[NSString stringWithFormat:@"%@.%@.json",UserCustomizationStr,textField.text] dirType:CacheDriTypeCache];
                    [self loadData];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        HistoryViewController *historyVC = [HistoryViewController new];
                        historyVC.filePath = self.filePathList.lastObject;
                        [self.navigationController pushViewController:historyVC animated:YES];
                    });
                }
            }]];
            [self presentViewController:alertController animated:true completion:nil];
        }
            break;
        case 2:{
            NSArray<NSString *> *paths = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:[CacheTool userCacheDirectory] error:nil];
            __block NSMutableArray *tempFileList = [NSMutableArray array];
            [paths enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//                if ([obj containsString:cacheHeaderStr]) {
                    [tempFileList addObject:[[CacheTool userCacheDirectory] stringByAppendingPathComponent:obj]];
//                }
            }];
            NSString *str = tempFileList[1];
            
            [[ExportFileManager sharedInstance] presentVC:self documentInteractionWithFilePath:str completion:^{
                
            }];


        }
            break;
            
        default:
            break;
    }
}
 


- (void)addClick{
    [YBPopupMenu showRelyOnView:self.rightNavBtn titles:@[@"导入",@"新建",@"导出请求"] icons:nil menuWidth:100 delegate:self];
}
- (void)loadData{
    NSArray<NSString *> *paths = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:[CacheTool userCacheDirectory] error:nil];
    __block NSMutableArray *tempFileList = [NSMutableArray array];
    [paths enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj containsString:ExportfileHeaderStr]||[obj containsString:UserCustomizationStr]) {
            [tempFileList addObject:obj];
        }
    }];
    self.filePathList = [tempFileList mutableCopy];
    [self.tableview reloadData];
}
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(UITableViewCell.class)];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass(UITableViewCell.class)];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    NSString *collectionName = self.filePathList[indexPath.row];
    collectionName = [collectionName stringByReplacingOccurrencesOfString:ExportfileHeaderStr withString:@""];
    cell.textLabel.text = collectionName;
    return cell;
}
- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.filePathList.count;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HistoryViewController *historyVC = [HistoryViewController new];
    historyVC.filePath = self.filePathList[indexPath.row];
    [self.navigationController pushViewController:historyVC animated:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
