//
//  BaseTableViewController.m
//  WYShareAndLive
//
//  Created by fanxiaobin on 2017/10/12.
//  Copyright © 2017年 乾坤翰林. All rights reserved.
//

#import "BaseTableViewController.h"
#import <MJRefresh/MJRefresh.h>
#import "UIScrollView+IOS11.h"


@interface BaseTableViewController ()

@property (nonatomic,assign) UITableViewStyle tableViewStyle;

@end

@implementation BaseTableViewController

-(instancetype)init{
    if (self = [super init]) {
        self.tableViewStyle = UITableViewStyleGrouped;
    }
    return self;
}

-(instancetype)initWithTableViewStyle:(UITableViewStyle)style{
    if (self = [super init]) {
        self.tableViewStyle = style;
        if ((style != UITableViewStylePlain) && (style != UITableViewStyleGrouped)) {
            self.tableViewStyle = UITableViewStylePlain;
        }
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear: animated];
  
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArr = [NSMutableArray array];
    self.currentPage = 0;
    [self tableView];
    
}

-(NSMutableArray *)dataArr{
    if (_dataArr == nil) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

- (void)queryData{
    //子类重写此方法
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    });
    
}

- (void)endRefresh{
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
 
    if (self.currentPage >= self.totalPages && self.totalPages > 0) {
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
    }
}

-(UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kNavigationBarHeight - kSafeAreaBottomHeight) style:self.tableViewStyle];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.emptyDataSetSource = self;
        _tableView.emptyDataSetDelegate = self;
        _tableView.tableFooterView = [UIView new];
        _tableView.backgroundColor = [UIColor clearColor];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
        //[_tableView configIOS11WithController:self];
        
        _tableView.rowHeight = 0.0;
        _tableView.estimatedRowHeight = 0.0;
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            _tableView.estimatedRowHeight = 0.0;
            _tableView.estimatedSectionHeaderHeight = 0.0;
            _tableView.estimatedSectionFooterHeight = 0.0;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        
        /*
         *  在IOS8之后，table设置StyleGrouped类型，需要设置tableHeaderView这样才有效;
         *  但是把tableHeaderView = nil，也是没有用的；
         *  需要创建一个view实例，且frame不能设置为CGRectZero
         */
       
//        // 去掉grouped风格下顶部留白的问题 其实是系统默认的Header高度 35.0
//        if (self.tableViewStyle == UITableViewStyleGrouped) {
//            UIView *tableViewHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, CGRectGetWidth(self.tableView.frame), CGFLOAT_MIN)];
//            _tableView.tableHeaderView = tableViewHeaderView;
//        }
        
        [self.view addSubview:_tableView];
        
        __weak typeof(self) weakSelf = self;
        //头刷新
        MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            weakSelf.currentPage = 0;
            [weakSelf queryData];
        }];
        header.lastUpdatedTimeLabel.hidden = YES;
        _tableView.mj_header = header;
        
       
        //3. 尾刷新
        MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            //放到子类控制器请求成功后再++
            //weakSelf.currentPage++;
            [weakSelf queryData];
        }];
        
        _tableView.mj_footer = footer;
    }
    
    return _tableView;
}

-(void)setIsHiddenRefreshControl:(BOOL)isHiddenRefreshControl{
    if (isHiddenRefreshControl) {
        self.tableView.mj_header = nil;
        self.tableView.mj_footer = nil;
    }
}

-(void)setHiddenLoadMoreRefreshControl:(BOOL)hiddenLoadMoreRefreshControl{
    if (hiddenLoadMoreRefreshControl) {
        self.tableView.mj_footer = nil;
    }
}

- (void)setTopMargin:(CGFloat)topMargin{
    _topMargin = topMargin;
    self.tableView.frame = CGRectMake(0, topMargin, kScreenWidth, kScreenHeight - kNavigationBarHeight - topMargin - kSafeAreaBottomHeight);
}

-(void)setBottomMargin:(CGFloat)bottomMargin{
    _bottomMargin = bottomMargin;
    self.tableView.frame = CGRectMake(0, self.topMargin, kScreenWidth, kScreenHeight - kNavigationBarHeight - self.topMargin - bottomMargin  - kSafeAreaBottomHeight);
}

#pragma mark --- 子类重写 UITableViewDelegate , UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    //return 0.01f;
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    //return 0.01f;
    return CGFLOAT_MIN;
}

///去掉ios11出现的头尾留白现象
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [UIView new];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"BaseCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark ---- <DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
//提示图片
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
    if ([AFNetworkReachabilityManager sharedManager].networkReachabilityStatus == AFNetworkReachabilityStatusNotReachable) {
        return [UIImage imageNamed:@"empty_network"];
    }
    return [UIImage imageNamed:@"empty_noData"];
}
//提示标题
//- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView{
//    NSString *text = @"暂无数据内容";
//    if ([AFNetworkReachabilityManager sharedManager].networkReachabilityStatus == AFNetworkReachabilityStatusNotReachable) {
//        text = @"暂无网络连接";
//    }
//    NSDictionary *attributes = @{NSFontAttributeName: kFont(kSCALE(30.0)),
//                                 NSForegroundColorAttributeName: kTitleColor};
//
//    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
//}

///距离它默认位置在Y轴的偏移 如果有headView 这里返回headView高度的一半即可
- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView{
    return 0.0;
}

///控件之间的间距
- (CGFloat)spaceHeightForEmptyDataSet:(UIScrollView *)scrollView{
    return kSCALE(30.0);
}

- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView{
    return YES;
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
