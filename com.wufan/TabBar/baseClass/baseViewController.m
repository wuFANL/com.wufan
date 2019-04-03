//
//  baseViewController.m
//  com.wufan
//
//  Created by otsoft on 2018/7/24.
//  Copyright © 2018年 wufan. All rights reserved.
//

#import "baseViewController.h"

@interface baseViewController ()<UISearchBarDelegate>
{
    CGRect viewRect;
}
@property(nonatomic ,strong) UITextField * firstResponderTextF;//记录将要编辑的输入框
@end

@implementation baseViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    AppDelegate *appdele=APPDTE;
    appdele.allowRotation=NO;
    //底部导航和顶部导航被遮挡问题
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
//    self.firstResponderTextF.delegate=self;
   
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
        viewRect=self.view.frame;
    
}
- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)backaction{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
-(void)createNav:(UIViewController *)vc{

    
//    dispatch_async(dispatch_get_main_queue(), ^{
        // 隐藏系统导航栏
    [vc.navigationController setNavigationBarHidden:YES animated:YES];
        // 创建假的导航栏
        UIView *navView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, 44)];
        [vc.view addSubview:navView];
        // 创建导航栏的titleLabel
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0,30)];
        titleLabel.text = @"定位详情";
        [titleLabel sizeToFit];
        titleLabel.frame = CGRectMake([UIScreen mainScreen].bounds.size.width / 2 - titleLabel.frame.size.width / 2, 0, titleLabel.frame.size.width, 44);
        [navView addSubview:titleLabel];
        // 创建导航栏右边按钮
        UIButton *right= [UIButton buttonWithType:UIButtonTypeSystem];
        [right setTitle:@"首页" forState:UIControlStateNormal];
        right.frame = CGRectMake([UIScreen mainScreen].bounds.size.width -100, 0, 100, 44);
        [right addTarget:vc action:@selector(backaction) forControlEvents:UIControlEventTouchUpInside];
        [navView addSubview:right];
        // 创建导航栏左按钮
        UIButton *left= [UIButton buttonWithType:UIButtonTypeSystem];
        [left setTitle:@"返回" forState:UIControlStateNormal];
        [left addTarget:vc action:@selector(backaction) forControlEvents:UIControlEventTouchUpInside];
        [navView addSubview:left];
        left.frame = CGRectMake(0, 0, 100, 44);
//    });
    
}
//MARK:重写左边导航栏按钮
-(void)changeLeftBtn{
    UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(-5, 0, 30, 45)];
    [btn setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    btn.contentMode=UIViewContentModeScaleAspectFit;
    [btn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    UIView *view=[[UIView alloc]initWithFrame:btn.frame];
    [view addSubview:btn];
    UIBarButtonItem *btnItem=[[UIBarButtonItem alloc]initWithCustomView:view];
    self.navigationItem.leftBarButtonItem=btnItem;
}
-(UIView *)selectBtn{
    if (!_selectBtn) {
        _selectBtn=[[UIView alloc]init];
        _selectBtn.backgroundColor=RGBHex(0Xf5f5f5);
        UIButton *centerBtn=[[UIButton alloc]init];
//        centerBtn.backgroundColor=RGBHex(0XD3D3D3);
        centerBtn.titleLabel.font=[UIFont systemFontOfSize:15]; centerBtn.titleLabel.adjustsFontSizeToFitWidth=YES;
        centerBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
          [centerBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [centerBtn setTitle:@"搜一搜" forState:UIControlStateNormal];
        [_selectBtn addSubview:centerBtn];
        [centerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(2);
            make.left.mas_equalTo(42);
            make.right.mas_equalTo(-42);
            make.bottom.mas_equalTo(-2);
        }];
        UIButton *select=[[UIButton alloc]init];
        [select setBackgroundImage:[UIImage imageNamed:@"select"]  forState:UIControlStateNormal];
        select.contentMode=UIViewContentModeScaleAspectFit;
     select.contentMode=UIViewContentModeScaleAspectFit;
        [_selectBtn addSubview:select];
        [select mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(2);
            make.right.mas_equalTo(centerBtn.mas_left).and.offset(-5);
            //            make.size.mas_equalTo(CGSizeMake(25, 25));
            make.bottom.mas_equalTo(-2);
        }];
        UIButton *QR=[[UIButton alloc]init];
        [QR setBackgroundImage:[UIImage imageNamed:@"erweima"] forState:UIControlStateNormal];
        QR.contentMode=UIViewContentModeScaleAspectFit; QR.contentMode=UIViewContentModeScaleAspectFit;
        [_selectBtn addSubview:QR];
        [QR mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(2);
        make.left.mas_equalTo(centerBtn.mas_right).with.offset(-5);
            //make.size.mas_equalTo(CGSizeMake(25, 25));
            make.bottom.mas_equalTo(-2);
        }];
    }
    return _selectBtn;
}
-(UIView *)SelectBtnView:(NSString *)name delegate:(id<UISearchBarDelegate >)delegate{
    UISearchBar *searchBar=[[UISearchBar alloc]initWithFrame:CGRectZero];
        searchBar.placeholder=name;
    [searchBar setSearchResultsButtonSelected:NO];//设置搜索结果是否被选中
    [searchBar setShowsSearchResultsButton:YES];
    searchBar.delegate=delegate;
    return searchBar;
}
-(UISearchBar *)search{
    if (!_search) {
        _search=[[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, 230, 30)];
//        _search=[[UISearchBar alloc]init];
//        _selectBtn.bar=[UIColor grayColor];
        _search.barStyle=UIBarStyleDefault;
    }
    return  _search;
}
- (BOOL)shouldAutorotate {
    return NO;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //点击空白回收键盘
//    [self.view endEditing:YES];
  if ([self.firstResponderTextF isFirstResponder])[self.firstResponderTextF resignFirstResponder];
}
#pragma maek UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    textField.keyboardType=UIKeyboardTypeDefault;
    
    self.firstResponderTextF = textField;//当将要开始编辑的时候，获取当前的textField
    return YES;
}
//
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark : UIKeyboardWillShowNotification/UIKeyboardWillHideNotification
- (void)keyboardWillShow:(NSNotification *)notification{
    
//       viewRect=self.view.frame;
    
    //获取键盘高度，在不同设备上，以及中英文下是不同的
    CGFloat kbHeight = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    //计算出键盘顶端到inputTextView panel底端的距离(加上自定义的缓冲距离INTERVAL_KEYBOARD)
    //输入框的y与键盘的高度
    CGFloat texfiedY=self.firstResponderTextF.frame.origin.y;
    CGFloat fiedHeight=self.firstResponderTextF.frame.size.height;
    //一定是屏幕的高度否则不对
     int height = [ UIScreen mainScreen ].bounds.size.height;
    CGFloat offset =height-texfiedY-fiedHeight-kbHeight;
    // 取得键盘的动画时间，这样可以在视图上移的时候更连贯
    double duration = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    //将视图上移计算好的偏移
    if(offset < 0) {
        [UIView animateWithDuration:duration animations:^{
            self.view.frame = CGRectMake(0.0f, offset, self.view.frame.size.width, self.view.frame.size.height);
        }];
    }
}
- (void)keyboardWillHide:(NSNotification *)notification{
    // 键盘动画时间
    double duration = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    //视图下沉恢复原状
    [UIView animateWithDuration:duration animations:^{
//        self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        self.view.frame=self->viewRect;
          NSLog(@"当前屏幕的高度是：%@", NSStringFromCGRect(self.view.frame));
    }];
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}
@end
