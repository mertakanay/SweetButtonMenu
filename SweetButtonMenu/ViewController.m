//
//  ViewController.m
//  SweetButtonMenu
//
//  Created by Mert Akanay on 19.03.2015.
//  Copyright (c) 2015 MobileMakers. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property UIButton *mainButton;
@property UIButton *menuButton1;
@property UIButton *menuButton2;
@property UIButton *menuButton3;

@property UIDynamicAnimator *dynamicAnimator;

@property BOOL isFannedOut;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //order matters
    self.menuButton1 = [self createButtonWithTitle:@"1"];
    self.menuButton2 = [self createButtonWithTitle:@"2"];
    self.menuButton3 = [self createButtonWithTitle:@"3"];
    self.mainButton = [self createButtonWithTitle:@"P"];

    //we add dynamic animator to be able to pop the buttons
    self.dynamicAnimator = [[UIDynamicAnimator alloc]initWithReferenceView:self.view];

    //and here goes the code for popping the buttons
    [self.mainButton addTarget:self action:@selector(fanButtons:) forControlEvents:UIControlEventTouchUpInside];

}

-(void)fanButtons:(id)sender
{

// snap to point goes to center of object.

    [self.dynamicAnimator removeAllBehaviors];
    if (!self.isFannedOut) {
        [self fanButtonsOut];
    }
    else
    {
        [self snapButton:self.menuButton1 toPoint:self.mainButton.center];

        [self snapButton:self.menuButton2 toPoint:self.mainButton.center];

        [self snapButton:self.menuButton3 toPoint:self.mainButton.center];
    }
    self.isFannedOut = !self.isFannedOut;

// We simplified the below code to above code by using snapButton helper method.

//    CGPoint point;
//    UISnapBehavior *snapBehaviour;
//
//    point = CGPointMake(self.mainButton.frame.origin.x - 50.0, self.mainButton.frame.origin.y + 20.0);
//    snapBehaviour = [[UISnapBehavior alloc]initWithItem:self.menuButton1 snapToPoint:point];
//    [self.dynamicAnimator addBehavior:snapBehaviour];
}

-(void)fanButtonsOut
{
    [self snapButton:self.menuButton1 toPoint:CGPointMake(self.mainButton.frame.origin.x - 50.0, self.mainButton.frame.origin.y + 20.0)];

    [self snapButton:self.menuButton2 toPoint:CGPointMake(self.mainButton.frame.origin.x - 45.0, self.mainButton.frame.origin.y - 45.0)];

    [self snapButton:self.menuButton3 toPoint:CGPointMake(self.mainButton.frame.origin.x + 20.0, self.mainButton.frame.origin.y - 50.0)];
}

-(void)snapButton:(UIButton *)button toPoint:(CGPoint)point
{
    UISnapBehavior *snapBehaviour = [[UISnapBehavior alloc]initWithItem:button snapToPoint:point];
    [self.dynamicAnimator addBehavior:snapBehaviour];
}

-(UIButton *)createButtonWithTitle:(NSString *)title
{
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width-50.0, self.view.frame.size.height-50.0, 50.0, 50.0)];
    button.backgroundColor = [UIColor whiteColor];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    button.layer.borderColor = button.titleLabel.textColor.CGColor;
    //border color is CGColor because layer is a core graphic (CG) to the button

    button.layer.borderWidth = 1.0;
    button.layer.cornerRadius = button.frame.size.width/2;

    [self.view addSubview:button];
    //we need to addSubview for button to show when we run the app
    return button;
}

@end
