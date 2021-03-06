//
//  SettingView.m
//  SmartPublisherSDK
//
//  GitHub: https://github.com/daniulive/SmarterStreaming
//
//  Created by daniulive on 16/3/24.
//  Copyright © 2016年 daniulive. All rights reserved.
//

#import "SettingView.h"
#import "ViewController.h"
#import "RecorderView.h"


#define kBtnHeight     50
#define kHorMargin     10
#define kVerMargin     80


@interface SettingView ()
{
    DNVideoStreamingQuality streamQuality;
    Boolean                 is_audio_only_;
    Boolean                 is_recorder_;
    Boolean                 is_beauty_;
}

@property (nonatomic, strong) UINavigationBar *nvgBar;
@property (nonatomic, strong) UINavigationItem *nvgItem;

@property (nonatomic, strong) UIButton *highQualityBtn;
@property (nonatomic, strong) UIButton *mediumQualityBtn;
@property (nonatomic, strong) UIButton *lowQualityBtn;

@property (nonatomic, strong) UIButton *avBtn;
@property (nonatomic, strong) UIButton *audioBtn;

@property (nonatomic, strong) UIButton *recorderBtn;
@property (nonatomic, strong) UIButton *noRecorderBtn;

@property (nonatomic, strong) UIButton *beautyBtn;
@property (nonatomic, strong) UIButton *noBeautyBtn;

@property (nonatomic, strong) UIButton *interPublisherView;
@property (nonatomic, strong) UIButton *interRecorderView;

@property (nonatomic, strong) UILabel *highQualityLable;
@property (nonatomic, strong) UILabel *mediumQualityLable;
@property (nonatomic, strong) UILabel *lowQualityLable;

@property (nonatomic, strong) UILabel *avLable;
@property (nonatomic, strong) UILabel *audioLable;

@property (nonatomic, strong) UILabel *recorderLable;
@property (nonatomic, strong) UILabel *noRecorderLable;

@property (nonatomic, strong) UILabel *beautyLable;
@property (nonatomic, strong) UILabel *noBeautyLable;

- (void)qualityButtonClicked:(id)sender;
- (void)interPublisherViewBtnPressed:(id)sender;

@end

@implementation SettingView

@synthesize nvgBar;
@synthesize nvgItem;
@synthesize lowQualityBtn;
@synthesize mediumQualityBtn;
@synthesize highQualityBtn;
@synthesize avBtn;
@synthesize audioBtn;
@synthesize recorderBtn;
@synthesize noRecorderBtn;
@synthesize beautyBtn;
@synthesize noBeautyBtn;
@synthesize lowQualityLable;
@synthesize mediumQualityLable;
@synthesize highQualityLable;
@synthesize avLable;
@synthesize audioLable;
@synthesize recorderLable;
@synthesize noRecorderLable;
@synthesize beautyLable;
@synthesize noBeautyLable;
@synthesize interPublisherView;
@synthesize interRecorderView;


