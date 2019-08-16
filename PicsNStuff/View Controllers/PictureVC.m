//
//  PictureVC.m
//  PicsNStuff
//
//  Created by Zach Lockett-Streiff on 8/15/19.
//  Copyright © 2019 Swingaroo2. All rights reserved.
//

#import "PictureVC.h"
#import "PicsNStuff-Swift.h"

@interface PictureVC ()
@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) NSURL *imageURL;
@property (strong, nonatomic) UILabel *titleLabel;
@end

@implementation PictureVC

- (instancetype)initWithImageURL:(NSURL*)url andTitle:(NSString*)title {
    self = [super init];
    
    if (self) {
        self.titleLabel = [self configureLabelWithTitle:title];
        self.imageURL = url;
        self.imageView = [[UIImageView alloc] initWithImage:UIImage.new];
    }
    
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self configureImageViewWithImageURL:self.imageURL];
}

- (UILabel*)configureLabelWithTitle:(NSString*)title {
    UILabel *titleLabel = [UILabel new];
    title = [title stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    title = title.length > 0 ? title : @"No Title";
    [titleLabel setText:title];
    [titleLabel sizeToFit];
    [titleLabel setTextColor:[UIColor colorWithRed:245.0/255.0 green:196.0/255.0 blue:167.0/255.0 alpha:1.0]];
    titleLabel.numberOfLines = 0;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    return titleLabel;
}

- (void)configureImageViewWithImageURL:(NSURL*)url {
    ImageService *service = [[ImageService alloc] init:url];
    [service initiateWithCompletion:^(UIImage* image, NSError *error){
        if (error) {
            [self presentBasicAlertWithMessage:error.localizedDescription];
        } else {
            self.imageView = [[UIImageView alloc] initWithImage:image];
            [self setUpView];
        }
    }];
}

- (void)setUpView {
    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.imageView];
    
    self.imageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.imageView.topAnchor constraintEqualToAnchor:self.view.topAnchor].active = YES;
    [self.imageView.widthAnchor constraintEqualToAnchor:self.view.widthAnchor].active = YES;
    
    [self.titleLabel.topAnchor constraintEqualToAnchor:self.imageView.bottomAnchor].active = YES;
    [self.titleLabel.widthAnchor constraintEqualToAnchor:self.view.widthAnchor].active = YES;
    [self.titleLabel.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
    [self.titleLabel.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor].active = YES;
    [self.titleLabel.heightAnchor constraintEqualToConstant:44.0f].active = YES;
}

@end
