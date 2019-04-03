//
//  MainViewController.m
//  com.wufan
//
//  Created by otsoft on 2018/7/20.
//  Copyright © 2018年 wufan. All rights reserved.
//

#import "MainViewController.h"
#import "ProfileViewController.h"
#import "MassageViewController.h"
#import "ColaViewController.h"
#import "UserViewController.h"
#import "MoreViewController.h"
#import "Animation.h"
#import "AnimationController.h"
	
//#import "Maso"
@interface MainViewController ()<UITabBarControllerDelegate>
@property (nonatomic,strong) UIPanGestureRecognizer *panGesturcognizer;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate=self;
    self.selectedIndex=0;
//    _panGesturcognizer=[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panGuestRecognizer:)];
//    [self.view addGestureRecognizer:self.panGesturcognizer];
    
//    ProfileViewController *profilevc=[[ProfileViewController alloc]init];
    




   
    ProfileViewController *profilevc=[[ProfileViewController alloc]initWithNibName:@"ProfileViewController" bundle:nil];
    PRNav=[[MBNavgationController alloc]initWithRootViewController:profilevc];
    PRNav.tabBarItem.title=@"首页";
    PRNav.tabBarItem.image=[UIImage imageNamed:@"shuoye"];
    PRNav.tabBarItem.selectedImage=[UIImage imageNamed:@"shuoyeselect"];
    
    MassageViewController *messagevc=[[MassageViewController alloc]initWithNibName:@"MassageViewController" bundle:nil];
    MENav=[[MBNavgationController alloc]initWithRootViewController:messagevc];
    MENav.tabBarItem.title=@"分类";
    MENav.tabBarItem.image=[UIImage imageNamed:@"fenlei"];
    MENav.tabBarItem.selectedImage=[UIImage imageNamed:@"fenleiselect"];
    
    ColaViewController *colavc=[[ColaViewController alloc]initWithNibName:@"ColaViewController" bundle:nil];
    CONav=[[MBNavgationController alloc]initWithRootViewController:colavc];
    CONav.tabBarItem.title=@"品味";
    CONav.tabBarItem.image=[UIImage imageNamed:@"pingwei"];
    CONav.tabBarItem.selectedImage=[UIImage imageNamed:@"pingweiselect"];
    
    UserViewController *uservc=[[UserViewController alloc]initWithNibName:@"UserViewController" bundle:nil];
    USNav=[[MBNavgationController alloc]initWithRootViewController:uservc];
    USNav.tabBarItem.title=@"购物车";
    USNav.tabBarItem.image=[UIImage imageNamed:@"gwc"];
    USNav.tabBarItem.selectedImage=[UIImage imageNamed:@"gwcselect"];
    
    
    MoreViewController *morevc=[[MoreViewController alloc]initWithNibName:@"MoreViewController" bundle:nil];
    MONav=[[MBNavgationController alloc]initWithRootViewController:morevc];
    MONav.tabBarItem.title=@"我的";
    MONav.tabBarItem.image=[UIImage imageNamed:@"wode"];
    MONav.tabBarItem.selectedImage=[UIImage imageNamed:@"wodeselect"];
    
    self.tabBar.backgroundColor=RGBHex(0xfeeeed);
  self.viewControllers=@[PRNav,MENav,CONav,USNav,MONav];
    
    for (int i=0; i<self.tabBar.items.count; i++) {
        
        UITabBarItem *item=[self.tabBar.items objectAtIndex:i];
        
        
//        item settitlea
        NSDictionary *dic=@{NSForegroundColorAttributeName:[UIColor colorWithRed:0.45 green:0.55 blue:0.58 alpha:1.0]};
        [item setTitleTextAttributes:dic forState:UIControlStateNormal];
            NSDictionary *selecteddic = @{NSForegroundColorAttributeName:RGBHex(0x1E90FF)};
        
            [item setTitleTextAttributes:selecteddic forState:UIControlStateSelected];
     [item setTitleTextAttributes:@{ NSForegroundColorAttributeName : RGBHex(0x8C8C8C),NSFontAttributeName:[UIFont fontWithName:@"Helvetica" size:10.0]}            forState:UIControlStateNormal];
        
//
//        switch (i) {
//            case 0:
//                item.title=@"第一个";
//                break;
//            case 1:
//                item.title=@"第二个";
//                break;
//            case 2:
//                item.title=@"第三个";
//                break;
//
//            case 3:
//                item.title=@"第四个";
//                break;
//            case 4:
//                item.title=@"第五个";
//                break;
//            default:
//                break;
//        }
        
    }
    
    // Do any additional setup after loading the view.
}
- (void) updateNotification:(NSString *)str {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:str delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(UIPanGestureRecognizer *)panGesturcognizer{
    if (_panGesturcognizer==nil) {
        _panGesturcognizer=[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panGuestRecognizer:)];
    }
    return _panGesturcognizer;
}
-(void)panGuestRecognizer:(UIPanGestureRecognizer *)pan{
      return;
    if (self.transitionCoordinator) {
        return;
    }
//    响应手势 执行动画
    if (pan.state==UIGestureRecognizerStateBegan||pan.state==UIGestureRecognizerStateChanged) {
        [self beginInteractiveTransitionIfPossible:pan];
    }
    
}
//响应的动画
-(void)beginInteractiveTransitionIfPossible:(UIPanGestureRecognizer *)sender{
    CGPoint translation=[sender translationInView:self.view];
    //判断手势的方向
    if (translation.x>0.f&&self.selectedIndex>0) {
        self.selectedIndex--;
    }//右边滑动
    else if (translation.x<0.f&&self.selectedIndex+1<self.viewControllers.count){
        
        //左边滑动切不是最后一个
        self.selectedIndex++;
        
    }else{
        if (!CGPointEqualToPoint(translation, CGPointZero)) {
//            sender.enabled=NO;
            sender.enabled=YES;
        }
        
        
    }
//    NSLog(@"选中的下标是%lu",(unsigned long)self.selectedIndex);
    [self.transitionCoordinator animateAlongsideTransitionInView:self.view animation:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        
    } completion:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        if ([context isCancelled]&&sender.state==UIGestureRecognizerStateChanged) {
            [self beginInteractiveTransitionIfPossible:sender];
        }
    }];
}
/*
-(id<UIViewControllerAnimatedTransitioning>)tabBarController:(UITabBarController *)tabBarController animationControllerForTransitionFromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    
//    if (self.panGesturcognizer.state==UIGestureRecognizerStateBegan||self.panGesturcognizer.state==UIGestureRecognizerStateChanged) {
        NSArray *viewControllers=tabBarController.viewControllers;
        if ([viewControllers indexOfObject:toVC]>[viewControllers indexOfObject:fromVC]) {
            return [[Animation alloc]initWithTargetEdge:UIRectEdgeLeft];
        }else{
            return [[Animation alloc]initWithTargetEdge:UIRectEdgeRight];
        }
//    }else{
//        return nil;
//    }
}
-(id<UIViewControllerInteractiveTransitioning>)tabBarController:(UITabBarController *)tabBarController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController{
    if (self.panGesturcognizer.state==UIGestureRecognizerStateBegan||self.panGesturcognizer.state==UIGestureRecognizerStateChanged) {
        
         return  [[AnimationController alloc]initWithGestureRecognizer:self.panGesturcognizer];
       
    }else{
        return  nil;
        
    }
}
/*



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    // 1.创建通知
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    // 2.设置通知的必选参数
    // 设置通知显示的内容
    localNotification.alertBody = @"本地通知测试222";
    // 设置通知的发送时间,单位秒
    localNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:10];
    //解锁滑动时的事件
    localNotification.alertAction = @"别磨蹭了!";
    //收到通知时App icon的角标
    localNotification.applicationIconBadgeNumber = 1;
    //推送是带的声音提醒，设置默认的字段为UILocalNotificationDefaultSoundName
    localNotification.soundName = UILocalNotificationDefaultSoundName;
    // 3.发送通知(🐽 : 根据项目需要使用)
    // 方式一: 根据通知的发送时间(fireDate)发送通知
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
    // 方式二: 立即发送通知
    // [[UIApplication sharedApplication] presentLocalNotificationNow:localNotification];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (UIStatusBarStyle)preferredStatusBarStyle {
    //    return UIStatusBarStyleLightContent;
    return UIStatusBarStyleDefault;
}
@end
