//
//  UIViewController+DUNotificationBanner.m
//  Russia
//
//  Created by griff on 12/6/15.
//  Copyright (c) 2015 Duriana. All rights reserved.
//

#import "UIViewController+DUNotificationBanner.h"
#import <objc/runtime.h>

static char notificationBannersKey;

@implementation UIViewController (DUNotificationBanner)

- (void)setNotificationBannerViews:(NSMutableArray *)bannerViews {
    objc_setAssociatedObject(self, &notificationBannersKey, bannerViews, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableArray *)notificationBannerViews {
    NSMutableArray *bannerViews = objc_getAssociatedObject(self, &notificationBannersKey);

    if (!bannerViews) {
        bannerViews = [NSMutableArray new];
        objc_setAssociatedObject(self, &notificationBannersKey, bannerViews, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return bannerViews;
}

@end
