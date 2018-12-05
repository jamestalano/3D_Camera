//
//  ViewController.m
//  cameraApp
//
//  Created by WilliamJu on 12/30/16.
//  Copyright © 2016 WilliamJu. All rights reserved.
//

#import "ViewController.h"
#import "ImageViewController.h"
#import <ImageIO/imageio.h>
#import <MobileCoreServices/Mobilecoreservices.h>
#import <AssetsLibrary/ALAssetsLibrary.h>
#import <Photos/Photos.h>

@interface ViewController ()

@end

@implementation ViewController

AVCaptureSession *session;
AVCaptureStillImageOutput *StillImageOutput;
CGPoint location1;
CGPoint location2;
UIImage *firstImage;
UIImage *firstnextImage;
UIImage *secondImage;
UIImage *firstCroppedImage;
UIImage *secondBeforeImage;
UIImage *secondCroppedImage;
CGSize sizeCropped;
UIImageView *previewImg;
UIImage *firstNextCroppedImage;
UIImage *secondBeforeCroppedImage;
int flag;
- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void) viewWillAppear:(BOOL)animated
{
    [frameforcapture setFrame:self.view.frame];
    [self.view bringSubviewToFront:button1];
    flag=0;
    //imgPreview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    [buttonBack setFrame:self.view.frame];
    imgPreview.hidden = YES;
    session = [[AVCaptureSession alloc] init];
    [session setSessionPreset:AVCaptureSessionPresetPhoto];
    AVCaptureDevice *inputDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    NSError * error;
    AVCaptureDeviceInput *deviceInput = [AVCaptureDeviceInput deviceInputWithDevice:inputDevice error:&error];
    if([session canAddInput:deviceInput]){
        [session addInput:deviceInput];
    }
    AVCaptureVideoPreviewLayer * previewLayer = [[AVCaptureVideoPreviewLayer alloc]initWithSession:session];
    [previewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    CALayer *rootLayer = [[self view]layer];
    [rootLayer setMasksToBounds:YES];
    CGRect frame = frameforcapture.frame;
    [previewLayer setFrame:frame];
    [rootLayer insertSublayer:previewLayer atIndex:0];
    StillImageOutput = [[AVCaptureStillImageOutput alloc] init];
    NSDictionary *outputSettings = [[NSDictionary alloc] initWithObjectsAndKeys:AVVideoCodecJPEG, AVVideoCodecKey, nil];
    [StillImageOutput setOutputSettings:outputSettings];
    [session addOutput:StillImageOutput];
    [session startRunning];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) capturePhoto{
    AVCaptureConnection *videoConnection = nil;
    for(AVCaptureConnection *connection in StillImageOutput.connections){
        for(AVCaptureInputPort *port in [connection inputPorts]){
            if([[port mediaType] isEqual:AVMediaTypeVideo]){
                videoConnection = connection;
                break;
            }
        }
    }
    [StillImageOutput captureStillImageAsynchronouslyFromConnection:videoConnection completionHandler:^(CMSampleBufferRef imageDataSampleBuffer, NSError *error) {
        if(imageDataSampleBuffer != NULL){
            NSData *imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageDataSampleBuffer];
            firstImage = [UIImage imageWithData:imageData];
            imageView.image = firstImage;
        }
    }];
}

