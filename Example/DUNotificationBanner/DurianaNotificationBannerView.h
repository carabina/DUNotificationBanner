//
//  DurianaNotificationBannerView.h
//  Russia
//
//  Created by griff on 29/6/15.
//  Copyright (c) 2015 Duriana. All rights reserved.
//

@import DUNotificationBanner;

@interface DurianaNotificationBannerView : DUNotificationBannerView
@property (strong, nonatomic) IBOutlet UIButton     *closeButton;
@property (strong, nonatomic) IBOutlet UIImageView  *imageView;
@property (strong, nonatomic) IBOutlet UILabel      *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel      *messageLabel;
@property (assign, nonatomic) CGFloat lifetime;
@property (strong, nonatomic) void (^interactionBlock)();
@property (strong, nonatomic) void (^closeBlock)();
@end
