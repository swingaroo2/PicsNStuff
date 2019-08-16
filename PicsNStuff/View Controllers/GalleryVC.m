//
//  GalleryVC.m
//  PicsNStuff
//
//  Created by Zach Lockett-Streiff on 8/15/19.
//  Copyright © 2019 Swingaroo2. All rights reserved.
//

#import "GalleryVC.h"
#import "PicsNStuff-Swift.h"

@interface GalleryVC ()
@property (strong, nonatomic) PageViewManager *viewManager;
@end

@implementation GalleryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpViewManager];
    [self setUpActivityIndicator];
}

- (void)setUpViewManager {
    PageViewManager *viewManager = [[PageViewManager alloc] initWithService:[FlickrService new] and:self];
    self.viewManager = viewManager;
}

- (void)setUpActivityIndicator {
    UIActivityIndicatorView *loadingSpinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [loadingSpinner startAnimating];
    [self.view addSubview:loadingSpinner];
    [self.view sendSubviewToBack:loadingSpinner];
    loadingSpinner.translatesAutoresizingMaskIntoConstraints = NO;
    [loadingSpinner.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
    [loadingSpinner.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor].active = YES;
}

@end
