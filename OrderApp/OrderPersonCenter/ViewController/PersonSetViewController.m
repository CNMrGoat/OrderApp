//
//  PersonSetViewController.m
//  OrderApp
//
//  Created by zhangfan on 2019/6/26.
//  Copyright © 2019 豪锅锅. All rights reserved.
//

#import "PersonSetViewController.h"
#import "PersonSetTableViewCell.h"
#import "ChangePasswordViewController.h"
#import "EditInfoViewController.h"
#import "ChangeMobileViewController.h"
#import "QiniuSDK.h"
#import "HMScanner.h"

static NSString *const kTableViewCellIdentifier = @"TableViewCellIdentifier";

@interface PersonSetViewController ()<UITableViewDelegate,UITableViewDataSource, UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property(nonatomic,strong) UITableView *myTableView;
@property(nonatomic,strong) UIView *footView;
@property(nonatomic,strong) NSMutableArray *dataArr;
@property(nonatomic,strong) NSArray *titleArr;

@property(nonatomic,strong) UIImageView *headImgV;

@property (nonatomic, strong) UIImage *pickImage;
@property (nonatomic, strong) NSString  *qiNiuToken;
@property (nonatomic, strong) NSString  *headImgUrl;


@end

@implementation PersonSetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"用户资料";
    [self addView];
    
    self.headImgV = [[UIImageView alloc] initWithFrame:CGRectMake(50, 200, 100, 100)];
    [self.view addSubview:_headImgV];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self requstUserInfo];
}

- (void)requstUserInfo {
    
    
    [NetworkClient RequestWithParameters:nil withUrl:BASE_URLWith(UserInfoHttp) needToken:YES success:^(id responseObject) {
        
        NSLog(@"%@",responseObject);
        NSString  *codeStr = [NSString stringWithFormat:@"%@",responseObject[@"code"]];
        
        if ([@"2000" isEqualToString:codeStr]) {
            [self.dataArr removeAllObjects];
            [self.dataArr addObject:[NSString stringWithFormat:@"%@",responseObject[@"data"][@"headImgUrl"]]];
            [self.dataArr addObject:[NSString stringWithFormat:@"%@",responseObject[@"data"][@"nickName"]]];
            [self.dataArr addObject:@"用于密码登录"];
            [self.dataArr addObject:[NSString maskMobile:[NSString stringWithFormat:@"%@",responseObject[@"data"][@"mobile"]]]];
            [self.dataArr addObject:[NSString stringWithFormat:@"%@",responseObject[@"data"][@"signature"]]];
            MyUser.wallet = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"wallet"]];
            
            [self.myTableView reloadData];
        } else {
            [self showHint:responseObject[@"msg"]];
        }
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
}

- (void)addView {
    
    if (@available(iOS 11.0, *)) {
        self.myTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
        // Fallback on earlier versions
    }
    [self.view addSubview:self.myTableView];
    [self.view addSubview:self.footView];
}

#pragma mark -
#pragma mark getter
- (UIView *)footView
{
    if (!_footView)
    {
        _footView = [[UIView alloc]initWithFrame:CGRectMake(0,SafeAreaTopHeight+270, SCREEN_WIDTH, SCREEN_HEIGHT- SafeAreaTopHeight-270)];
        _footView.backgroundColor = [UIColor clearColor];

        
        NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
        [parameter setObject:MyUser.uid forKey:@"UserId"];
        NSString *uidStr = [NSString convertToJsonData:parameter];
        
        UIImageView *QRImgView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 -70,10, 140, 140)];
        [HMScanner qrImageWithString:uidStr avatar:[UIImage imageNamed:@"加餐啦LOGO"] completion:^(UIImage *image) {
            QRImgView.image = image;
            
        }];
        
        [_footView addSubview:QRImgView];


        UILabel *labelup = [[UILabel alloc]initWithFrame:CGRectMake(0,160, SCREEN_WIDTH, 10)];
        labelup.font = Demon_15_Font;
        labelup.textColor = CS_Color_MidGray;
        labelup.text = @"我的二维码";
        labelup.textAlignment = NSTextAlignmentCenter;
        [_footView addSubview:labelup];

        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, _footView.height-SafeAreaBottomHeight, SCREEN_WIDTH, 49)];
        btn.backgroundColor = [UIColor whiteColor];
        [btn setTitle:@"退出登录" forState:UIControlStateNormal];
        [btn setTitleColor:CS_Color_BackZhuti forState:UIControlStateNormal];
        btn.titleLabel.font = Demon_17_MediumFont;
        [btn addTarget:self action:@selector(logOutBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        [_footView addSubview:btn];

    }
    return _footView;
}