-(void) capturePhoto1{
    
    PHFetchOptions *fetchOptions = [PHFetchOptions new];
    fetchOptions.includeAllBurstAssets = YES;
    fetchOptions.predicate = [NSPredicate predicateWithFormat:@"mediaType == %d", PHAssetMediaTypeImage];
    PHFetchResult *allPhotosResult = [PHAsset fetchAssetsWithOptions:fetchOptions];
    NSLog(@"photos count: %lu",(unsigned long)[allPhotosResult count]);
    
    [allPhotosResult enumerateObjectsUsingBlock:^(PHAsset *asset, NSUInteger idx, BOOL *stop) {
        
        // burst mode photos
        if (asset.representsBurst) {
        //    NSLog(@"Count:%d",++i);
            
            PHFetchOptions *fetchOptions = [PHFetchOptions new];
            fetchOptions.includeAllBurstAssets = YES;
            PHFetchResult *burstSequence = [PHAsset fetchAssetsWithBurstIdentifier:asset.burstIdentifier options:fetchOptions];
            
        }
    }];
    
    
    AVCaptureConnection *videoConnection = nil;
    for(AVCaptureConnection *connection in StillImageOutput.connections){
        for(AVCaptureInputPort *port in [connection inputPorts]){
            if([[port mediaType] isEqual:AVMediaTypeVideo]){
                videoConnection = connection;
                break;
            }
        }
    }
    [StillImageOutput captureStillImageAsynchronouslyFromConnection:videoConnection completionHandler:^(CMSampleBufferRef imageDataSampleBuffer, NSError *error) {
        if(imageDataSampleBuffer != NULL){
            NSData *imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageDataSampleBuffer];
            firstnextImage = [UIImage imageWithData:imageData];
            img111.image = firstImage;
        }
    }];
}
-(void) capturePhoto2{
    AVCaptureConnection *videoConnection = nil;
    for(AVCaptureConnection *connection in StillImageOutput.connections){
        for(AVCaptureInputPort *port in [connection inputPorts]){
            if([[port mediaType] isEqual:AVMediaTypeVideo]){
                videoConnection = connection;
                break;
            }
        }
    }
    [StillImageOutput captureStillImageAsynchronouslyFromConnection:videoConnection completionHandler:^(CMSampleBufferRef imageDataSampleBuffer, NSError *error) {
        if(imageDataSampleBuffer != NULL){
            NSData *imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageDataSampleBuffer];
            secondBeforeImage = [UIImage imageWithData:imageData];
            img111.image = firstImage;
        }
    }];
}

- (IBAction)takePhoto:(id)sender forEvent:(UIEvent *)event {
    flag=1;
    [self capturePhoto];
 //   [NSThread sleepForTimeInterval:0.01f];
    [self capturePhoto1];
 //   [NSThread sleepForTimeInterval:0.01f];
    [self capturePhoto2];
 //   [NSThread sleepForTimeInterval:0.01f];
    
    AVCaptureConnection *videoConnection = nil;
    for(AVCaptureConnection *connection in StillImageOutput.connections){
        for(AVCaptureInputPort *port in [connection inputPorts]){
            if([[port mediaType] isEqual:AVMediaTypeVideo]){
                videoConnection = connection;
                break;
            }
        }
    }
    [StillImageOutput captureStillImageAsynchronouslyFromConnection:videoConnection completionHandler:^(CMSampleBufferRef imageDataSampleBuffer, NSError *error) {
        if(imageDataSampleBuffer != NULL){
            NSData *imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageDataSampleBuffer];
            secondImage = [UIImage imageWithData:imageData];
            imageView1.image = secondImage;
        }
    }];
    [self.view bringSubviewToFront:buttonBack];
    [buttonBack setBackgroundImage:secondImage forState:UIControlStateNormal];
}



