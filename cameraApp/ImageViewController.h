//
//  ImageViewController.h
//  cameraApp
//
//  Created by James Talano on 1/9/17.
//  Copyright © 2017 James Talano. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImage+animatedGif.h"
extern NSString *url_gif;
extern NSData *data1;

@interface ImageViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end
