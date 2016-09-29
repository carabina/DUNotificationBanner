//
//  DurianaNotificationBannerView.m
//  Russia
//
//  Created by griff on 29/6/15.
//  Copyright (c) 2015 Duriana. All rights reserved.
//

#import "DurianaNotificationBannerView.h"

@interface DurianaNotificationBannerView ()
@property (strong, nonatomic) NSTimer *closeTimer;
@end

@implementation DurianaNotificationBannerView

- (void)awakeFromNib {
    [super awakeFromNib];

    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didInterract:)];
    [self addGestureRecognizer:tapGestureRecognizer];
}

- (void)didMoveToSuperview {
    if (self.lifetime > 0) {
        self.closeTimer = [NSTimer scheduledTimerWithTimeInterval:self.lifetime target:self selector:@selector(close) userInfo:nil repeats:NO];
    }
}

- (void)dealloc {
    [self.closeTimer invalidate];
    self.closeTimer = nil;
}

- (void)close {
    if (self.closeBlock) {
        self.closeBlock();
    }

    [[DUNotificationBannerPresentationManager sharedManager] hideBannerView:self];
}

- (void)didInterract:(UIGestureRecognizer *)sender {
    if (self.interactionBlock) {
        self.interactionBlock();
    }

    [[DUNotificationBannerPresentationManager sharedManager] hideBannerView:self];
}

- (IBAction)closeButtonPressed:(id)sender {
    [self close];
}

@end
