//
//  HYNoResultsView.h
//  XianNewVersion
//
//  Created by Hongyi Zheng on 9/28/14.
//  Copyright (c) 2014 Hongyi Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HYNoResultsViewDelegate;

@interface HYNoResultsView : UIView

@property (nonatomic, strong) NSString *titleText;
@property (nonatomic, strong) NSString *messageText;
@property (nonatomic, strong) NSString *buttonTitle;
@property (nonatomic, strong) UIView *accessoryView;

@property (nonatomic, weak) id <HYNoResultsViewDelegate> delegate;

+ (instancetype)noResultsViewWithTitle:(NSString *)titleText message:(NSString *)messageText accessoryView:(UIView *)accessoryView buttonTitle:(NSString *)buttonTitle;
- (void)showInView:(UIView *)view;
- (void)centerInSuperview;

@end

@protocol HYNoResultsViewDelegate <NSObject>

@optional
- (void) didTapNoResultsView:(HYNoResultsView *) noResultsView;

@end
