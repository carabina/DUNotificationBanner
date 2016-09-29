//
//  DUNotificationBannerPresentationManager.h
//  Russia
//
//  Created by griff on 12/6/15.
//  Copyright (c) 2015 Duriana. All rights reserved.
//

#import <Foundation/Foundation.h>

//
// DUNotificationBannerView protocol
//
@protocol DUNotificationBannerView
@property (strong, nonatomic) UIViewController      *presentingAsNotificationBannerViewController;
@property (strong, nonatomic) NSLayoutConstraint    *bannerHeightConstraint;
@property (strong, nonatomic) NSLayoutConstraint    *bannerYConstraint;
@end

//
// DUNotificationBannerView class is a conctere implementation of DUNotificationBannerView protocol
//
@interface DUNotificationBannerView : UIView <DUNotificationBannerView>
@end

//
// DUNotificationBannerPresentationManager knows how to present UIView<DUNotificationBannerView>
//
@interface DUNotificationBannerPresentationManager : NSObject
+ (instancetype)sharedManager;

- (void)showBannerView:(UIView<DUNotificationBannerView> *)bannerView onViewController:(UIViewController *)viewController;
- (void)hideBannerView:(UIView<DUNotificationBannerView> *)bannerView;
@end
