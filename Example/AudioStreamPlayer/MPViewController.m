//
//  MPViewController.m
//  AudioStreamPlayer
//
//  Created by Syed Abdul Basit on 09/05/2016.
//  Copyright (c) 2016 Syed Abdul Basit. All rights reserved.
//
#import "MPViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "MPAudioPlayerController.h"


@interface MPViewController ()

@end

@implementation MPViewController

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    MPAudioPlayerController *controller = [[MPAudioPlayerController alloc] init];
    controller.parentController = self;
    controller.streamUrl = [NSURL URLWithString:@"http://server11.mp3quran.net/hawashi/002.mp3"];
    [self presentViewController:controller animated:YES completion:nil];
    
}
- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
  
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    
   
}





@end