-(UITableView *)myTableView
{
    if (_myTableView == nil)
    {
        _myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0,SafeAreaTopHeight+10,SCREEN_WIDTH, 250) style:UITableViewStylePlain];
        [_myTableView setDataSource:self];
        [_myTableView setDelegate:self];
        [_myTableView setSeparatorColor:[UIColor clearColor]];
        [_myTableView setSeparatorColor:[UIColor redColor]];
        _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _myTableView.showsHorizontalScrollIndicator = NO;
        _myTableView.showsVerticalScrollIndicator = NO;
        _myTableView.scrollEnabled = NO;
        [_myTableView registerClass:[PersonSetTableViewCell class] forCellReuseIdentifier:kTableViewCellIdentifier];
    }
    return _myTableView;
}

- (NSArray *)dataArr
{
    if (!_dataArr)
    {
        _dataArr = [NSMutableArray arrayWithObjects:@"",@"去取名",@"用于密码登录",@"去绑定",@"去签名", nil];
    }
    return _dataArr;
}

- (NSArray *)titleArr
{
    if (!_titleArr)
    {
        _titleArr = @[@"头像",@"名称",@"修改密码",@"电话号码",@"签名"];
    }
    return _titleArr;
}

- (void)logOutBtnClicked {
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:MyUser.token forKey:@"token"];
    
    NSLog(@"~~~~~~~~~~%@",MyUser.token);
    
    [NetworkClient RequestWithParameters:nil withUrl:BASE_URLWith(MemLayoutHttp) needToken:YES success:^(id responseObject) {
        
        NSLog(@"%@",responseObject);
        NSString *codeStr = [NSString stringWithFormat:@"%@",responseObject[@"code"]];
        if ([@"2000" isEqualToString:codeStr]) {
            NSLog(@"登chu成功");
            [MyDefaults removeObjectForKey:@"comInfoMobile"];
            [MyDefaults removeObjectForKey:@"comInfoName"];
            [MyDefaults removeObjectForKey:@"comInfoUid"];
            [MyDefaults removeObjectForKey:@"ctime"];
            [MyDefaults removeObjectForKey:@"headImgUrl"];
            [MyDefaults removeObjectForKey:@"mobile"];
            [MyDefaults removeObjectForKey:@"nickName"];
            [MyDefaults removeObjectForKey:@"openid"];
            [MyDefaults removeObjectForKey:@"signature"];
            [MyDefaults removeObjectForKey:@"token"];
            [MyDefaults removeObjectForKey:@"uid"];
            [MyDefaults removeObjectForKey:@"wallet"];
            
            [self.navigationController popViewControllerAnimated:YES];
            
            
        } else {
            [self showHint:responseObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        
    }];
    
}


#pragma mark -
#pragma mark UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titleArr.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    PersonSetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kTableViewCellIdentifier];
    cell.textLabel.text = self.titleArr[indexPath.row];
    cell.tilLabel.textColor = CS_Color_DeepGray;
    cell.tilLabel.text = self.dataArr[indexPath.row];
    
    if (indexPath.row == 0)
    {
        [cell.headImgV sd_setImageWithURL:self.dataArr[0] placeholderImage:[UIImage imageNamed:@"touxiang"]];
        cell.headImgV.hidden = NO;
        cell.tilLabel.hidden = YES;
        [cell setDemonSeparatorStyle:DemonTableViewCellSeparatorFull];
    }
    else
    {
        [cell setDemonSeparatorStyle:DemonTableViewCellSeparatorLeft];
        cell.headImgV.hidden = YES;
        cell.tilLabel.hidden = NO;
    }
    
    return cell;
}

#pragma mark -
#pragma mark UITableViewDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 2) {
        
        ChangePasswordViewController *vc = [ChangePasswordViewController new];
        [self.navigationController pushViewController:vc animated:YES pushType:NavigationPushNormal];
        
    } else if (indexPath.row == 4) {
        
        EditInfoViewController *vc = [EditInfoViewController new];
        vc.title = @"签名编辑";
        [self.navigationController pushViewController:vc animated:YES pushType:NavigationPushNormal];
        
    } else if (indexPath.row == 1) {
        
        EditInfoViewController *vc = [EditInfoViewController new];
        vc.title = @"名称编辑";
        [self.navigationController pushViewController:vc animated:YES pushType:NavigationPushNormal];
        
    } else if (indexPath.row == 3) {
        
        NSString *str = [NSString stringWithFormat:@"%@",self.dataArr[indexPath.row]];
        if (str.length > 4) {
            ChangeMobileViewController *vc = [ChangeMobileViewController new];
            vc.title = @"换绑手机";
            [self.navigationController pushViewController:vc animated:YES pushType:NavigationPushNormal];
        } else {
            ChangeMobileViewController *vc = [ChangeMobileViewController new];
            vc.title = @"修改号码";
            [self.navigationController pushViewController:vc animated:YES pushType:NavigationPushNormal];
        }
    
    } else {
        
        UIAlertController *test = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            [test addAction:[UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self choseImageWithType:2];
            }]];
        }
        
        [test addAction:[UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self choseImageWithType:1];
        }]];
        

        [test addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        [self presentViewController:test animated:YES completion:nil];
    }

}

