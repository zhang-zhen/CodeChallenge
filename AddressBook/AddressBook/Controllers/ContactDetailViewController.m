//
//  ContactDetailViewController.m
//  AddressBook
//
//  Created by Zhen Zhang on 2016-04-27.
//  Copyright © 2016 Zhang Zhen. All rights reserved.
//

#import "ContactDetailViewController.h"

@interface ContactDetailViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *cellLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;
@property (weak, nonatomic) IBOutlet UILabel *streetLabel;
@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
@property (weak, nonatomic) IBOutlet UILabel *stateLabel;
@property (weak, nonatomic) IBOutlet UILabel *postcodeLabel;
@property (weak, nonatomic) IBOutlet UILabel *natLabel;

@property BOOL isFullScreen;
@property CGRect avatarFrame;

@end

@implementation ContactDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.imageView.layer.masksToBounds = YES;
    self.imageView.layer.cornerRadius = _imageView.frame.size.width/2;
    [[self.imageView layer] setBorderColor:[UIColor grayColor].CGColor];
    [[self.imageView layer] setBorderWidth:1.0f];

    self.imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_person.picSmallURL]]];
    self.nameLabel.text = [NSString stringWithFormat:@"%@ %@", _person.firstName, _person.lastName];
    self.phoneLabel.text = _person.phone;
    self.cellLabel.text = _person.cell;
    self.emailLabel.text = _person.email;
    self.streetLabel.text = _person.street;
    self.cityLabel.text = _person.city;
    self.stateLabel.text = _person.state;
    self.postcodeLabel.text = _person.postcode;
    self.natLabel.text = _person.nat;
    
    self.avatarFrame = _imageView.frame;
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(photoTap)];
    [self.imageView setUserInteractionEnabled:YES];
    [self.imageView addGestureRecognizer:tapGestureRecognizer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/* Tap the head image view, then it shows the image which is got form large pic url in the full screen.
 */
- (void)photoTap
{
    UIImage *image=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_person.picLargeURL]]];
    UIWindow *window=[UIApplication sharedApplication].keyWindow;
    UIView *backgroundView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    self.avatarFrame=[_imageView convertRect:_imageView.bounds toView:window];
    backgroundView.backgroundColor=[UIColor blackColor];
    backgroundView.alpha=0;
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:_avatarFrame];
    imageView.image=image;
    imageView.tag=1;
    [backgroundView addSubview:imageView];
    [window addSubview:backgroundView];
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideImage:)];
    [backgroundView addGestureRecognizer: tap];
    
    [UIView animateWithDuration:0.3 animations:^{
        imageView.frame=CGRectMake(0,([UIScreen mainScreen].bounds.size.height-image.size.height*[UIScreen mainScreen].bounds.size.width/image.size.width)/2, [UIScreen mainScreen].bounds.size.width, image.size.height*[UIScreen mainScreen].bounds.size.width/image.size.width);
        backgroundView.alpha=1;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)hideImage:(UITapGestureRecognizer*)tap{
    
    UIView *backgroundView=tap.view;
    UIImageView *imageView=(UIImageView*)[tap.view viewWithTag:1];
    [UIView animateWithDuration:0.3 animations:^{
        imageView.frame=_avatarFrame;
        backgroundView.alpha=0;
    } completion:^(BOOL finished) {
        [backgroundView removeFromSuperview];
    }];
}

@end
