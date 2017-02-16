//
//  AppStoreViewController.m
//  YENerdyUIDemo
//
//  Created by yongen on 17/2/16.
//  Copyright © 2017年 yongen. All rights reserved.
//

#import "AppStoreViewController.h"
#import "AppStoreViewCell.h"

@interface AppStoreViewController ()

@property (nonatomic, strong) NSArray *appList;

@end

@implementation AppStoreViewController

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.appList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AppStoreViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    [cell updateWithApp:self.appList[indexPath.row] index:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.estimatedRowHeight = 84;
    [self.tableView registerClass:AppStoreViewCell.class forCellReuseIdentifier:@"cell"];
    
    id path = [[NSBundle mainBundle] pathForResource:@"appList" ofType:@"plist"];
    self.appList = [NSArray arrayWithContentsOfFile:path];
    self.appList = [self.appList arrayByAddingObjectsFromArray:self.appList];
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
