//
//  UIImageView+GobbleImageview.m
//  Gobble
//
//  Created by Nikhil Tammewar on 14/02/15.
//  Copyright (c) 2015 Applay. All rights reserved.
//

#import "UIImageView+GobbleImageview.h"
#import "UIImageView+WebCache.h"

@implementation UIImageView (GobbleImageview)

- (void)setImageURLString:(NSString*)imageURLString
{
    UIImage * placeholderimg = nil;
   
   
       
    NSURL* imageURL = [NSURL URLWithString:[imageURLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    __block UIActivityIndicatorView *activityIndicator;
    __weak UIImageView *weakImageView = self;
    [self setContentMode:UIViewContentModeScaleAspectFill];
    [self setClipsToBounds:YES];
    [self sd_setImageWithURL:imageURL
                 placeholderImage:[UIImage imageNamed:@"placeholder.jpg"]
                          options:SDWebImageProgressiveDownload
                         progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                             if (!activityIndicator) {
                                 [weakImageView addSubview:activityIndicator = [UIActivityIndicatorView.alloc initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray]];
                                 activityIndicator.center =CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
                                 [activityIndicator startAnimating];
                             }
                         }
                        completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                            [activityIndicator removeFromSuperview];
                            activityIndicator = nil;
                        }];
    
}



@end