- (UIImage *) cropImage:(UIImage *)originalImage toRect:(CGRect)cropSize
{
    NSLog(@"original image orientation:%ld",(long)originalImage.imageOrientation);
    
    //calculate scale factor to go between cropframe and original image
    float SF = originalImage.size.width / self.view.frame.size.width;
    
    //find the centre x,y coordinates of image
    float centreX = originalImage.size.width / 2;
    float centreY = originalImage.size.height / 2;
    
    //calculate crop parameters
 //   float cropX = centreX - ((cropSize.width / 2) * SF);
 //   float cropY = centreY - ((cropSize.height / 2) * SF);
    
    CGRect cropRect = CGRectMake(cropSize.origin.x*SF, cropSize.origin.y*SF, (cropSize.size.width *SF), (cropSize.size.height * SF));
    
    CGAffineTransform rectTransform;
    switch (originalImage.imageOrientation)
    {
        case UIImageOrientationLeft:
            rectTransform = CGAffineTransformTranslate(CGAffineTransformMakeRotation(M_PI_2), 0, -originalImage.size.height);
            break;
        case UIImageOrientationRight:
            rectTransform = CGAffineTransformTranslate(CGAffineTransformMakeRotation(-M_PI_2), -originalImage.size.width, 0);
            break;
        case UIImageOrientationDown:
            rectTransform = CGAffineTransformTranslate(CGAffineTransformMakeRotation(-M_PI), -originalImage.size.width, -originalImage.size.height);
            break;
        default:
            rectTransform = CGAffineTransformIdentity;
    };
    rectTransform = CGAffineTransformScale(rectTransform, originalImage.scale, originalImage.scale);
    
    CGImageRef imageRef = CGImageCreateWithImageInRect([originalImage CGImage], CGRectApplyAffineTransform(cropRect, rectTransform));
    UIImage *result = [UIImage imageWithCGImage:imageRef scale:originalImage.scale orientation:originalImage.imageOrientation];
    CGImageRelease(imageRef);
    //return result;
    
    //Now want to scale down cropped image!
    //want to multiply frames by 2 to get retina resolution
    CGRect scaledImgRect = CGRectMake(0, 0, (cropSize.size.width * 2), (cropSize.size.height * 2));
    
    UIGraphicsBeginImageContextWithOptions(scaledImgRect.size, NO, [UIScreen mainScreen].scale);
    
    [result drawInRect:scaledImgRect];
    
    UIImage *scaledNewImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return scaledNewImage;
    
}
- (UIImage *)croppIngimageByImageName:(UIImage *)imageToCrop toRect:(CGRect)size
{
    //CGRect CropRect = CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height+15);
    CGSize sizeImage = imageToCrop.size;
    CGRect size1;
    size1.origin.x = size.origin.x/self.view.frame.size.width*firstImage.size.width;
    size1.origin.y = size.origin.y/self.view.frame.size.width*firstImage.size.height;
    size1.size.height = size.size.width/self.view.frame.size.width*firstImage.size.width;
    size1.size.width = size.size.height/self.view.frame.size.width*firstImage.size.height;
    
    CGImageRef imageRef = CGImageCreateWithImageInRect([imageToCrop CGImage], size1);
    UIImage *cropped = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    
    return cropped;
}
- (UIImage *)imageByCroppingImage:(UIImage *)image toSize:(CGRect)size
{
    
    CGRect size1;
    size1.origin.x = size.origin.x/self.view.frame.size.width*firstImage.size.width;
    size1.origin.y = size.origin.y/self.view.frame.size.width*firstImage.size.height;
    size1.size.width = size.size.width/self.view.frame.size.width*firstImage.size.width;
    size1.size.height = size.size.height/self.view.frame.size.width*firstImage.size.height;
    
    // not equivalent to image.size (which depends on the imageOrientation)!
    double refWidth = CGImageGetWidth(image.CGImage);
    double refHeight = CGImageGetHeight(image.CGImage);
    
//    double x = (refWidth - size.width) / 2.0;
//    double y = (refHeight - size.height) / 2.0;
    
 //   CGRect cropRect = CGRectMake(size1.origin.x, size1.origin.y, size1.size.height, size1.size.width);
    CGImageRef imageRef = CGImageCreateWithImageInRect([image CGImage], size1);
    
    UIImage *cropped = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    
    return cropped;
}
- (void)exportAnimatedGif
{
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"animated.gif"];
    CGImageDestinationRef destination = CGImageDestinationCreateWithURL((CFURLRef)[NSURL fileURLWithPath:path],
                                                                        kUTTypeGIF,
                                                                        6,
                                                                        NULL);

    NSDictionary *frameProperties = [NSDictionary dictionaryWithObject:[NSDictionary dictionaryWithObject:[NSNumber numberWithInt:0.8] forKey:(NSString *)kCGImagePropertyGIFDelayTime]
                                                                forKey:(NSString *)kCGImagePropertyGIFDictionary];
    NSDictionary *gifProperties = [NSDictionary dictionaryWithObject:[NSDictionary dictionaryWithObject:[NSNumber numberWithInt:0] forKey:(NSString *)kCGImagePropertyGIFLoopCount]
                                                              forKey:(NSString *)kCGImagePropertyGIFDictionary];
    CGImageDestinationSetProperties(destination, (CFDictionaryRef)gifProperties);
    CGImageDestinationAddImage(destination, firstCroppedImage.CGImage, (CFDictionaryRef)frameProperties);
    CGImageDestinationAddImage(destination, firstNextCroppedImage.CGImage, (CFDictionaryRef)frameProperties);
    CGImageDestinationAddImage(destination, secondBeforeCroppedImage.CGImage, (CFDictionaryRef)frameProperties);
    CGImageDestinationAddImage(destination, secondCroppedImage.CGImage, (CFDictionaryRef)frameProperties);
    CGImageDestinationAddImage(destination, secondBeforeCroppedImage.CGImage, (CFDictionaryRef)frameProperties);
    CGImageDestinationAddImage(destination, firstNextCroppedImage.CGImage, (CFDictionaryRef)frameProperties);
    CGImageDestinationFinalize(destination);
    CFRelease(destination);
    NSLog(@"animated GIF file created at %@", path);//    NSLog(@"animated GIF file created at %@", path);
    
    NSData *data =[NSData dataWithContentsOfFile:path];
    data1 = data;
    url_gif = path;
    [imageView setImage:[UIImage imageWithData:data]];
    imageGif =[UIImage imageWithData:data];
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    
    [library writeImageDataToSavedPhotosAlbum:data metadata:nil completionBlock:^(NSURL *assetURL, NSError *error) {}];
}
-(void)calcCropRect{
    CGSize sizeImage = self.view.frame.size;
    sizeCropped.width = MIN(location2.x, location1.x)+(self.view.frame.size.width - MAX(location1.x, location2.x));
    sizeCropped.height = MIN(location1.y,location2.y) + (self.view.frame.size.height - MAX(location1.y, location2.y));
    CGRect rect1 = CGRectMake(self.view.frame.size.width-sizeCropped.width, 0, sizeCropped.width, sizeCropped.height);
    firstCroppedImage = [self cropImage:firstImage toRect:rect1];
    [imageView setImage:firstCroppedImage];
    
    firstNextCroppedImage = [self cropImage:firstnextImage toRect:rect1];
    //[imageView setImage:firstCroppedImage];
    
    
    CGRect rect2 = CGRectMake(0, 0, sizeCropped.width, sizeCropped.height);
    secondBeforeCroppedImage = [self cropImage:secondBeforeImage toRect:rect2];
    
    
    secondCroppedImage = [self cropImage:secondImage toRect:rect2];
    [imageView1 setImage:secondCroppedImage];
}
- (IBAction)tapDown:(id)sender forEvent:(UIEvent *)event {
    NSSet *touches = [event touchesForView:sender];
    UITouch *touch = [touches anyObject];
    CGPoint pos = [touch locationInView:sender];
    [imgPreview setFrame:CGRectMake(pos.x-25, pos.y-25, 50, 50)];
    [self.view bringSubviewToFront:imgPreview];
    UIImage *cropImg1 = [self cropImage:secondImage toRect:CGRectMake((pos.x)/self.view.frame.size.width*secondImage.size.width-25, (pos.y)/self.view.frame.size.height*secondImage.size.height-25, 50, 50)];
    [imgPreview setImage:cropImg1];
    //previewImg.hidden = NO;
    [imgPreview setHidden:NO];
}

- (IBAction)tapButton:(id)sender forEvent:(UIEvent *)event {
    
    NSSet *touches = [event touchesForView:sender];
    UITouch *touch = [touches anyObject];
    if(flag==1){
        location2 = [touch locationInView:sender];
        flag=0;
        [self calcCropRect];
        [self exportAnimatedGif];
        
  //      ImageViewController*immc = [self.storyboard instantiateViewControllerWithIdentifier:@"ImageViewController"];
   //     [self performSegueWithIdentifier:@"gotoImageView" sender:nil];
      //  [imageView setImage:[UIImage imageNamed:path]];
    }
    else if(flag==0){
        location1 = [touch locationInView:sender];
    }
    [imgPreview setHidden:YES];
}
@end
