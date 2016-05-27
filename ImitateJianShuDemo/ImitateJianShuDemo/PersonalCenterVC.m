//
//  PersonalCenterVC.m
//  ImitateJianShuDemo
//
//  Created by 劉光軍 on 16/5/26.
//  Copyright © 2016年. All rights reserved.
//

#import "PersonalCenterVC.h"
#import "UIView+Frame.h"
#import "AboutAuthorCell.h"

@interface PersonalCenterVC ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong) UIImageView *topImageView;
@property(nonatomic, strong)NSArray *array;

@end

@implementation PersonalCenterVC


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
     _array = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20"];
    [self createScaleHeaderView];
    [self createTableView];
    [self createRightButton];
    
    
    // Do any additional setup after loading the view.
}

//MARK:-createTableView
- (void)createTableView {
    
    self.tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}

//MARK:-createScaleHeaderView
- (void)createScaleHeaderView {
    
    UIView *topBkView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
    topBkView.backgroundColor = [UIColor clearColor];
    _topImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
    _topImageView.backgroundColor = [UIColor whiteColor];
    _topImageView.layer.cornerRadius = _topImageView.bounds.size.width/2;
    _topImageView.layer.masksToBounds = YES;
    _topImageView.image = [UIImage imageNamed:@"head"];
    [topBkView addSubview:_topImageView];
    self.navigationItem.titleView = topBkView;
}
//MARK:-rightButton
- (void)createRightButton {
    
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(rightBtnClick)];
    self.navigationItem.rightBarButtonItem = rightBtn;
}

//MARK:-tableView代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else {
        return _array.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 200;
    } else {
        return 60;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    if (indexPath.section == 0) {
        NSString *ident = @"AboutAuthorCell";
        AboutAuthorCell *cell = [tableView dequeueReusableCellWithIdentifier:ident];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"AboutAuthorCell" owner:nil options:nil]lastObject];
        }
        __weak PersonalCenterVC *weakSelf = self;
        cell.selfBlock = ^() {
            NSLog(@"编辑个人资料");
            cell.contentView.backgroundColor = [weakSelf randomColor];
        };
        
        return cell;
    } else {
        NSString *ident = @"myCellID";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ident];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ident];
        }
        if (_array) {
            cell.textLabel.text = [_array objectAtIndex:indexPath.row];
        }
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.font = [UIFont systemFontOfSize:20];
        cell.textLabel.textColor = [UIColor redColor];
        return  cell;
    }
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        UIView *buttonView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 60)];
        buttonView.backgroundColor = [UIColor blueColor];
        return buttonView;
    } else {
        return nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0;
    } else {
        return 60;
    }
}

//MARK:-滑动代理
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat contentSet = scrollView.contentOffset.y + _tableView.contentInset.top;

    if (contentSet >= 0 && contentSet <= 30) {
        _topImageView.transform = CGAffineTransformMakeScale(1 - contentSet/60, 1-contentSet/60);
        _topImageView.y = 0;
    } else if (contentSet > 30) {
        _topImageView.transform = CGAffineTransformMakeScale(0.5, 0.5);
        _topImageView.y = 0;
    } else if (contentSet < 0 ) {
        _topImageView.transform = CGAffineTransformMakeScale(1, 1);
        _topImageView.y = 0;
    }
    
}

//MARK:-右上角按钮点击事件
- (void)rightBtnClick {
    
}

- (UIColor *)randomColor {
    
    CGFloat r = arc4random_uniform(255);
    CGFloat g = arc4random_uniform(255);
    CGFloat b = arc4random_uniform(255);
    
    return [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
