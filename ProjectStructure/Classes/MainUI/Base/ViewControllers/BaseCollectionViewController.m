//
//  BaseCollectionViewController.m
//  FFCommonProject
//
//  Created by mac on 2018/6/4.
//  Copyright © 2018年 healifeGroup. All rights reserved.
//

#import "BaseCollectionViewController.h"
#import "UIScrollView+IOS11.h"

@interface BaseCollectionViewController ()

@end

@implementation BaseCollectionViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear: animated];
    self.currentPage = 0;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArr = [NSMutableArray array];
    self.currentPage = 0;
    [self collectionView];
    
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
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView.mj_footer endRefreshing];
    });
    
}

- (void)endRefresh{
    [self.collectionView.mj_header endRefreshing];
    [self.collectionView.mj_footer endRefreshing];
    
}

-(CHTCollectionViewWaterfallLayout *)layout{
    if (_layout == nil) {
        _layout = [[CHTCollectionViewWaterfallLayout alloc] init];
        _layout.columnCount = 2;
        _layout.minimumInteritemSpacing = kSCALE(20);
        _layout.minimumColumnSpacing = kSCALE(20);
        _layout.sectionInset = UIEdgeInsetsMake(kSCALE(20), kSCALE(20), kSCALE(20), kSCALE(20));
    }
    return _layout;
}

-(UICollectionView *)collectionView{
    if (_collectionView == nil) {
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kNavigationBarHeight - kSafeAreaBottomHeight) collectionViewLayout:self.layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.emptyDataSetSource = self;
        _collectionView.emptyDataSetDelegate = self;
        _collectionView.backgroundColor = [UIColor clearColor];
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];

        if (@available(iOS 11.0, *)) {
            _collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        
        [self.view addSubview:_collectionView];
        
        __weak typeof(self) weakSelf = self;
        //头刷新
        MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            weakSelf.currentPage = 0;
            [weakSelf queryData];
        }];
        header.lastUpdatedTimeLabel.hidden = YES;
        _collectionView.mj_header = header;
        
        
        //3. 尾刷新
        MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            //放到子类控制器请求成功后再++
            //weakSelf.currentPage++;
            [weakSelf queryData];
        }];
        
        _collectionView.mj_footer = footer;
    }
    
    return _collectionView;
}

-(void)setIsHiddenRefreshControl:(BOOL)isHiddenRefreshControl{
    if (isHiddenRefreshControl) {
        self.collectionView.mj_header = nil;
        self.collectionView.mj_footer = nil;
    }
}

-(void)setHiddenLoadMoreRefreshControl:(BOOL)hiddenLoadMoreRefreshControl{
    if (hiddenLoadMoreRefreshControl) {
        self.collectionView.mj_footer = nil;
    }
}

- (void)setTopMargin:(CGFloat)topMargin{
    _topMargin = topMargin;
    self.collectionView.frame = CGRectMake(0, topMargin, kScreenWidth, kScreenHeight - kNavigationBarHeight - topMargin - kSafeAreaBottomHeight);
}

-(void)setBottomMargin:(CGFloat)bottomMargin{
    _bottomMargin = bottomMargin;
    self.collectionView.frame = CGRectMake(0, self.topMargin, kScreenWidth, kScreenHeight - kNavigationBarHeight - self.topMargin - bottomMargin  - kSafeAreaBottomHeight);
}

#pragma mark --- 子类重写 UITableViewDelegate , UITableViewDataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 0;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(kScreenWidth - kSCALE(90)/2.0, kSCALE(300));
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    return CGSizeZero;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeZero;
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    return nil;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
    cell.contentView.backgroundColor = kRandomColor;
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    DDLog(@"---- collection indexPath = %@",indexPath.description);
    
}

#pragma mark ---- 无数据提示
//提示图片
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
    if ([AFNetworkReachabilityManager sharedManager].networkReachabilityStatus == AFNetworkReachabilityStatusNotReachable) {
        return [UIImage imageNamed:@"empty_network"];
    }
    return [UIImage imageNamed:@"empty_noData"];
}

////提示标题
//- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView{
//    NSString *text = @"暂无数据内容";
//    if ([AFNetworkReachabilityManager sharedManager].networkReachabilityStatus == AFNetworkReachabilityStatusNotReachable) {
//        text = @"暂无网络连接";
//    }
//    NSDictionary *attributes = @{NSFontAttributeName: kFont(kSCALE(32.0)),
//                                 NSForegroundColorAttributeName: kTitleColor};
//
//    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
//}

- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView{
    return 0.0;
}

- (CGFloat)spaceHeightForEmptyDataSet:(UIScrollView *)scrollView{
    return kSCALE(40.0);
}

- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView{
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
