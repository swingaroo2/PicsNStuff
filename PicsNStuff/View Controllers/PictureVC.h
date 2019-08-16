//
//  PictureVC.h
//  PicsNStuff
//
//  Created by Zach Lockett-Streiff on 8/15/19.
//  Copyright © 2019 Swingaroo2. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PictureVC : UIViewController
- (instancetype)initWithImageURL:(NSURL*)url andTitle:(NSString*)title;
@end

NS_ASSUME_NONNULL_END