#pragma mark - Init
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)loadView
{
    // If you create your views manually, you MUST override this method and use it to create your views.
    // If you use Interface Builder to create your views, then you must NOT override this method.
    
    //默认标清分辨率
    streamQuality = DN_VIDEO_QUALITY_MEDIUM;
    //默认采集音视频
    is_audio_only_= false;
    //默认不录像
    is_recorder_  = false;
    //默认美颜
    is_beauty_ = true;
    
    self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
    self.view.backgroundColor = [UIColor whiteColor];
    
    //当前屏幕宽高
    CGFloat screenWidth  = CGRectGetWidth([UIScreen mainScreen].bounds);
    
    //导航栏:直播设置
    
    [self.navigationItem setTitle:@"大牛直播推流端V1.0.06.08.24"];
    
    [self.navigationController.navigationBar setBackgroundColor:[UIColor blackColor]];

    CGFloat buttonWidth = screenWidth - kHorMargin*2;
    
    CGFloat buttonSpace = (screenWidth - 2*kHorMargin-160)/6;
    //直播视频质量
    self.lowQualityBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.lowQualityBtn.tag = 1;
    self.lowQualityBtn.frame = CGRectMake(kHorMargin+buttonSpace, kVerMargin+kBtnHeight, 20, 20);
    [self.lowQualityBtn setImage:[UIImage imageNamed:@"btn_unselected"] forState:UIControlStateNormal];
    [self.lowQualityBtn addTarget:self action:@selector(qualityButtonClicked:) forControlEvents:UIControlEventTouchDown];
    
    self.lowQualityLable = [[UILabel alloc] initWithFrame:CGRectMake(kHorMargin+buttonSpace+20, kVerMargin+kBtnHeight, 60, 20)];
    self.lowQualityLable.text = @"流畅";
    self.lowQualityLable.textColor = [[UIColor alloc] initWithRed:51.0/255 green:51.0/255 blue:51.0/255 alpha:1.0];
   
    self.mediumQualityBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.mediumQualityBtn.tag = 2;

    self.mediumQualityBtn.frame = CGRectMake(kHorMargin+3*buttonSpace+60, kVerMargin+kBtnHeight, 20, 20);
    [self.mediumQualityBtn setImage:[UIImage imageNamed:@"btn_selected"] forState:UIControlStateNormal];
    [self.mediumQualityBtn addTarget:self action:@selector(qualityButtonClicked:) forControlEvents:UIControlEventTouchDown];
    self.mediumQualityLable = [[UILabel alloc] initWithFrame:CGRectMake(kHorMargin+3*buttonSpace+80, kVerMargin+kBtnHeight, 40, 20)];
    self.mediumQualityLable.text = @"标清";
    self.mediumQualityLable.textColor = [[UIColor alloc] initWithRed:51.0/255 green:51.0/255 blue:51.0/255 alpha:1.0];
    
    self.highQualityBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.highQualityBtn.tag = 3;
    
    self.highQualityBtn.frame = CGRectMake(screenWidth-kHorMargin-buttonSpace-60,kVerMargin+kBtnHeight,20,20);
    [self.highQualityBtn setImage:[UIImage imageNamed:@"btn_unselected"] forState:UIControlStateNormal];
    [self.highQualityBtn addTarget:self action:@selector(qualityButtonClicked:) forControlEvents:UIControlEventTouchDown];
    self.highQualityLable = [[UILabel alloc] initWithFrame:CGRectMake(screenWidth-kHorMargin-buttonSpace-40,kVerMargin+kBtnHeight,40,20)];
    self.highQualityLable.text = @"高清";
    self.highQualityLable.textColor = [[UIColor alloc] initWithRed:51.0/255 green:51.0/255 blue:51.0/255 alpha:1.0];
    
    //推送音视频还是纯音频
    self.avBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.avBtn.tag = 1;
    self.avBtn.frame = CGRectMake(kHorMargin+buttonSpace, kVerMargin+kBtnHeight+80, 20, 20);
    [self.avBtn setImage:[UIImage imageNamed:@"btn_selected"] forState:UIControlStateNormal];
    [self.avBtn addTarget:self action:@selector(pushTypeButtonClicked:) forControlEvents:UIControlEventTouchDown];
    
    self.avLable = [[UILabel alloc] initWithFrame:CGRectMake(kHorMargin+buttonSpace+20, kVerMargin+kBtnHeight+80, 60, 20)];
    self.avLable.text = @"音视频";
    self.avLable.textColor = [[UIColor alloc] initWithRed:51.0/255 green:51.0/255 blue:51.0/255 alpha:1.0];
    
    self.audioBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.audioBtn.tag = 2;
    
    self.audioBtn.frame = CGRectMake(kHorMargin+3*buttonSpace+60, kVerMargin+kBtnHeight+80, 20, 20);
    [self.audioBtn setImage:[UIImage imageNamed:@"btn_unselected"] forState:UIControlStateNormal];
    [self.audioBtn addTarget:self action:@selector(pushTypeButtonClicked:) forControlEvents:UIControlEventTouchDown];
    self.audioLable = [[UILabel alloc] initWithFrame:CGRectMake(kHorMargin+3*buttonSpace+80, kVerMargin+kBtnHeight+80, 60, 20)];
    self.audioLable.text = @"纯音频";
    self.audioLable.textColor = [[UIColor alloc] initWithRed:51.0/255 green:51.0/255 blue:51.0/255 alpha:1.0];

    //是否录像
    self.noRecorderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.noRecorderBtn.tag = 1;
    self.noRecorderBtn.frame = CGRectMake(kHorMargin+buttonSpace, kVerMargin+kBtnHeight+80+80, 20, 20);
    [self.noRecorderBtn setImage:[UIImage imageNamed:@"btn_selected"] forState:UIControlStateNormal];
    [self.noRecorderBtn addTarget:self action:@selector(recorderButtonClicked:) forControlEvents:UIControlEventTouchDown];
    
    self.noRecorderLable = [[UILabel alloc] initWithFrame:CGRectMake(kHorMargin+buttonSpace+20, kVerMargin+kBtnHeight+80+80, 60, 20)];
    self.noRecorderLable.text = @"不录像";
    self.noRecorderLable.textColor = [[UIColor alloc] initWithRed:51.0/255 green:51.0/255 blue:51.0/255 alpha:1.0];
    
    self.recorderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.recorderBtn.tag = 2;
    
    self.recorderBtn.frame = CGRectMake(kHorMargin+3*buttonSpace+60, kVerMargin+kBtnHeight+80+80, 20, 20);
    [self.recorderBtn setImage:[UIImage imageNamed:@"btn_unselected"] forState:UIControlStateNormal];
    [self.recorderBtn addTarget:self action:@selector(recorderButtonClicked:) forControlEvents:UIControlEventTouchDown];
    self.recorderLable = [[UILabel alloc] initWithFrame:CGRectMake(kHorMargin+3*buttonSpace+80, kVerMargin+kBtnHeight+80+80, 80, 20)];
    self.recorderLable.text = @"边推边录";
    self.recorderLable.textColor = [[UIColor alloc] initWithRed:51.0/255 green:51.0/255 blue:51.0/255 alpha:1.0];
    
    //是否美颜
    self.beautyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.beautyBtn.tag = 1;
    self.beautyBtn.frame = CGRectMake(kHorMargin+buttonSpace, kVerMargin+kBtnHeight+80+80+80, 20, 20);
    [self.beautyBtn setImage:[UIImage imageNamed:@"btn_selected"] forState:UIControlStateNormal];
    [self.beautyBtn addTarget:self action:@selector(beautyButtonClicked:) forControlEvents:UIControlEventTouchDown];
    
    self.beautyLable = [[UILabel alloc] initWithFrame:CGRectMake(kHorMargin+buttonSpace+20, kVerMargin+kBtnHeight+80+80+80, 60, 20)];
    self.beautyLable.text = @"美颜";
    self.beautyLable.textColor = [[UIColor alloc] initWithRed:51.0/255 green:51.0/255 blue:51.0/255 alpha:1.0];
    
    
    self.noBeautyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.noBeautyBtn.tag = 2;
    self.noBeautyBtn.frame = CGRectMake(kHorMargin+3*buttonSpace+60, kVerMargin+kBtnHeight+80+80+80, 20, 20);
    [self.noBeautyBtn setImage:[UIImage imageNamed:@"btn_unselected"] forState:UIControlStateNormal];
    [self.noBeautyBtn addTarget:self action:@selector(beautyButtonClicked:) forControlEvents:UIControlEventTouchDown];
    self.noBeautyLable = [[UILabel alloc] initWithFrame:CGRectMake(kHorMargin+3*buttonSpace+80, kVerMargin+kBtnHeight+80+80+80, 80, 20)];
    self.noBeautyLable.text = @"不美颜";
    self.noBeautyLable.textColor = [[UIColor alloc] initWithRed:51.0/255 green:51.0/255 blue:51.0/255 alpha:1.0];
    
    //进入推流页面
    self.interPublisherView = [UIButton buttonWithType:UIButtonTypeCustom];
    self.interPublisherView.tag = 3;
    self.interPublisherView.frame = CGRectMake(kHorMargin, kVerMargin+kBtnHeight+80+80+80+60, buttonWidth, kBtnHeight);
    [self.interPublisherView setTitle:@"进入推流页面" forState:UIControlStateNormal];
    [self.interPublisherView setBackgroundImage:[UIImage imageNamed:@"back_color"] forState:UIControlStateNormal];
    self.interPublisherView.titleLabel.textColor = [[UIColor alloc] initWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
    [self.interPublisherView addTarget:self action:@selector(interPublisherViewBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    //进入回放页面
    self.interRecorderView = [UIButton buttonWithType:UIButtonTypeCustom];
    self.interRecorderView.tag = 4;
    self.interRecorderView.frame = CGRectMake(kHorMargin, kVerMargin+kBtnHeight+80+80+80+80+60, buttonWidth, kBtnHeight);
    [self.interRecorderView setTitle:@"进入回放页面" forState:UIControlStateNormal];
    [self.interRecorderView setBackgroundImage:[UIImage imageNamed:@"back_color"] forState:UIControlStateNormal];
    self.interRecorderView.titleLabel.textColor = [[UIColor alloc] initWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
    [self.interRecorderView addTarget:self action:@selector(interRecorderViewBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.nvgBar];
    [self.view addSubview:self.highQualityBtn];
    [self.view addSubview:self.mediumQualityBtn];
    [self.view addSubview:self.lowQualityBtn];
    
    [self.view addSubview:self.avBtn];
    [self.view addSubview:self.audioBtn];
    
    [self.view addSubview:self.noRecorderBtn];
    [self.view addSubview:self.recorderBtn];

    [self.view addSubview:self.beautyBtn];
    [self.view addSubview:self.noBeautyBtn];
    
    [self.view addSubview:self.interPublisherView];
    [self.view addSubview:self.interRecorderView];
    [self.view addSubview:self.highQualityLable];
    [self.view addSubview:self.mediumQualityLable];
    [self.view addSubview:self.lowQualityLable];
    
    [self.view addSubview:self.avLable];
    [self.view addSubview:self.audioLable];
    
    [self.view addSubview:self.noRecorderLable];
    [self.view addSubview:self.recorderLable];
    
    [self.view addSubview:self.beautyLable];
    [self.view addSubview:self.noBeautyLable];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Buttons methods
- (void)qualityButtonClicked:(id)sender {
    
    UIButton *qualityBtn = (UIButton *)sender;

    switch (qualityBtn.tag) {
        case 1: {
            streamQuality = DN_VIDEO_QUALITY_LOW;
            [self.mediumQualityBtn setImage:[UIImage imageNamed:@"btn_unselected"] forState:UIControlStateNormal];
            [self.highQualityBtn setImage:[UIImage imageNamed:@"btn_unselected"] forState:UIControlStateNormal];
            [self.lowQualityBtn setImage:[UIImage imageNamed:@"btn_selected"] forState:UIControlStateNormal];
            break;
        }
        case 2: {
            streamQuality = DN_VIDEO_QUALITY_MEDIUM;
            [self.mediumQualityBtn setImage:[UIImage imageNamed:@"btn_selected"] forState:UIControlStateNormal];
            [self.highQualityBtn setImage:[UIImage imageNamed:@"btn_unselected"] forState:UIControlStateNormal];
            [self.lowQualityBtn setImage:[UIImage imageNamed:@"btn_unselected"] forState:UIControlStateNormal];
            break;
        }
        case 3: {
            streamQuality = DN_VIDEO_QUALITY_HIGH;
            [self.mediumQualityBtn setImage:[UIImage imageNamed:@"btn_unselected"] forState:UIControlStateNormal];
            [self.highQualityBtn setImage:[UIImage imageNamed:@"btn_selected"] forState:UIControlStateNormal];
            [self.lowQualityBtn setImage:[UIImage imageNamed:@"btn_unselected"] forState:UIControlStateNormal];
            break;
        }
        default:
            break;
    }
}

- (void)pushTypeButtonClicked:(id)sender {
    
    UIButton *pushTypeBtn = (UIButton *)sender;
    
    switch (pushTypeBtn.tag) {
        case 1: {
            [self.avBtn setImage:[UIImage imageNamed:@"btn_selected"] forState:UIControlStateNormal];
            [self.audioBtn setImage:[UIImage imageNamed:@"btn_unselected"] forState:UIControlStateNormal];
            is_audio_only_ = false;
            break;
        }
        case 2: {
            [self.avBtn setImage:[UIImage imageNamed:@"btn_unselected"] forState:UIControlStateNormal];
            [self.audioBtn setImage:[UIImage imageNamed:@"btn_selected"] forState:UIControlStateNormal];
            is_audio_only_ = true;
            break;
        }
        default:
            break;
    }
}

- (void)recorderButtonClicked:(id)sender {
    
    UIButton *recorderTypeBtn = (UIButton *)sender;
    
    switch (recorderTypeBtn.tag) {
        case 1: {
            [self.noRecorderBtn setImage:[UIImage imageNamed:@"btn_selected"] forState:UIControlStateNormal];
            [self.recorderBtn setImage:[UIImage imageNamed:@"btn_unselected"] forState:UIControlStateNormal];
            is_recorder_ = false;
            break;
        }
        case 2: {
            [self.noRecorderBtn setImage:[UIImage imageNamed:@"btn_unselected"] forState:UIControlStateNormal];
            [self.recorderBtn setImage:[UIImage imageNamed:@"btn_selected"] forState:UIControlStateNormal];
            is_recorder_ = true;
            break;
        }
        default:
            break;
    }
}

- (void)beautyButtonClicked:(id)sender {
    
    UIButton *beautyTypeBtn = (UIButton *)sender;
    
    switch (beautyTypeBtn.tag) {
        case 1: {
            [self.beautyBtn setImage:[UIImage imageNamed:@"btn_selected"] forState:UIControlStateNormal];
            [self.noBeautyBtn setImage:[UIImage imageNamed:@"btn_unselected"] forState:UIControlStateNormal];
            is_beauty_ = true;
            break;
        }
        case 2: {
            [self.beautyBtn setImage:[UIImage imageNamed:@"btn_unselected"] forState:UIControlStateNormal];
            [self.noBeautyBtn setImage:[UIImage imageNamed:@"btn_selected"] forState:UIControlStateNormal];
            is_beauty_ = false;
            break;
        }
        default:
            break;
    }
}

- (void)interPublisherViewBtnPressed:(id)sender {
    ViewController * coreView =[[ViewController alloc] initParameter:streamQuality isAudioOnly:is_audio_only_ isRecorder:is_recorder_ isBeauty:is_beauty_];
    [self presentViewController:coreView animated:YES completion:nil];
}

- (void)interRecorderViewBtnPressed:(id)sender {
    RecorderView * recorderView =[[RecorderView alloc] init];
    [self presentViewController:recorderView animated:YES completion:nil];
}

@end
