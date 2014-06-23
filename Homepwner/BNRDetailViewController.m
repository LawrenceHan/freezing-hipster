//
//  BNRDetailViewController.m
//  Homepwner
//
//  Created by Hanguang on 14-5-27.
//  Copyright (c) 2014年 Big Nerd Ranch. All rights reserved.
//

#import "BNRDetailViewController.h"
#import "BNRItem.h"
#import "BNRDateViewController.h"
#import "BNRImageStore.h"
#import "BNRItemStore.h"

@interface BNRDetailViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *serialField;
@property (weak, nonatomic) IBOutlet UITextField *valueField;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;


- (IBAction)changeDateBt:(id)sender;

@end

@implementation BNRDetailViewController


#pragma mark - Action 按钮
- (IBAction)takePicture:(id)sender {
    // 加载图片到imageView需要一个控制器来抓取图片并放到它上面
    // 生成UIImagePickerController来处理图片
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    
    // 设置可编辑模式
    imagePicker.allowsEditing = YES;
    
    // If the device has an camera, take a picture, otherwise, just pick from library
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        // 判断是否支持录像，并赋值给mediatype
        NSArray *avaliableTypes = [UIImagePickerController availableMediaTypesForSourceType:
                                   UIImagePickerControllerSourceTypeCamera];
        imagePicker.mediaTypes = avaliableTypes;
    }
    else {
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    
    
    imagePicker.delegate = self;
    
    // Place image picker on the screen
    [self presentViewController:imagePicker animated:YES completion:nil];
    
    
}

// 删除item图片
- (IBAction)deleteImage:(id)sender {
    // 从imageStore里删除图片
    [[BNRImageStore sharedStore] deleteImageForKey:self.item.itemKey];
    // 设置imageView的图片为空
    self.imageView.image = nil;
}

// 当背景view被点击时，关闭键盘
- (IBAction)backgroundTapped:(id)sender {
    [self.view endEditing:YES];
}

// 修改时间按钮事件
- (IBAction)changeDateBt:(id)sender {
    BNRDateViewController *dateViewController = [[BNRDateViewController alloc] init];
    // 传递NSDate参数
    dateViewController.item = _item;
    [self.navigationController pushViewController:dateViewController animated:YES];
    
    
}

- (void)save:(id)sender
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:self.dismissBlock];
}

- (void)cancel:(id)sender
{
    // If the user cancelled, then remove the BNRItem from the store
    [[BNRItemStore sharedStore] removeItem:self.item];
    
    [self.presentingViewController dismissViewControllerAnimated:YES completion:self.dismissBlock];
}

#pragma mark - delegate 回调

// 选择好媒体后的回调，这个是选择成功，另一个是选择取消
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    // Get picked image from info dictionary
    UIImage *image = info[UIImagePickerControllerEditedImage];
    if (image) {
        // Store the image in the BNRImageStore for this key
        [[BNRImageStore sharedStore] setImage:image forKey:self.item.itemKey];
        
        // Put that image into the screen on our image view
        self.imageView.image = image;
        
        // Take image picker off the screen - you must call this dismiss method
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    // 如果传回来的是video
    NSURL *mediaURL = info[UIImagePickerControllerMediaURL];
    if (mediaURL) {
        // Make sure this device supports videos in its photo album
        if (UIVideoAtPathIsCompatibleWithSavedPhotosAlbum([mediaURL path])) {
            
            // Save the video to the photos album
            UISaveVideoAtPathToSavedPhotosAlbum([mediaURL path], nil, nil, nil);
            
            // Remove the video from temporary directory
            [[NSFileManager defaultManager] removeItemAtPath:[mediaURL path] error:nil];
        }
    }
}
// 当按return键时，关闭键盘
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}



// Override synthesized 的 set方法 这样赋值时顺便改写navTitle
- (void)setItem:(BNRItem *)item
{
    _item = item;
    self.navigationItem.title = _item.itemName;
}

