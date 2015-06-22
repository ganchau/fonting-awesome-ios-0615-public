//
//  ViewController.m
//  FontingAwesome
//
//  Created by Gan Chau on 6/21/15.
//  Copyright (c) 2015 Gantastic App. All rights reserved.
//

#import "ViewController.h"
#import <FontAwesomeKit/FontAwesomeKit.h>
#import "CWStatusBarNotification.h"


@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *tapMeButton;
@property (strong, nonatomic) FAKFontAwesome *starIcon;
@property (strong, nonatomic) CWStatusBarNotification *notification;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *starLabel;
@property (strong, nonatomic) NSArray *awesomeTexts;
@property (nonatomic) NSUInteger awesomeCounter;

@property (nonatomic) CGFloat fontSize;
@property (nonatomic) CGFloat red;
@property (nonatomic) CGFloat green;
@property (nonatomic) CGFloat blue;
@property (nonatomic) CGFloat alpha;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.awesomeTexts = @[@"Everything is awesome",
                          @"Everything is cool when you're part of a team",
                          @"Everything is AWESOME",
                          @"When we're living our dream"];
    self.awesomeCounter = 0;
    
    self.notification = [CWStatusBarNotification new];
    self.notification.notificationLabelBackgroundColor = [UIColor magentaColor];
    self.notification.notificationStyle = CWNotificationStyleNavigationBarNotification;
    [self.notification displayNotificationWithMessage:@"You will see stars" forDuration:1.0];
    
    self.starIcon = [FAKFontAwesome starIconWithSize:45];
    [self.starIcon addAttribute:NSForegroundColorAttributeName value:[UIColor magentaColor]];
    [self.tapMeButton setAttributedTitle:[self.starIcon attributedString] forState:UIControlStateNormal];
}

#define RGB_CONST 1024

- (void)randomizeIt
{
    self.fontSize = arc4random_uniform(80) + 1;   // 1..80
    self.red = arc4random_uniform(RGB_CONST) / (CGFloat)RGB_CONST;    // (float) 0..1
    self.green = arc4random_uniform(RGB_CONST) / (CGFloat)RGB_CONST;  // (float) 0..1
    self.blue = arc4random_uniform(RGB_CONST) / (CGFloat)RGB_CONST;   // (float) 0..1
    self.alpha = arc4random_uniform(RGB_CONST) / (CGFloat)RGB_CONST; // (float) 0..1

    NSLog(@"%f", self.fontSize);
    NSLog(@"%f", self.red);
    NSLog(@"%f", self.green);
    NSLog(@"%f", self.blue);
    NSLog(@"%f", self.alpha);
}

- (void)awesomeizeIt
{
    self.notification.notificationLabelBackgroundColor = [UIColor colorWithRed:self.red
                                                                         green:self.green
                                                                          blue:self.blue
                                                                         alpha:1.0];
    NSString *awesomeMessage = self.awesomeTexts[self.awesomeCounter];
    [self.notification displayNotificationWithMessage:awesomeMessage forDuration:1.0];
    self.awesomeCounter++;
    if (self.awesomeCounter % self.awesomeTexts.count == 0) {
        self.awesomeCounter = 0;
    }
}

- (IBAction)tapMeButtonPressed:(id)sender
{
    [self randomizeIt];
    
    self.starIcon.iconFontSize = self.fontSize;
    [self.starIcon addAttribute:NSForegroundColorAttributeName
                          value:[UIColor colorWithRed:self.red
                                                green:self.green
                                                 blue:self.blue
                                                alpha:self.alpha]];
    
    [self awesomeizeIt];
    [self lightTheStars];
    [self.tapMeButton setAttributedTitle:[self.starIcon attributedString]
                                forState:UIControlStateNormal];
}

- (void)lightTheStars
{
    for (UILabel *star in self.starLabel) {
        [self randomizeIt];

        FAKFontAwesome *starIcon = [FAKFontAwesome starIconWithSize:self.fontSize];
        [starIcon addAttribute:NSForegroundColorAttributeName
                         value:[UIColor colorWithRed:self.red
                                               green:self.green
                                                blue:self.blue
                                               alpha:self.alpha]];
        [star setAttributedText:[starIcon attributedString]];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
