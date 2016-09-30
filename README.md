# DUNotificationBanner
A drop-in-solution to present banner notifications in any UIViewController.

Use this pod to display in app notifications in real time it, the source of the notifications doesn't matter, it can be from API or from scehduled events, it just works!.

This repository is maintained by the Duriana team at Duriana Internet.

### Requirements
[![Platform iOS](https://img.shields.io/badge/Platform-iOS-blue.svg?style=fla)]() [![Objective-c](https://img.shields.io/badge/Language-Objective C-blue.svg?style=flat)](https://developer.apple.com/library/mac/documentation/Cocoa/Conceptual/ProgrammingWithObjectiveC/Introduction/Introduction.html)

Minimum iOS Target: iOS 9.0

### Demo Project

Minimum Xcode Version: Xcode 9.0

### Installation
---

#### Cocoapod Method:

`DUNotificationBanner` is available through [CocoaPods](http://cocoapods.org), to install
it simply add the following line to your Podfile:

`pod 'DUNotificationBanner'`

### How to use
---

```objc

// showing a banner in a UIViewController
// bannerView can be any UIView<DUNotificationBannerView>
[[DUNotificationBannerPresentationManager sharedManager] showBannerView:bannerView onViewController:self];

// hiding the a banner
[[DUNotificationBannerPresentationManager sharedManager] hideBannerView:bannerView];
```

### How to Try it out
---

In the demo project there is a class `DurianaNotificationBannerView` which add some neat functionalities like,
- Interaction callback
- Closing callback
- Closing timer

```objc
DurianaNotificationBannerView *bannerView = [[NSBundle.mainBundle loadNibNamed:@"DurianaNotificationBannerView" owner:nil options:nil] objectAtIndex:0];
    bannerView.lifetime = arc4random_uniform(5);
    bannerView.interactionBlock = ^{
        NSLog(@"Interacted!");
    };
    bannerView.closeBlock = ^{
        NSLog(@"Closed!");
    };
    [[DUNotificationBannerPresentationManager sharedManager] showBannerView:bannerView onViewController:self];
```

### TODO
---

- Fix layout issues when using transparent navigation bar.

### Contributions
---
Any contribution is more than welcome! You can contribute through pull requests and issues on GitHub.