#pragma mark - view life cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    UIImageView *iv = [[UIImageView alloc] initWithImage:nil];
//    
//    // The contentMode of the image view in the XIB was Aspect Fit:
//    iv.contentMode = UIViewContentModeScaleAspectFit;
//    
//    // Do not produce a translate constraint for this view
//    iv.translatesAutoresizingMaskIntoConstraints = NO;
//    
//    // The image view was a subview of the view
//    [self.view addSubview:iv];
//    
//    // The image view was pointed to by the imageView property
//    self.imageView = iv;
//    
//    // Set the vertical priorities to be less than
//    // those of the other subviews
//    [self.imageView setContentHuggingPriority:200 forAxis:UILayoutConstraintAxisVertical];
//    [self.imageView setContentCompressionResistancePriority:700 forAxis:UILayoutConstraintAxisVertical];
//    
//    
//    
//    NSDictionary *nameMap = @{@"imageView"  : self.imageView,
//                              @"dateLabel"  : self.dateLabel,
//                              @"toolBar"    : self.toolbar};
//    // imageView is 0 point from superview at left and right edges
//    NSArray *horizontalConstraints =
//    [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[imageView]-0-|"
//                                            options:0
//                                            metrics:nil
//                                              views:nameMap];
//    // imageView is 8 point from datelabel at its top edge
//    // and 8 point from tool bar at its bottom edge
//    NSArray *verticalConstraints =
//    [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[dateLabel]-[imageView]-[toolBar]"
//                                            options:0
//                                            metrics:nil
//                                              views:nameMap];
//    
    
//    [self.view addConstraints:horizontalConstraints];
//    [self.view addConstraints:verticalConstraints];
    
    // 生成触摸识别
//    UITapGestureRecognizer *tapScreen = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
//    [self.view addGestureRecognizer:tapScreen];
//    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    BNRItem *item = _item;
    self.nameField.text = item.itemName;
    self.serialField.text = item.serialNumber;
    self.valueField.text = [NSString stringWithFormat:@"%d",item.valueInDollars];
    self.valueField.keyboardType = UIKeyboardTypeNumberPad;
    
    // 测试_naming是否能正确赋值
    NSLog(@"name %@, serial %@, value %@", self.nameField.text, self.serialField.text, self.valueField.text);
    
    // You need an NSDateFormatter that will turn  a date into a simple date string
    static NSDateFormatter *dateFormatter = nil;
    if (!dateFormatter) {
        dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateStyle = NSDateFormatterMediumStyle;
        dateFormatter.timeStyle = NSDateFormatterNoStyle;
    }
    
    // Use filtered NSDate object to set dateLabel contents
    self.dateLabel.text = [dateFormatter stringFromDate:_item.dateCreated];
    NSLog(@"date %@",_item.dateCreated);
    NSLog(@"date label %@",self.dateLabel.text);
    
    // 设置载入item对应的图片
    NSString *imageKey = _item.itemKey;
    
    // Get the image for its image key from the image store
    UIImage *imageToDisplay = [[BNRImageStore sharedStore] imageForKey:imageKey];
    
    // Use that image to put on the screen in the imageView
    self.imageView.image = imageToDisplay;
    
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    // Clear the first responder
    [self.view endEditing:YES];
    
    // "Save" changes to item
    BNRItem *item = _item;
    item.itemName = self.nameField.text;
    item.serialNumber = self.serialField.text;
    item.valueInDollars = [self.valueField.text intValue];
    
    
}

#pragma mark - init method
- (instancetype)initForNewItem:(BOOL)isNew
{
    self = [super initWithNibName:nil bundle:nil];
    
    if (self) {
        if (isNew) {
            UIBarButtonItem *doneItem = [[UIBarButtonItem alloc]
                                         initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                         target:self
                                         action:@selector(save:)];
            self.navigationItem.rightBarButtonItem = doneItem;
            
            UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc]
                                           initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                           target:self
                                           action:@selector(cancel:)];
            self.navigationItem.leftBarButtonItem = cancelItem;
        }
    }
    return self;
}

// Call default init will throw an NSException
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    @throw [NSException exceptionWithName:@"Wrong initializer"
                                   reason:@"Use initForNewItem:"
                                 userInfo:nil];
    return nil;
}

#pragma mark - Annotation 注释
// 当触摸屏幕时 判断是否有输入框，如果是，谁是firstresponder 然后resign
//- (void)dismissKeyboard
//{
//    NSArray *subviews = [self.view subviews];
//    for (id objInput in subviews){
//        if ([objInput isKindOfClass:[UITextField class]]) {
//            UITextField *currentTextField = objInput;
//            if ([currentTextField isFirstResponder]) {
//                [currentTextField resignFirstResponder];
//            }
//        }
//    }
//}
// 当一个或多个手指触摸view或者windows时，关闭键盘
//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    [[self view] endEditing:YES];
//
//}

#pragma mark - testing code

@end
