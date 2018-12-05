//
//  ViewController.h
//  cameraApp
//
//  Created by WilliamJu on 12/30/16.
//  Copyright © 2016 WilliamJu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
extern UIImage* imageGif;
extern NSString *url_gif;
extern NSData *data1;

@interface ViewController : UIViewController{
    IBOutlet UIView *frameforcapture;
    IBOutlet UIImageView *imageView;
    IBOutlet UIImageView *imageView1;
    
    __weak IBOutlet UIButton *buttonBack;
    __weak IBOutlet UIImageView *img111;
    __weak IBOutlet UIImageView *imgPreview;
    __weak IBOutlet UIButton *button1;
}
- (IBAction)takePhoto:(id)sender forEvent:(UIEvent *)event;

- (IBAction)tapDown:(id)sender forEvent:(UIEvent *)event;

- (IBAction)tapButton:(id)sender forEvent:(UIEvent *)event;

@end

