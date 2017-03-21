//
//  LUserInfoViewController.m
//  littlebubble
//
//  Created by  罗海峰 on 2017/1/10.
//  Copyright © 2017年  罗海峰. All rights reserved.
//

#import "LUserInfoViewController.h"
#import "LUserInfoTableViewCell.h"
#import <ActionSheetDatePicker.h>
#import <TZImagePickerController.h>
//#import "AiImageCollectionViewCell.h"
#import <TZImageManager.h>

@interface LUserInfoViewController ()<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate,UIImagePickerControllerDelegate,TZImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic,strong) NSArray* dataArray;
@property (nonatomic,strong) NSArray* dataArray1;

@end

@implementation LUserInfoViewController{
    UITableView* tab;
    NSArray* imageArray;
}
-(NSArray*)dataArray{
    if (!_dataArray) {
        _dataArray = @[@[@"头像"],@[@"昵称",@"性别",@"生日"]];
    }
    return _dataArray;
}
-(NSArray*)dataArray1{
    if (!_dataArray1) {
        _dataArray1 = @[@[@"QQ20170103-151146.png"],@[@"小水泡",@"女",@"1990-2-2"]];
    }
    return _dataArray1;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人信息";
    [self initUI];
    self.view.backgroundColor = RGB(221, 221, 221);
    // Do any additional setup after loading the view.
}
-(void)initUI{
    tab = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREENH_HEIGHT) style:UITableViewStylePlain];
    tab.delegate = self;
    tab.dataSource = self;
    tab.tableFooterView = [UIView new];
    tab.backgroundColor = self.view.backgroundColor;
    [self.view addSubview: tab];
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString* cellIdentifier = @"cellIdentifier";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        if (indexPath.section == 0) {
            cell = [[LUserInfoTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
            cell.textLabel.text = self.dataArray[indexPath.section][indexPath.row];
            if ([cell respondsToSelector:@selector(initData:)]) {
                [cell performSelector:@selector(initData:) withObject:@{@"userIcon":self.dataArray1[0][0]}];
            }
        }else{
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
            cell.textLabel.text = self.dataArray[indexPath.section][indexPath.row];
            cell.detailTextLabel.text = self.dataArray1[indexPath.section][indexPath.row];
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    if (section == 0 && row ==0) {
        UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                      initWithTitle:@"选择图片"
                                      delegate:self
                                      cancelButtonTitle:@"取消"
                                      destructiveButtonTitle:@"拍照"
                                      otherButtonTitles:@"从相册选取",nil];
        actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
        actionSheet.tag = 1;
        [actionSheet showInView:self.view];
    }else if(indexPath.section == 1 && indexPath.row == 1){
        UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                      initWithTitle:@"选择性别"
                                      delegate:self
                                      cancelButtonTitle:@"取消"
                                      destructiveButtonTitle:@"男"
                                      otherButtonTitles:@"女",nil];
        actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
        actionSheet.tag = 2;
        [actionSheet showInView:self.view];
    }
    else if(indexPath.section == 1 && indexPath.row == 2){
        [ActionSheetDatePicker showPickerWithTitle:nil datePickerMode:UIDatePickerModeDate selectedDate:[NSDate date] doneBlock:^(ActionSheetDatePicker *picker, id selectedDate, id origin) {
            NSDateFormatter* dateFormatter = [[NSDateFormatter alloc]init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
            UITableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
            cell.detailTextLabel.text = [dateFormatter stringFromDate:selectedDate];
           // birthday = cell.infoLab.text;
           // [self Personalbirthday];
        } cancelBlock:^(ActionSheetDatePicker *picker) {
            
        } origin:self.view];
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 60;
    }else{
        return 40;
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else{
        return 3;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return 20;

    }
    return 0;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//拍照
#pragma mark --- UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSUInteger sourceType = 0;
    //判断是否支持相机
    if (actionSheet.tag == 1) {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        if (buttonIndex == 0) {
            //拍照
            sourceType = UIImagePickerControllerSourceTypeCamera;
            //跳转
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];//初始化
            picker.delegate = self;
            picker.allowsEditing = YES;//设置可编辑
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            //进入照相界面
            [self presentViewController:picker animated:YES completion:nil];
        }if (buttonIndex == 1) {
            //相册
            TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];
            imagePickerVc.navigationBar.backgroundColor = [UIColor redColor];
            [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets , BOOL isOriginal) {
                imageArray = [NSArray arrayWithObject:photos];
                LUserInfoTableViewCell* cell = [tab cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0 ]];
                [cell.userIcon setImage:imageArray[0][0]];
                //[self changeIcon];
            }];
            [self presentViewController:imagePickerVc animated:YES completion:nil];
        }
    }else{
        TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];
        imagePickerVc.navigationBar.backgroundColor = [UIColor redColor];
        [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets , BOOL isOriginal) {
            imageArray = [NSArray arrayWithObject:photos];
            LUserInfoTableViewCell* cell = [tab cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0 ]];
            [cell.userIcon setImage:imageArray[0][0]];
            //[self changeIcon];
            
        }];
        [self presentViewController:imagePickerVc animated:YES completion:nil];
    }
        }
    else if (actionSheet.tag == 2){
        UITableViewCell* cell = [tab cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:1]];
        if (buttonIndex == 0){
            cell.detailTextLabel.text = @"男";
        }else{
            cell.detailTextLabel.text = @"女";
        }
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    imageArray = [NSArray arrayWithObject:image];
    //最多添加9张
    LUserInfoTableViewCell* cell = [tab cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0 ]];
    
    [cell.userIcon setImage:imageArray[0]];
    //[self changeIcon];
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
