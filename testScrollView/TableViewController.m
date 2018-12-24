//
//  TableViewController.m
//  testScrollView
//
//  Created by 一枫 on 2018/12/19.
//  Copyright © 2018 SQBJ. All rights reserved.
//

#import "TableViewController.h"

@interface TableViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,assign) CGFloat lastOffset;

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)setCanScroll:(BOOL)canScroll{
    _canScroll = canScroll;
    self.lastOffset = self.tableView.contentOffset.y;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.text = [NSString stringWithFormat:@"当前行数：== %ld ==",(long)indexPath.row];
    return cell;
    
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    NSLog(@"tabelview >>>>>>> 滚动 == %.2F",scrollView.contentOffset.y);

    if (!self.canScroll) {
        scrollView.contentOffset = CGPointZero;
    }
    if (scrollView.contentOffset.y < 0 ) {
        self.canScroll = NO;
        scrollView.contentOffset = CGPointZero;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"shop_home_leaveTop" object:nil];//到顶通知父视图改变状态
    }
    scrollView.showsVerticalScrollIndicator = self.canScroll?YES:NO;
}



@end
