//
//  ViewController.m
//  MutilCheckType
//
//  Created by Vetech on 15/11/13.
//  Copyright © 2015年 BFL. All rights reserved.
//

#import "ViewController.h"
#import "MultiCheckTypeCell.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate> {
    UITableView * _tableView;
    NSArray * _data;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    
    _data = @[
              @{@"title":@"性别1", @"array":@[@"男",@"女"]},
              @{@"title":@"性别2", @"array":@[@"男",@"女",@"👽"]},
              @{@"title":@"性别3", @"array":@[@"男",@"女",@"👽",@"火星人"]}
              ];
    
    CGRect frame = self.view.frame;
    frame.origin.y = 16;
    
    _tableView = [[UITableView alloc] initWithFrame:frame];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    
    [self.view addSubview:_tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_data count];
}

#pragma mark - UITableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * cellID = @"cellID";
    MultiCheckTypeCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[MultiCheckTypeCell alloc] initWithData:_data[indexPath.row]];
    }
    cell.checkTypeBlock = ^(NSInteger typeIndex) {
        [self _showCheckResult:indexPath.row andColumn:typeIndex];
    };
    [cell setSelectionStyle:(UITableViewCellSelectionStyleNone)];
    return cell;
}

- (void)_showCheckResult:(NSInteger)rowIndex andColumn:(NSInteger)colIndex {
    NSString * msg = [NSString stringWithFormat:@"您选择的%@是：%@", _data[rowIndex][@"title"], _data[rowIndex][@"array"][colIndex]];
//    UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:@"选择结果"
//                                                                       message:msg
//                                                                preferredStyle:(UIAlertControllerStyleAlert)];
//    UIAlertAction * okAction = [UIAlertAction actionWithTitle:@"确认" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
//        [alertVC presentViewController:self animated:YES completion:nil];
//    }];
//    [alertVC addAction:okAction];
//    
//    [self presentViewController:alertVC animated:YES completion:nil];
    
    UIAlertView * alertView = [[UIAlertView alloc] init];
    alertView.delegate = self;
    alertView.title = @"选择结果";
    alertView.message = msg;
    [alertView addButtonWithTitle:@"确认"];
    [alertView show];
}

@end
