//
//  SJHomeViewController.m
//  SJLiveShow
//
//  Created by SoulJa on 2017/9/3.
//  Copyright © 2017年 soulja. All rights reserved.
//

#import "SJHomeViewController.h"
/** 播放器视图 **/
#import "SJMoviePlayerViewController.h"
/**  创建房间 **/
#import "SJCreateRoomViewController.h"

@interface SJHomeViewController () <
UITableViewDataSource,
UITableViewDelegate
>
@property (nonatomic,strong) SJSocketManager *manager;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *roomArray;
@end

@implementation SJHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //设置Nav
    [self initNav];
    
    //设置子视图
    [self initSubviews];
    
    //监听事件
    [self addEventListener];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[SJSocketManager defaultManager] emit:@"getRooms" with:@[]];
}

#pragma mark - 监听事件
- (void)addEventListener {
    _manager = [SJSocketManager defaultManager];
    
    _roomArray = [NSMutableArray array];
    
    [_manager on:@"rooms" callback:^(NSArray *data) {
        _roomArray = data[0];
        [_tableView reloadData];
    }];
}

#pragma mark - 设置Nav
- (void)initNav {
    self.title = @"主页";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"创建房间" style:UIBarButtonItemStyleDone target:self action:@selector(tapCreateRoomBtn)];
}

#pragma mark - 设置子视图
- (void)initSubviews {
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
}

#pragma mark - 点击创建房间
- (void)tapCreateRoomBtn {
    SJCreateRoomViewController *vc = [[SJCreateRoomViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UITableViewDataSource,UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _roomArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *kCellId = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellId];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:kCellId];
    }
    cell.textLabel.text = [_roomArray objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //进入播放
    SJMoviePlayerViewController *vc = [[SJMoviePlayerViewController alloc] init];
    vc.roomId = [_roomArray objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:vc  animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
