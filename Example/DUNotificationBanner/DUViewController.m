//
//  DUViewController.m
//  DUNotificationBanner
//
//  Created by essame on 09/29/2016.
//  Copyright (c) 2016 essame. All rights reserved.
//

#import "DUViewController.h"
#import "DurianaNotificationBannerView.h"

@import DUNotificationBanner;

@implementation DUViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"Hello Banners!";
}

- (IBAction)showNewBanner:(id)sender {
    DurianaNotificationBannerView *bannerView = [[NSBundle.mainBundle loadNibNamed:@"DurianaNotificationBannerView" owner:nil options:nil] objectAtIndex:0];
    bannerView.lifetime = arc4random_uniform(5);
    bannerView.interactionBlock = ^{
        NSLog(@"Interacted!");
    };
    bannerView.closeBlock = ^{
        NSLog(@"Closed!");
    };
    [[DUNotificationBannerPresentationManager sharedManager] showBannerView:bannerView onViewController:self];
}

@end
