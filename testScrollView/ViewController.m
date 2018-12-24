//
//  ViewController.m
//  testScrollView
//
//  Created by 一枫 on 2018/12/19.
//  Copyright © 2018 SQBJ. All rights reserved.
//

#import "ViewController.h"
#import "BSScrollView.h"
#import "TableViewController.h"
#import "BSTableView.h"

@interface ViewController ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>

/*
 注意 BSScrollView、BSTableView 必出实现代理
 -(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
 
 return YES;
 }
 否则无法进行联动
 */
@property (nonatomic,strong) BSScrollView *scrollView;
@property (nonatomic,strong) BSTableView *tableView;

//子滚动式图，不一定是VC ，也可以是tableview
@property (nonatomic,strong) TableViewController *tbVC;

/*
 添加到cell上的或者scrollview上的 容器视图：必须是UIScrollView
 否则子滚动视图滚动到底部时，会有问题：失去弹性
 */
@property (nonatomic,strong) UIScrollView *containerView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //这里 底层的 滚动视图 使用tableview 还是scrollview 都行
    [self.view addSubview:self.tableView];

    self.canScroll = YES;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeStatus) name:@"shop_home_leaveTop" object:nil];
}

-(void)changeStatus{
    
    self.canScroll = YES;
    self.tbVC.canScroll = NO;
}


#pragma mark - system delegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    /*
     cell 的高度一定要比子视图大，也就是比containerView 的frame大，
     不大的话会有问题，scrollViewDidScroll会不停的走
     */
    return self.view.frame.size.height;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        
        [self addChildViewController:self.tbVC];
        self.tbVC.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height -120 );
        [cell.contentView addSubview:self.containerView];
        [self.containerView addSubview:self.tbVC.view];
    }
    return cell;
}



-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    NSLog(@"scrollView----开始拖拽");
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    NSLog(@"scrollView=====滚动==%.2F",scrollView.contentOffset.y);
    /*
     当 底层滚动式图滚动到指定位置时，
     停止滚动，开始滚动子视图
     */
    CGFloat bottomCellOffset = 100;
    if (scrollView.contentOffset.y >= bottomCellOffset) {
        scrollView.contentOffset = CGPointMake(0, bottomCellOffset);
        if (self.canScroll) {
            self.canScroll = NO;
            self.tbVC.canScroll = YES;
        }
    }else{
        if (!self.canScroll) {//子视图没到顶部
            scrollView.contentOffset = CGPointMake(0, bottomCellOffset);
        }
    }
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSLog(@"scrollView----减速");
}


#pragma mark - 属性初始化

-(BSScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[BSScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        _scrollView.delegate = self;
    }
    return _scrollView;
}

-(BSTableView *)tableView{
    
    if (!_tableView) {
        _tableView = [[BSTableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height + 64 )];
        _tableView.tableFooterView = [[UIView alloc]init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)];
        _tableView.backgroundColor = [UIColor redColor];
    }
    return _tableView;
}

-(TableViewController *)tbVC{
    if (!_tbVC) {
        _tbVC = [[TableViewController alloc]init];
    }
    return _tbVC;
}

-(UIScrollView *)containerView{
    
    if (!_containerView ) {
        _containerView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 120)];
    }
    return _containerView;
}

@end
