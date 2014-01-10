//
//  CYHMultiRevealViewController.m
//  CYHMultiRevealViewController
//
//  Created by Yuhua Chen on 2014/1/10.
//  Copyright (c) 2014年 Yuhua Chen All rights reserved.
//

#import "CYHMultiRevealViewController.h"

#define kAnimationDuration  0.3f

#define ShowRect(name,rect) NSLog(@"%@:{ %f,%f,%f,%f }", name ,rect.origin.x, rect.origin.y, rect.size.width, rect.size.height)

CYHRevealControllerBounds CYHRevealControllerBoundsMake(CGFloat min, CGFloat max)
{
    CYHRevealControllerBounds bounds;
    bounds.min = min;
    bounds.max = max;
    
    return bounds;
}

@interface CYHMultiRevealViewController ()
@property (nonatomic,strong) NSMutableArray *viewControllers;
@property (nonatomic,assign) NSInteger index;
@property (nonatomic,assign) BOOL isAnimate;
@end

@implementation CYHMultiRevealViewController
- (instancetype) initWithView:(UIView *)view andViewControllers:(NSArray *)viewControllers
{
    if( self = [super init] ){
        
        self.viewControllers = [NSMutableArray arrayWithArray:viewControllers];
        self.direction = CYHRevealDirectionLeft;
        self.paddingEdge = 4.0f;
        self.controllerBounds = CYHRevealControllerBoundsMake(20, 280);
        self.isAnimate = NO;
        
        [view addSubview:self.view];
        
        [self setup];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private
- (void)setup
{
    //init self view
    self.view.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.2f];
    [self updateViewPosition];
    
    self.index = -1;
    
    //setup view controllers
    if( self.viewControllers.count > 0 ){
        
        int i = 0;
        for( UIViewController *viewController in self.viewControllers )
        {
            viewController.view.frame = [self getOriginalFrameWithView:self.view WithIndex:i];
            [self.view addSubview:viewController.view];
            i++;
        }

    }
    
    //add gesture
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
    tapGesture.numberOfTapsRequired = 1;
    tapGesture.delegate = self;
    tapGesture.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGesture];
    
}

- (CGRect)getOriginalFrameWithView:(UIView *)view WithIndex:(NSUInteger)index
{
    CGRect frame = view.bounds;
    
    switch (self.direction) {
        case CYHRevealDirectionRight:
            frame.origin.x += frame.size.width;
            frame.size.width = self.controllerBounds.max - self.paddingEdge*index;
            break;
        case CYHRevealDirectionTop:
            frame.size.height = self.controllerBounds.max - self.paddingEdge*index;
            frame.origin.y -= frame.size.height;
            break;
        case CYHRevealDirectionBottom:
            frame.origin.y += frame.size.height;
            frame.size.height = self.controllerBounds.max - self.paddingEdge*index;
            break;
        default:
            frame.size.width = self.controllerBounds.max - self.paddingEdge*index;
            frame.origin.x -= frame.size.width;
            
            break;
    }
    return frame;
}


- (void)updateViewPosition
{
    CGRect frame = self.view.frame;
    frame.origin = CGPointZero;
    
    switch (self.direction) {
        case CYHRevealDirectionRight:
            frame.origin.x += frame.size.width;
            break;
        case CYHRevealDirectionTop:
            frame.origin.y -= frame.size.height;
            break;
        case CYHRevealDirectionBottom:
            frame.origin.y += frame.size.height;
            break;
        default:
            frame.origin.x -= frame.size.width;
            break;
    }
    
    self.view.frame = frame;
}

- (CGRect)getRevelFrameWithView:(UIView *)view AndReverse:(BOOL)reverse
{
    CGRect frame = view.frame;
    float r = reverse ? -1:1;
    
    switch (self.direction) {
        case CYHRevealDirectionRight:
            frame.origin.x -= view.frame.size.width * r;
            break;
        case CYHRevealDirectionTop:
            frame.origin.y += view.frame.size.height * r;
            break;
        case CYHRevealDirectionBottom:
            frame.origin.y -= view.frame.size.height * r;
            break;
        default:
            frame.origin.x += view.frame.size.width * r ;
            break;
    }
    
    return frame;
}

- (void)reset
{
    [self.view.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self setup];
}

#pragma mark - Method
- (void)push
{
    if( self.index+1 == self.viewControllers.count || self.isAnimate)
        return;
    
    //push self view on first time
    if( -1 == self.index ) {
        self.view.frame = [self getRevelFrameWithView:self.view AndReverse:NO];
        self.view.layer.opacity = 0.0f;
    }
    
    self.isAnimate = YES;
    [UIView animateKeyframesWithDuration:kAnimationDuration
                                   delay:0.0f
                                 options:UIViewKeyframeAnimationOptionCalculationModeLinear
                              animations:^{
                                  
                                  self.view.layer.opacity = 1.0f;
                                  
                                  UIViewController *viewController = [self.viewControllers objectAtIndex:self.index+1];
                                  viewController.view.frame = [self getRevelFrameWithView:viewController.view AndReverse:NO];

                              }
                              completion:^(BOOL finished) {
                                  self.index ++;
                                  self.isAnimate = NO;
                              }];
}

- (void)pop
{
    if( self.isAnimate )
        return;
    
    self.isAnimate = YES;
    [UIView animateKeyframesWithDuration:kAnimationDuration
                                   delay:0.0f
                                 options:UIViewKeyframeAnimationOptionCalculationModeLinear
                              animations:^{
                                  
                                  UIViewController *viewController = [self.viewControllers objectAtIndex:self.index];
                                  viewController.view.frame = [self getRevelFrameWithView:viewController.view AndReverse:YES];
                                  
                              }
                              completion:^(BOOL finished) {
                                  self.isAnimate = NO;
                                  self.index --;
                                  if ( -1 == self.index ){
                                      [self dismiss];
                                  }
                              }];
}

- (void)dismiss
{
    if ( self.isAnimate )
        return;
    self.isAnimate = YES;
    
    [UIView animateKeyframesWithDuration:kAnimationDuration
                                   delay:0.0f
                                 options:UIViewKeyframeAnimationOptionCalculationModeLinear
                              animations:^{
                                  self.view.layer.opacity = 0.0f;
                              }
                              completion:^(BOOL finished) {
                                  [self reset];
                                  self.isAnimate = NO;
                              }];
}

- (void)pushViewController:(UIViewController *)viewController
{
    viewController.view.frame = [self getOriginalFrameWithView:self.view WithIndex:self.viewControllers.count];
    [self.view addSubview:viewController.view];
    [self.viewControllers addObject:viewController];
    
    [self push];
    
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    
    if( touch.view == self.view ){
        return YES;
    }
    return NO;
}

#pragma mark - Setters
- (void)setDirection:(NSUInteger)direction
{
    if( _direction != direction ){
        
        _direction = direction;
        [self reset];
    }
    
}

#pragma mark - Getters
- (NSUInteger)currentViewIndex
{
    return self.index;
}
@end














