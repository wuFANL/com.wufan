//
//  LocationViewController.m
//  com.wufan
//
//  Created by otsoft on 2018/10/10.
//  Copyright © 2018年 wufan. All rights reserved.
//

#import "LocationViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "KCAnnotation.h"
@interface LocationViewController ()<CLLocationManagerDelegate,MKMapViewDelegate,UITextFieldDelegate>{
    
      CLGeocoder *_geocoder;
    
    CLLocationManager *_locationManager;
    
     MKMapView *_mapView;
    CLLocationCoordinate2D cllo2d;
    
}

@end

@implementation LocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.LocatTf.delegate=self;
    
    
     _geocoder=[[CLGeocoder alloc]init];
    //定位管理器
    _locationManager=[[CLLocationManager alloc]init];
    
    if (![CLLocationManager locationServicesEnabled]) {
        NSLog(@"定位服务当前可能尚未打开，请设置打开！");
        return;
    }
    
    //如果没有授权则请求用户授权
    if ([CLLocationManager authorizationStatus]==kCLAuthorizationStatusNotDetermined){
        [_locationManager requestWhenInUseAuthorization];
    }else if([CLLocationManager authorizationStatus]==kCLAuthorizationStatusAuthorizedWhenInUse){
        //设置代理
        _locationManager.delegate=self;
        //设置定位精度
        _locationManager.desiredAccuracy=kCLLocationAccuracyBest;
        //定位频率,每隔多少米定位一次
        CLLocationDistance distance=10.0;//十米定位一次
        _locationManager.distanceFilter=distance;
        
        //启动跟踪定位
        [_locationManager startUpdatingLocation];
    }
    
   
    
}
-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
     [self initGUI];
    
    
}
#pragma mark - CoreLocation 代理
#pragma mark 跟踪定位代理方法，每次位置发生变化即会执行（只要定位到相应位置）
//可以通过模拟器设置一个虚拟位置，否则在模拟器中无法调用此方法
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    CLLocation *location=[locations firstObject];//取出第一个位置
    CLLocationCoordinate2D coordinate=location.coordinate;//位置坐标
    NSLog(@"经度：%f,纬度：%f,海拔：%f,航向：%f,行走速度：%f",coordinate.longitude,coordinate.latitude,location.altitude,location.course,location.speed);
    //如果不需要实时定位，使用完即使关闭定位服务
    [_locationManager stopUpdatingLocation];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (IBAction)gotondw:(id)sender {
    UIButton *btn=(UIButton *)sender;
    if (btn.tag==1) {
         [self getCoordinateByAddress:self.LocatTf.text];
//        self.dweiLabel.text=self.addr;
    }else{
         [self getAddressByLatitude:39.54 longitude:116.28];
//        self.dweiLabel.text=self.dataaddr;
    }
//    [self addAnnotation:<#(CLLocationCoordinate2D)#>]
    
     [self.view endEditing:YES];
}




-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.backgroundColor=[UIColor redColor];
    
//    
//    NavTitleView *titleView = [[NavTitleView alloc]  :CGRectMake(0, 0, SCREEN_WIDTH, 44)];
//    titleView.intrinsicContentSize = CGSizeMake(SCREEN_WIDTH, 44);
//    titleView.backgroundColor = [UIColor clearColor];
//    self.navigationItem.titleView = titleView;
    
    [self createNav:self];
    
}

#pragma mark 根据地名确定地理坐标
-(void)getCoordinateByAddress:(NSString *)address{
    //地理编码
  
    
    __weak MKMapView *map=_mapView;
    [_geocoder geocodeAddressString:address completionHandler:^(NSArray *placemarks, NSError *error) {
        //取得第一个地标，地标中存储了详细的地址信息，注意：一个地名可能搜索出多个地址
        CLPlacemark *placemark=[placemarks firstObject];
        CLLocation *location=placemark.location;//位置
        CLRegion *region=placemark.region;//区域
        NSDictionary *addressDic= placemark.addressDictionary;//详细地址信息字典,包含以下部分信息
                NSString *name=placemark.name;//地名
                NSString *thoroughfare=placemark.thoroughfare;//街道
                NSString *subThoroughfare=placemark.subThoroughfare; //街道相关信息，例如门牌等
                NSString *locality=placemark.locality; // 城市
                NSString *subLocality=placemark.subLocality; // 城市相关信息，例如标志性建筑
                NSString *administrativeArea=placemark.administrativeArea; // 州
                NSString *subAdministrativeArea=placemark.subAdministrativeArea; //其他行政区域信息
                NSString *postalCode=placemark.postalCode; //邮编
                NSString *ISOcountryCode=placemark.ISOcountryCode; //国家编码
                NSString *country=placemark.country; //国家
                NSString *inlandWater=placemark.inlandWater; //水源、湖泊
                NSString *ocean=placemark.ocean; // 海洋
               NSArray *areasOfInterest=placemark.areasOfInterest; //关联的或利益相关的地标
        
        NSLog(@"位置:%@,区域:%@,详细信息:%@",location,region,addressDic);
        CLLocationCoordinate2D ccod=location.coordinate;
       
    
//        ccod=CLLocationCoordinate2DMake(30.2572137669,120.1518058777);
        //
        //
            [ map setCenterCoordinate:(ccod) animated:YES];
             [self addAnnotation:ccod];
    }];
    
  
    
}

