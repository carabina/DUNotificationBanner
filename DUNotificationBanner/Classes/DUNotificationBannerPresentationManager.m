//
//  NotificationBannerManager.m
//  Russia
//
//  Created by griff on 12/6/15.
//  Copyright (c) 2015 Duriana. All rights reserved.
//

#import "DUNotificationBannerPresentationManager.h"
#import "UIViewController+DUNotificationBanner.h"

@import TTLayoutSupport;

#define _f(string, ...) ([NSString stringWithFormat:string, __VA_ARGS__])

#pragma mark - DUNotificationBannerView

@implementation DUNotificationBannerView
@synthesize presentingAsNotificationBannerViewController;
@synthesize bannerHeightConstraint;
@synthesize bannerYConstraint;
@end

#pragma mark - DUNotificationBannerManager

@implementation DUNotificationBannerPresentationManager

+ (instancetype)sharedManager {
    static id sharedInstance = nil;
    static dispatch_once_t onceToken = 0;

    dispatch_once(&onceToken, ^{
        sharedInstance = [self new];
    });
    return sharedInstance;
}

- (void)showBannerView:(UIView<DUNotificationBannerView> *)bannerView onViewController:(UIViewController *)viewController {
    // hide if shown
    [self hideBannerView:bannerView animated:NO];

    // insure that view has updated constraints
    [bannerView setNeedsLayout];
    [bannerView layoutIfNeeded];

    bannerView.translatesAutoresizingMaskIntoConstraints = NO;
    [viewController.view addSubview:bannerView];

    // remove all constraints before adding new one
    if (bannerView.bannerHeightConstraint) {
        [bannerView removeConstraint:bannerView.bannerHeightConstraint];
    }
    if (bannerView.bannerYConstraint) {
        [bannerView removeConstraint:bannerView.bannerYConstraint];
    }

    CGFloat bannerHeight = bannerView.frame.size.height;

    // add constraints to bannerView
    id<UILayoutSupport> topLayoutGuide = viewController.topLayoutGuide;
    NSDictionary *views = NSDictionaryOfVariableBindings(bannerView, topLayoutGuide);
    [viewController.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[bannerView]|" options:0 metrics:nil views:views]];

    // for some reason "V:[bannerView(%f)][topLayoutGuide]" doesn't work as expected
    NSLayoutConstraint *bannerYConstraint = [NSLayoutConstraint constraintsWithVisualFormat:_f(@"V:[topLayoutGuide]-(%f)-[bannerView]", -(bannerHeight + topLayoutGuide.length)) options:0 metrics:nil views:views][0];
    [viewController.view addConstraint:bannerYConstraint];
    NSLayoutConstraint *bannerHeightConstraint = [NSLayoutConstraint constraintWithItem:bannerView
                                                                              attribute:NSLayoutAttributeHeight
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:nil
                                                                              attribute:NSLayoutAttributeNotAnAttribute
                                                                             multiplier:1
                                                                               constant:bannerHeight];
    [bannerView addConstraint:bannerHeightConstraint];

    // show banner by changing topLayoutGuide length
    bannerView.presentingAsNotificationBannerViewController = viewController;
    bannerView.bannerHeightConstraint                       = bannerHeightConstraint;
    bannerView.bannerYConstraint                            = bannerYConstraint;
    [viewController.view layoutIfNeeded];
    viewController.tt_topLayoutGuide.length += bannerHeight;
    [viewController.notificationBannerViews addObject:bannerView];  // the latest the uppest
    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionAllowUserInteraction animations:^{
        [viewController.view layoutIfNeeded];
    } completion:nil];
}

- (void)hideBannerView:(UIView<DUNotificationBannerView> *)bannerView {
    [self hideBannerView:bannerView animated:YES];
}

- (void)hideBannerView:(UIView<DUNotificationBannerView> *)bannerView animated:(BOOL)animated {
    if (bannerView.presentingAsNotificationBannerViewController) {
        // hide banner by changing topLayoutGuide length
        UIViewController *viewController = bannerView.presentingAsNotificationBannerViewController;

        [viewController.view layoutIfNeeded];
        CGFloat bannerHeight = bannerView.bannerHeightConstraint.constant;
        viewController.tt_topLayoutGuide.length = MAX(viewController.tt_topLayoutGuide.length - bannerHeight, 0.0);

        NSInteger index = [viewController.notificationBannerViews indexOfObject:bannerView];
        NSAssert(index != NSNotFound, @"index notification");
        if (index != NSNotFound) {
            // change y position of all banners added after this one
            for (NSInteger i = index + 1; i < viewController.notificationBannerViews.count; ++i) {
                UIView<DUNotificationBannerView> *otherBannerView = viewController.notificationBannerViews[i];
                otherBannerView.bannerYConstraint.constant += bannerHeight;
            }
            [viewController.notificationBannerViews removeObjectAtIndex:index];
        }
        bannerView.presentingAsNotificationBannerViewController = nil;

        // animation completion block
        void (^completionBlock)(BOOL) = ^(BOOL finished) {
            // remove from superview, remove all constraints
            [bannerView removeFromSuperview];
            [bannerView removeConstraints:@[bannerView.bannerHeightConstraint, bannerView.bannerYConstraint]];
            bannerView.bannerHeightConstraint = nil;
            bannerView.bannerYConstraint = nil;
            // restore banner original height
            bannerView.frame = (CGRect) {bannerView.frame.origin, bannerView.frame.size.width, bannerHeight};
            [viewController.view layoutIfNeeded];
        };

        if (animated) {
            [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionAllowUserInteraction animations:^{
                [viewController.view layoutIfNeeded];
            } completion:completionBlock];
        } else {
            completionBlock(YES);
        }
    }
}

@end
