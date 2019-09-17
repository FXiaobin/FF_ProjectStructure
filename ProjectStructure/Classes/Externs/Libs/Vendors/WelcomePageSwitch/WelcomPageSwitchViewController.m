//
//  WelcomPageSwitchViewController.m
//  ProjectStructure
//
//  Created by mac on 2019/9/2.
//  Copyright © 2019 healifeGroup. All rights reserved.
//

#import "WelcomPageSwitchViewController.h"
#import "WelcomePageSwitchCell.h"

NSString * const WelcomPageSwitchViewController_AppVersion = @"WelcomPageSwitchViewController_AppVersion";

@interface WelcomPageSwitchViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>


@property (nonatomic,strong) UICollectionView *collectionView;


@property (nonatomic,strong) NSArray *guides;


@end

@implementation WelcomPageSwitchViewController

+ (void)showWelcomPageSwitchViewControllerWithGuideImages:(NSArray *)images{
    [self showWelcomPageSwitchViewControllerWithGuideImages:images completed:^{
        
    }];
}

+ (void)showWelcomPageSwitchViewControllerWithGuideImages:(NSArray *)images completed:(dispatch_block_t)completed{
    
    NSString *lastAppVersion = [[NSUserDefaults standardUserDefaults] objectForKey:WelcomPageSwitchViewController_AppVersion];
    NSString *currentAppVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    
    if ([lastAppVersion isEqualToString:currentAppVersion]) {
        return;
    }
    
    WelcomPageSwitchViewController *vc = [WelcomPageSwitchViewController new];
    vc.guides = images;
    vc.view.frame = [UIScreen mainScreen].bounds;
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:vc.view];
    ///添加欢迎页面的时候 广告页面还没有消失 因为广告页面还要做一个0.25秒的动画后才会消失
    ///这句代码作用：让滚动欢迎页面添加到广告图的下面 这样广告就可以做动画了 不然等到广告结束后再添加欢迎滚动视图则会出现闪动
    for (UIView *suv in window.subviews) {
        if ([suv isKindOfClass:NSClassFromString(@"AdLaunchManager")]) {
            [window insertSubview:vc.view atIndex:1];
        }
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:currentAppVersion forKey:WelcomPageSwitchViewController_AppVersion];
    [[NSUserDefaults standardUserDefaults] synchronize];

    vc.accessBtnActionBlock = ^(UIButton * _Nonnull sender) {
        if (completed) {
            completed();
        }
    };
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
 
    [self.view addSubview:self.collectionView];
    
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.guides.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    WelcomePageSwitchCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"WelcomePageSwitchCell" forIndexPath:indexPath];
    cell.imageView.image = [UIImage imageNamed:self.guides[indexPath.item]];
    cell.accessBtn.hidden = !(indexPath.item == self.guides.count - 1);
    
    kWeakSelf;
    cell.accessBtnActionBlock = ^(UIButton * _Nonnull sender) {
        if (self.accessBtnActionBlock) {
            self.accessBtnActionBlock(sender);
        }
        
        [UIView animateWithDuration:0.25 animations:^{
            weakSelf.view.alpha = 0.0;
            
        } completion:^(BOOL finished) {
            [weakSelf.view removeFromSuperview];
        }];
    };
    
    return cell;
}

-(UICollectionView *)collectionView{
    if (_collectionView == nil) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = [UIScreen mainScreen].bounds.size;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumInteritemSpacing = 0.0;
        layout.minimumLineSpacing = 0.0;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:[UIScreen mainScreen].bounds collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.pagingEnabled = YES;
        _collectionView.bounces = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView registerClass:[WelcomePageSwitchCell class] forCellWithReuseIdentifier:@"WelcomePageSwitchCell"];
    }
    return _collectionView;
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
