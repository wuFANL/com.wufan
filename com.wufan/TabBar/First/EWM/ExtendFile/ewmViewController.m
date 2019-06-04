//
//  ewmViewController.m
//  com.wufan
//
//  Created by appleadmin on 2019/1/11.
//  Copyright © 2019年 wufan. All rights reserved.
//

#import "ewmViewController.h"
#import "KMQRCode.h"
#import "UIImage+RoundedRectImage.h"
#import "HWButton.h"
#import <AVFoundation/AVCaptureDevice.h>
#import <AVFoundation/AVMediaFormat.h>
#import "PBViewController.h"
@interface ewmViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>{
    NSMutableArray *imageArr;
    
    
}
- (void)layoutUI;
@property AVCaptureDevice *captureDeviceInput;
@end

@implementation ewmViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *vstr=[self.info objectForKey:@"view"];
     [self createImage];
    if ([vstr containsString:@"ewm"]) {
       [self layoutUI];
    }else{
        [self createBanner];
    }
    self.imgVQRCode.image=[UIImage imageNamed:@"kn-1.png"];
    self.imgVQRCode.contentMode=UIViewContentModeScaleAspectFill;
}

/**
 判断相机权限
 */
-(void)PhotoIsOpen{
    AVAuthorizationStatus avStatus=[AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    BOOL useable=[UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
    if (avStatus==AVAuthorizationStatusRestricted||avStatus==AVAuthorizationStatusDenied) {
        [self guideUserOpenAuth];
    }else{
          [self OpenSuccwith:@"AV"];
        
        
    }
    if (!useable) {
        NSLog(@"当前相机不可用");
    }
}
-(void)changePhotoPostion{
   
}

/**
 打开相机或者相册
 */
-(void)OpenSuccwith:(NSString *)flag{
    UIImagePickerController *photoPicker=[UIImagePickerController new];
    photoPicker.delegate=self;
    photoPicker.allowsEditing=NO;
    if ([flag isEqualToString:@"AV"]) {
        photoPicker.sourceType=UIImagePickerControllerSourceTypeCamera;
    }
    if ([flag isEqualToString:@"PH"]) {
        photoPicker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    [self presentViewController:photoPicker animated:YES completion:nil];
    
}
-(void)guideUserOpenAuth{
    UIAlertController *alertC=[UIAlertController alertControllerWithTitle:@"温馨提示" message:@"请在设置中打开相机权限" preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *cancel=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *action=[UIAlertAction actionWithTitle:@"去设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSURL *url=[NSURL URLWithString:UIApplicationOpenSettingsURLString];
        if ([[UIApplication sharedApplication]canOpenURL:url]) {
            if (@available(iOS 10.0, *)) {
                [[UIApplication sharedApplication]openURL:url options:@{} completionHandler:nil];
            } else {
                // Fallback on earlier versions
            }
        }
    }];
    [alertC addAction:cancel];
    [alertC addAction:action];
    [self presentViewController:alertC animated:YES completion:nil];
}

/**
 代理事件 相机获取图片之后
 */
#pragma imagePicker
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info{
    NSString *mediaType=[info objectForKey:UIImagePickerControllerMediaType];
    if ([mediaType isEqualToString:@"public.image"]) {
        UIImage *image;
        //判断图片是否x允许修改
        if ([picker allowsEditing]) {
            image=[info objectForKey:UIImagePickerControllerEditedImage];
        } else {
            //照片的元数据参数
            image=[info objectForKey:UIImagePickerControllerOriginalImage];
        }
        /*
         */
        UIImage *compressImg=[self compressPictureWith:image];
        self.imgVQRCode.image=compressImg;
        [imageArr addObject:image];
        NSData *tmpData=UIImageJPEGRepresentation(compressImg, 0.5);
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:nil];
}


//压缩图片
-(UIImage *)compressPictureWith:(UIImage *)originnalImage{
    CGFloat ruleWidth=600;
    if (originnalImage.size.width<ruleWidth) {
        return originnalImage;
    }
    CGFloat hight=ruleWidth/originnalImage.size.width*originnalImage.size.height;
    CGRect rect=CGRectMake(0, 0, ruleWidth, hight);
    UIGraphicsBeginImageContext(rect.size);
    [originnalImage drawInRect:rect];
    UIImage *img=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
    
}

-(void)createBanner{
    HWButton *btn=[[HWButton alloc]init];
//    btn.frame=CGRectMake(10, 10, 30, 20);
    btn.backgroundColor=[UIColor grayColor];
    [btn addTarget:self action:@selector(SelectImage) forControlEvents: UIControlEventTouchUpInside];
    [btn setTitle:@"选取图片" forState:UIControlStateNormal];
    [self.view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) { make.bottom.mas_equalTo(self.imgVQRCode.mas_top).offset(-10);
        make.left.mas_equalTo(20);
//        make.size.lessThanOrEqualTo(CGSizeMake(30, 20));
    }];
    HWButton *pbBtn=[[HWButton alloc]init];
    //    btn.frame=CGRectMake(10, 10, 30, 20);
    pbBtn.backgroundColor=[UIColor grayColor];
    [pbBtn addTarget:self action:@selector(pbAction) forControlEvents: UIControlEventTouchUpInside];
    [pbBtn setTitle:@"弹出瀑布流图片" forState:UIControlStateNormal];
    [self.view addSubview:pbBtn];
    [pbBtn mas_makeConstraints:^(MASConstraintMaker *make) {
    make.bottom.mas_equalTo(self.imgVQRCode.mas_top).offset(-10);
        make.right.mas_equalTo(-20);
        //        make.size.lessThanOrEqualTo(CGSizeMake(30, 20));
    }];
}
-(void)pbAction{
    PBViewController *pbvc=[[PBViewController alloc]init];
    pbvc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    pbvc.modalTransitionStyle=UIModalTransitionStyleCrossDissolve;
//    弹出来的动画效果
    /*
     UIModalTransitionStyleFlipHorizontal 风页一样转一下，有透明效果
     UIModalTransitionStyleCoverVertical 从底部慢慢推上去
     UIModalTransitionStyleCrossDissolve 渐变显示，有透明效果
     UIModalTransitionStylePartialCurl
     */
//   弹出的视图风格
    /*
     UIModalPresentationOverCurrentContext 视图可透明显示
     
     */
    pbvc.infoArr=imageArr;
    [self presentViewController:pbvc animated:YES completion:nil];
}
//打开相机获取图片
-(void)SelectImage{
     [self PhotoIsOpen];
}
-(NSDictionary*)info{
    if (!_info) {
        _info=[[NSMutableDictionary alloc]init];
    }
    return _info;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//创建imageview
-(void)createImage{
        self.imgVQRCode=[[UIImageView alloc]init];
        _imgVQRCode.frame=CGRectMake(10, 50, 300, 400);
        self.imgVQRCode.backgroundColor=[UIColor grayColor];
        [self.view addSubview:_imgVQRCode];
        [self.imgVQRCode mas_makeConstraints:^(MASConstraintMaker *make) { make.edges.mas_equalTo(self.view).with.insets(UIEdgeInsetsMake(50, 10, 50, 10));;
        }];
    
}

- (void)layoutUI {
   
    //用于生成二维码的字符串source
    NSString *source = @"https://www.wondercv.com/zh-CN/cvs/HOUvvlQ/share";
    
    //使用iOS 7后的CIFilter对象操作，生成二维码图片imgQRCode（会拉伸图片，比较模糊，效果不佳）
    CIImage *imgQRCode = [KMQRCode createQRCodeImage:source];
    
    //使用核心绘图框架CG（Core Graphics）对象操作，进一步针对大小生成二维码图片imgAdaptiveQRCode（图片大小适合，清晰，效果好）
    UIImage *imgAdaptiveQRCode = [KMQRCode resizeQRCodeImage:imgQRCode withSize:self.imgVQRCode.frame.size.width];
    //默认产生的黑白色的二维码图片；我们可以让它产生其它颜色的二维码图片，例如：蓝白色的二维码图片
    imgAdaptiveQRCode = [KMQRCode specialColorImage:imgAdaptiveQRCode
                                            withRed:33.0
                                              green:114.0
                                               blue:237.0]; //0~255
    //使用核心绘图框架CG（Core Graphics）对象操作，创建带圆角效果的图片
//
//    UIImage *imgIcon =[UIImage createRoundedRectImage:[UIImage imageNamed:@"QRCode"]  withSize:CGSizeMake(70.0, 93.0) withRadiuus:10];
    CGSize size=CGSizeMake(70.0, 93.0);
//    UIImage *imgIcon=[UIImage createRoundedRectImage:[UIImage imageNamed:@"启动"] withSize:size withRadiuus:10];
    
    //    imgAdaptiveQRCode = [KMQRCode addIconToQRCodeImage:imgAdaptiveQRCode
    //                                              withIcon:imgIcon
    //                                             withScale:3];
   self.imgVQRCode.image = imgAdaptiveQRCode;
    //设置图片视图的圆角边框效果
    self.imgVQRCode.layer.masksToBounds = YES;
    self.imgVQRCode.layer.cornerRadius = 10.0;
    self.imgVQRCode.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.imgVQRCode.layer.borderWidth = 4.0;
    NSString *path_document = NSHomeDirectory();
    //设置一个图片的存储路径
    NSString *imagePath = [path_document stringByAppendingString:@"/Documents/pic.png"];
    NSLog(@"图片地址在%@",imagePath);
    //把图片直接保存到指定的路径（同时应该把图片的路径imagePath存起来，下次就可以直接用来取）
    [UIImagePNGRepresentation(self.imgVQRCode.image) writeToFile:imagePath atomically:YES];
}


//-(UIImageView *)imgVQRCode{
//    if (!_imgVQRCode) {
//        _imgVQRCode=[[UIImageView alloc]initWithFrame:CGRectMake(100, 100, 300, 100)];
//        [self.view addSubview:_imgVQRCode];
//    }
//    return _imgVQRCode;
//}

@end