- (void)choseImageWithType:(NSInteger)index{
    NSUInteger sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    switch (index) {
        case 1:
            //来源:相册
            sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            break;
        case 2:
            sourceType = UIImagePickerControllerSourceTypeCamera;
            break;
        default:
            break;
    }
    // 跳转到相机或相册页面
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    imagePickerController.allowsEditing = NO;
    imagePickerController.sourceType = sourceType;
    [self presentViewController:imagePickerController animated:YES completion:^{
    }];
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage *resultImage = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    self.pickImage = resultImage;
    [self requstQNToken];
    

}

- (void)requstQNToken {
    
    [NetworkClient RequestWithParameters:nil withUrl:BASE_URLWith(QntokenHttp) needToken:NO success:^(id responseObject) {
        
        NSLog(@"%@",responseObject);
        NSString  *codeStr = [NSString stringWithFormat:@"%@",responseObject[@"code"]];
        
        if ([@"2000" isEqualToString:codeStr]) {
            
            self.qiNiuToken = [NSString stringWithFormat:@"%@",responseObject[@"data"]];
            [self upLoadImageToQN];

        } else {
            [self showHint:responseObject[@"msg"]];
        }
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (void)upLoadImageToQN {

    if (self.pickImage == nil) {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"还未选择图片"
                              message:@""
                              delegate:nil
                              cancelButtonTitle:@"OK!"
                              otherButtonTitles:nil];
        [alert show];
    } else {
        [self uploadImageToQNFilePath:[self getImagePath:self.pickImage]];

    }

}

//照片获取本地路径转换
- (NSString *)getImagePath:(UIImage *)Image {
    NSString *filePath = nil;
    NSData *data = nil;
//    if (UIImagePNGRepresentation(Image) == nil) {
        data = UIImageJPEGRepresentation(Image, 0.5);
//    } else {
//        data = UIImagePNGRepresentation(Image);
//    }
    
    //图片保存的路径
    //这里将图片放在沙盒的documents文件夹中
    NSString *DocumentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    
    //文件管理器
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    //把刚刚图片转换的data对象拷贝至沙盒中
    [fileManager createDirectoryAtPath:DocumentsPath withIntermediateDirectories:YES attributes:nil error:nil];
    NSString *ImagePath = [[NSString alloc] initWithFormat:@"/theFirstImage.png"];
    [fileManager createFileAtPath:[DocumentsPath stringByAppendingString:ImagePath] contents:data attributes:nil];
    
    //得到选择后沙盒中图片的完整路径
    filePath = [[NSString alloc] initWithFormat:@"%@%@", DocumentsPath, ImagePath];
    return filePath;
}

- (void)uploadImageToQNFilePath:(NSString *)filePath {
    [self showLoadingWithMessage:@""];
    QNUploadManager *upManager = [[QNUploadManager alloc] init];
    QNUploadOption *uploadOption = [[QNUploadOption alloc] initWithMime:nil progressHandler:^(NSString *key, float percent) {
        NSLog(@"percent == %.2f", percent);
    }
                                                                 params:nil
                                                               checkCrc:NO
                                                     cancellationSignal:nil];
    [upManager putFile:filePath key:nil token:self.qiNiuToken complete:^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
        NSLog(@"info ===== %@", info);
        NSLog(@"resp ===== %@", resp);
        self.headImgUrl = [NSString stringWithFormat:@"http://qiniuzhaodian.csjiayu.com/%@",resp[@"hash"]];
        [self changeHeadImg];
    }
                option:uploadOption];
}

- (void)changeHeadImg {
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    [parameters setObject:@"headImgUrl" forKey:@"filedName"];

    [parameters setObject:self.headImgUrl forKey:@"filedValue"];
    
    [NetworkClient RequestWithParameters:parameters withUrl:BASE_URLWith(EditUserInfoHttp) needToken:YES success:^(id responseObject) {
        [self hideHud];
        NSLog(@"%@",responseObject);
        NSString  *codeStr = [NSString stringWithFormat:@"%@",responseObject[@"code"]];
        
        if ([@"2000" isEqualToString:codeStr]) {
            [self requstUserInfo];
            MyUser.headImgUrl = self.headImgUrl;
            [self showHint:responseObject[@"msg"]];
    
        }
        
    } failure:^(NSError *error) {
        
        [self hideHud];
        NSLog(@"%@",error);
    }];
    

    
}



@end
