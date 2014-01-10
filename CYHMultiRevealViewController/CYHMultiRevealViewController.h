//
//  CYHMultiRevealViewController.h
//  CYHMultiRevealViewController
//
//  Created by Yuhua Chen on 2014/1/10.
//  Copyright (c) 2014年 Yuhua Chen All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, CYHRevealDirection)
{
    CYHRevealDirectionLeft,
    CYHRevealDirectionRight,
    CYHRevealDirectionTop,
    CYHRevealDirectionBottom
};

typedef struct{
    CGFloat min;
    CGFloat max;
} CYHRevealControllerBounds;


@interface CYHMultiRevealViewController : UIViewController <UIGestureRecognizerDelegate>

@property (nonatomic, assign) NSUInteger direction;
@property (nonatomic, readonly) NSUInteger currentViewIndex;
@property (nonatomic, assign) BOOL isShowModal;
@property (nonatomic, assign) BOOL isShowShadow;
@property (nonatomic, assign) float paddingEdge;
@property (nonatomic, assign) CYHRevealControllerBounds controllerBounds;

#pragma mark - init

- (instancetype) initWithView:(UIView *)view andViewControllers:(NSArray *)viewControllers;

#pragma mark - Method

- (void)push;
- (void)pop;
- (void)dismiss;
- (void)pushViewController:(UIViewController *)viewController;

@end