#pragma mark 根据坐标取得地名
-(void)getAddressByLatitude:(CLLocationDegrees)latitude longitude:(CLLocationDegrees)longitude{
    //反地理编码

    
    CLLocation *location=[[CLLocation alloc]initWithLatitude:latitude longitude:longitude];
    [_geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        CLPlacemark *placemark=[placemarks firstObject];
        NSLog(@"详细信息:%@",placemark.addressDictionary);
    
    }];
}

#pragma mark 添加地图控件
-(void)initGUI{
//    CGRect rect=[UIScreen mainScreen].bounds;
//    CGRect rect=self.Locationview.bounds;

    _mapView=[[MKMapView alloc]initWithFrame:CGRectMake(0, self.Locationview.frame.origin.y, self.Locationview.frame.size.width, self.Locationview.frame.size.height)];
//    _mapView=[[MKMapView alloc]initWithFrame:rect];
    [self.view addSubview:_mapView];
    //设置代理
    _mapView.delegate=self;
    
    //请求定位服务
    _locationManager=[[CLLocationManager alloc]init];
    if(![CLLocationManager locationServicesEnabled]||[CLLocationManager authorizationStatus]!=kCLAuthorizationStatusAuthorizedWhenInUse){
        [_locationManager requestWhenInUseAuthorization];
    }
    
    //用户位置追踪(用户位置追踪用于标记用户当前位置，此时会调用定位服务)
    _mapView.userTrackingMode=MKUserTrackingModeFollow;
    
    //设置地图类型
    _mapView.mapType=MKMapTypeStandard;
    
    //添加大头针
    CLLocation *location=_locationManager.location;
    CLLocationCoordinate2D cood=location.coordinate;
    
    
   
    [self addAnnotation:cood];
}


#pragma mark 添加大头针
-(void)addAnnotation:(CLLocationCoordinate2D)ccod{
//    CLLocationCoordinate2D location1=CLLocationCoordinate2DMake(39.95, 116.35);
//    KCAnnotation *annotation1=[[KCAnnotation alloc]init];
//    annotation1.title=@"CMJ Studio";
//    annotation1.subtitle=@"Kenshin Cui's Studios";
//    annotation1.coordinate=location1;
//    [_mapView addAnnotation:annotation1];
//
//    CLLocationCoordinate2D location2=CLLocationCoordinate2DMake(39.87, 116.35);
//    KCAnnotation *annotation2=[[KCAnnotation alloc]init];
//    annotation2.title=@"Kenshin&Kaoru";
//    annotation2.subtitle=@"Kenshin Cui's Home";
//    annotation2.coordinate=location2;
//    [_mapView addAnnotation:annotation2];
      KCAnnotation *annotation2=[[KCAnnotation alloc]init];
        annotation2.title=@"Kenshin&Kaoru";
        annotation2.subtitle=@"Kenshin Cui's Home";
        annotation2.coordinate=ccod;
        annotation2.image=[UIImage imageNamed:@"定位.png"];
        cllo2d=ccod;
    
    
//        [_mapView addAnnotation:annotation2];
}

#pragma mark - 地图控件代理方法
#pragma mark 更新用户位置，只要用户改变则调用此方法（包括第一次定位到用户位置）
-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    
    NSLog(@"%@",userLocation);
    //    设置地图显示范围(如果不进行区域设置会自动显示区域范围并指定当前用户位置为地图中心点)
            MKCoordinateSpan span=MKCoordinateSpanMake(0.01, 0.01);
    
    
    
            MKCoordinateRegion region=MKCoordinateRegionMake(cllo2d, span);
            [_mapView setRegion:region animated:true];
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
    
}

#pragma mark - 地图控件代理方法
#pragma mark 显示大头针时调用，注意方法中的annotation参数是即将显示的大头针对象
-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    //由于当前位置的标注也是一个大头针，所以此时需要判断，此代理方法返回nil使用默认大头针视图
    if ([annotation isKindOfClass:[KCAnnotation class]]) {
        static NSString *key1=@"AnnotationKey1";
        MKAnnotationView *annotationView=[_mapView dequeueReusableAnnotationViewWithIdentifier:key1];
        //如果缓存池中不存在则新建
        if (!annotationView) {
            annotationView=[[MKAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:key1];
            annotationView.canShowCallout=true;//允许交互点击
            annotationView.calloutOffset=CGPointMake(0, 1);//定义详情视图偏移量
            annotationView.leftCalloutAccessoryView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"定位.png"]];//定义详情左侧视图
        }
        
        //修改大头针视图
        //重新设置此类大头针视图的大头针模型(因为有可能是从缓存池中取出来的，位置是放到缓存池时的位置)
        annotationView.annotation=annotation;
        annotationView.image=((KCAnnotation *)annotation).image;//设置大头针视图的图片
        
        return annotationView;
    }else {
        return nil;
    }
}



@end
