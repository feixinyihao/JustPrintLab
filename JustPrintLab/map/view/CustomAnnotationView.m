//
//  CustomAnnotationView.m
//  CustomAnnotationDemo
//
//  Created by songjian on 13-3-11.
//  Copyright (c) 2013年 songjian. All rights reserved.
//

#import "CustomAnnotationView.h"
#import "CustomCalloutView.h"

#define kWidth  35.f
#define kHeight 42.f

#define kHoriMargin 0.f
#define kVertMargin 0.f

#define kPortraitWidth  32.5
#define kPortraitHeight 38

#define kCalloutWidth   200.0
#define kCalloutHeight  50.0

@interface CustomAnnotationView ()

@property (nonatomic, strong) UIImageView *portraitImageView;
@property (nonatomic, strong) UILabel *nameLabel;

@end

@implementation CustomAnnotationView

@synthesize calloutView;
@synthesize portraitImageView   = _portraitImageView;
@synthesize nameLabel           = _nameLabel;

#pragma mark - Handle Action

- (void)btnAction
{
    CLLocationCoordinate2D coorinate = [self.annotation coordinate];
    
    NSLog(@"coordinate = {%f, %f}", coorinate.latitude, coorinate.longitude);
}

#pragma mark - Override

- (NSString *)name
{
    return self.nameLabel.text;
}

- (void)setName:(NSString *)name
{
    self.nameLabel.text = name;
}

- (UIImage *)portrait
{
    return self.portraitImageView.image;
}

- (void)setPortrait:(UIImage *)portrait
{
    self.portraitImageView.image = portrait;
}

- (void)setSelected:(BOOL)selected
{
    [self setSelected:selected animated:NO];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    if (self.selected == selected)
    {
        return;
    }
    
    if (selected)
    {
        
        if (self.calloutView == nil)
        {
           // self.calloutView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
           // self.calloutView.backgroundColor=[UIColor whiteColor];
            
//            /* Construct custom callout. */
//            
//            self.calloutView = [[CustomCalloutView alloc] initWithFrame:CGRectMake(0, 0, kCalloutWidth, kCalloutHeight)];
//            self.calloutView.center = CGPointMake(CGRectGetWidth(self.bounds) / 2.f + self.calloutOffset.x,
//                                                  -CGRectGetHeight(self.calloutView.bounds) / 2.f + self.calloutOffset.y);
//            UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//            btn.frame = CGRectMake(10, 10, 18, 20);
//            [btn setImage:[UIImage imageNamed:@"home_canPrint"] forState:UIControlStateNormal];
//            //[btn setTitle:@"justprint" forState:UIControlStateNormal];
//            [btn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
//            [btn setBackgroundColor:[UIColor whiteColor]];
//            [btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
//            
//            [self.calloutView addSubview:btn];
//            
//            UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(35, 10, 160, 20)];
//            name.font=[UIFont systemFontOfSize:12];
//            name.backgroundColor = [UIColor clearColor];
//            name.textColor = [UIColor whiteColor];
//            name.text =self.name;
//            [self.calloutView addSubview:name];
        }
        
       // [self addSubview:self.calloutView];
    }
    else
    {
        [self.calloutView removeFromSuperview];
    }
    
    [super setSelected:selected animated:animated];
}


- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    BOOL inside = [super pointInside:point withEvent:event];
    /* Points that lie outside the receiver’s bounds are never reported as hits,
     even if they actually lie within one of the receiver’s subviews.
     This can occur if the current view’s clipsToBounds property is set to NO and the affected subview extends beyond the view’s bounds.
     */
    if (!inside && self.selected)
    {
        inside = [self.calloutView pointInside:[self convertPoint:point toView:self.calloutView] withEvent:event];
    }
    
    return inside;
}

#pragma mark - Life Cycle

- (id)initWithAnnotation:(id<MAAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        self.bounds = CGRectMake(0.f, 0.f, kWidth, kHeight);
        
        //self.backgroundColor = [UIColor grayColor];
        
        /* Create portrait image view and add to view hierarchy. */
        self.portraitImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kHoriMargin, kVertMargin, kPortraitWidth, kPortraitHeight)];
        [self addSubview:self.portraitImageView];
        
        /* Create name label. */
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(kPortraitWidth + kHoriMargin,
                                                                   kVertMargin,
                                                                   kWidth - kPortraitWidth - kHoriMargin,
                                                                   kHeight - 2 * kVertMargin)];
        self.nameLabel.backgroundColor  = [UIColor clearColor];
        self.nameLabel.textAlignment    = NSTextAlignmentCenter;
        self.nameLabel.textColor        = [UIColor whiteColor];
        self.nameLabel.font             = [UIFont systemFontOfSize:15.f];
        [self addSubview:self.nameLabel];
    }
    
    return self;
}

@end
