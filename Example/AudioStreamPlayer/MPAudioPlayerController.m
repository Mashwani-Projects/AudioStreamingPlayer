
//
//  AudioPlayer.m
//  MobileTheatre
//
//  Created by Matt Donnelly on 27/03/2010.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import "MPAudioPlayerController.h"
#import <AVFoundation/AVFoundation.h>
#import "STKAudioPlayer.h"
#import "STKDataSource.h"
#import "SampleQueueId.h"
@interface MPAudioPlayerController ()<STKAudioPlayerDelegate>
{
    CGFloat statusBarOffset;
}

@property(nonatomic ,assign) NSTimeInterval time;
@property(nonatomic ,retain) NSTimer *timer;

@end

@implementation MPAudioPlayerController


//@synthesize soundFiles;
//@synthesize soundFilesPath;

@synthesize playButton;
@synthesize pauseButton;



@synthesize artworkView;
@synthesize containerView;



#pragma MARK STAUDIO PLAYER DELEGATE


/// Raised when an item has started playing
-(void) audioPlayer:(STKAudioPlayer*)audioPlayer didStartPlayingQueueItemId:(NSObject*)queueItemId {
    
    
    UIImage *pauseImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"AudioPlayerPause" ofType:@"png"]];
    

    
    NSLog(@"progress hint %f",self.audioPlayer.progress);
    [self.playButton setImage:pauseImage forState:UIControlStateNormal
     ];
}
/// Raised when an item has finished buffering (may or may not be the currently playing item)
/// This event may be raised multiple times for the same item if seek is invoked on the player
-(void) audioPlayer:(STKAudioPlayer*)audioPlayer didFinishBufferingSourceWithQueueItemId:(NSObject*)queueItemId {
    
}
/// Raised when an item has finished playing
-(void) audioPlayer:(STKAudioPlayer*)audioPlayer didFinishPlayingQueueItemId:(NSObject*)queueItemId withReason:(STKAudioPlayerStopReason)stopReason andProgress:(double)progress andDuration:(double)duration; {
    
    UIImage *playImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"AudioPlayerPlay" ofType:@"png"]];
    
    [self.playButton setImage:playImage forState:UIControlStateNormal
     ];
    [self.timer invalidate];
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void) audioPlayer:(STKAudioPlayer*)audioPlayer stateChanged:(STKAudioPlayerState)state previousState:(STKAudioPlayerState)previousState {
    
    if(state == STKAudioPlayerStatePlaying) {
        
        duration.text = [NSString stringWithFormat:@"%.2f",audioPlayer.duration];
    self.timer =  [NSTimer scheduledTimerWithTimeInterval:0.0001 target:self selector:@selector(updateSlider) userInfo:nil repeats:YES];
        self.slider.minimumValue = 0;
        self.slider.maximumValue = audioPlayer.duration;
    }
}

/// Raised when an unexpected and possibly unrecoverable error has occured (usually best to recreate the STKAudioPlauyer)
-(void) audioPlayer:(STKAudioPlayer*)audioPlayer unexpectedError:(STKAudioPlayerErrorCode)errorCode {
    
}



- (void)viewDidLoad
{
	[super viewDidLoad];
    
    self.time = 0;
    [self addSubViewForMediaPlayer];

	
	
	
//	[self updateViewForPlayerInfo:player];
	//[self updateViewForPlayerState:player];
}


- (void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
    
     self.audioPlayer = [[STKAudioPlayer alloc] initWithOptions:(STKAudioPlayerOptions){ .flushQueueOnSeek = YES, .enableVolumeMixer = NO, .equalizerBandFrequencies = {50, 100, 200, 400, 800, 1600, 2600, 16000} }];
    self.audioPlayer.meteringEnabled = YES;
    self.audioPlayer.volume = 5;
   
    self.audioPlayer.delegate = self;
    //
        STKDataSource *dataSource = [STKAudioPlayer dataSourceFromURL:self.streamUrl];
    //
        [self.audioPlayer setDataSource:dataSource withQueueItemId:[[SampleQueueId alloc] initWithUrl:self.streamUrl andCount:0]];
    //;
  	}


- (void)dismissView {
    
    [self.audioPlayer stop];
       [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)addSubViewForMediaPlayer {
    
   // UIView *statusBarBackground = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 64)];
  //  statusBarBackground.backgroundColor = [UIColor colorWithRed:0.078f green:0.078f blue:0.078f alpha:1.00f];
//     statusBarBackground.backgroundColor = [UIColor colorWithRed:57/255 green:58/255 blue:60/255 alpha:1.0];
//
  //  [self.view addSubview:statusBarBackground];
    
   // UINavigationBar *navigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    
  //  navigationBar.barStyle = UIBarStyleDefault;
   // navigationBar.backgroundColor = [UIColor colorWithRed:57/255 green:58/255 blue:60/255 alpha:1.0];
   // [self.view addSubview:navigationBar];
    
  //  UINavigationItem *navItem = [[UINavigationItem alloc] initWithTitle:@""];
   // [navigationBar pushNavigationItem:navItem animated:NO];
    
    UIView *navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.parentController.view.frame.size.width, 60)];
    navView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:navView];

    UIButton *doneButton = [[UIButton alloc] initWithFrame:CGRectMake(8, 120, 44, 30)];
    [doneButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [doneButton setTitle:@"Done" forState:UIControlStateNormal];
    [doneButton setUserInteractionEnabled:YES];
    [doneButton setEnabled:YES];
    [doneButton addTarget:self action:@selector(dismissAudioPlayer) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:doneButton];
    
    //navItem.leftBarButtonItem = doneButton;
    
    
     self.slider = [[UISlider alloc] initWithFrame:CGRectMake(95, 32, self.view.frame.size.width-140, 20)];
    // [theslider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    [self.slider setBackgroundColor:[UIColor clearColor]];
    self.slider.continuous = YES;
    self.slider.value = 0.0;
    self.slider.value = 100.0;
    [navView addSubview:self.slider];
    
    duration = [[UILabel alloc] initWithFrame:CGRectMake(self.slider.frame.size.width+100, 32, 48, 21)];
    duration.font = [UIFont boldSystemFontOfSize:14];
    duration.shadowOffset = CGSizeMake(0, -1);
    duration.shadowColor = [UIColor blackColor];
    duration.backgroundColor = [UIColor clearColor];
    duration.textColor = [UIColor whiteColor];
   [navView addSubview:duration];
    duration.text = @".:..";
    
    currentTime = [[UILabel alloc] initWithFrame:CGRectMake(45, 32, 48, 21)];
    currentTime.font = [UIFont boldSystemFontOfSize:14];
    currentTime.shadowOffset = CGSizeMake(0, -1);
    currentTime.shadowColor = [UIColor blackColor];
    currentTime.backgroundColor = [UIColor clearColor];
    currentTime.textColor = [UIColor whiteColor];
    currentTime.textAlignment = NSTextAlignmentRight;
    currentTime.text = @".:..";
    [navView addSubview:currentTime];
    
    
    duration.adjustsFontSizeToFitWidth = YES;
    currentTime.adjustsFontSizeToFitWidth = YES;
    
    
    
    self.containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height - 44)];
    [self.view addSubview:containerView];
    
    self.artworkView = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.parentController.view.frame.size.width, self.parentController.view.frame.size.height)];
    
    gradientLayer = [[CAGradientLayer alloc] init];
    gradientLayer.frame = CGRectMake(0.0, self.containerView.bounds.size.height - 96, self.containerView.bounds.size.width, 48);
    gradientLayer.colors = [NSArray arrayWithObjects:(id)[UIColor clearColor].CGColor, (id)[UIColor colorWithWhite:0.0 alpha:0.5].CGColor, (id)[UIColor blackColor].CGColor, (id)[UIColor blackColor].CGColor, nil];
    gradientLayer.zPosition = INT_MAX;
    
    /*! HACKY WAY OF REMOVING EXTRA SEPERATORS */
    UIImage *backgroundImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"AudioPlayerBarBackground" ofType:@"png"]];
    
    
    UIImage *playImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"AudioPlayerPlay" ofType:@"png"]];
    
    UIImage *playNext = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"AudioPlayerNextTrack" ofType:@"png"]];
    
    UIImage *previous = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"AudioPlayerPrevTrack" ofType:@"png"]];
    
    UIImageView *buttonBackground = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height - 96, self.view.bounds.size.width, 96)];
    buttonBackground.image = backgroundImage;
    [self.view addSubview:buttonBackground];
    
    
    
    UIView *playerView = [[UIView alloc] initWithFrame:CGRectMake(0, self.parentController.view.frame.size.height-60, self.parentController.view.frame.size.width, 60)];
    playerView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:playerView];
    self.playButton = [[UIButton alloc] initWithFrame:CGRectMake(self.parentController.view.frame.size.width/2.4, playerView.frame.size.height/7, 40, 40)];
    [playButton setImage:playImage forState:UIControlStateNormal];
    [playButton addTarget:self action:@selector(play) forControlEvents:UIControlEventTouchUpInside];
    playButton.showsTouchWhenHighlighted = YES;
    [playerView addSubview:playButton];
    
    
    UIButton *nextButton = [[UIButton alloc] initWithFrame:CGRectMake(40, playerView.frame.size.height/7, 40, 40)];
    [nextButton setImage:playNext
                forState:UIControlStateNormal];
    
    nextButton.showsTouchWhenHighlighted = YES;
    // nextButton.enabled = [self canGoToNextTrack];
    [playerView addSubview:nextButton];
    
    UIButton *previousButton = [[UIButton alloc] initWithFrame:CGRectMake(self.parentController.view.frame.size.width/3.8, playerView.frame.size.height/7, 40, 40)];
    [previousButton setImage:previous
                    forState:UIControlStateNormal];
    previousButton.showsTouchWhenHighlighted = YES;
    [playerView addSubview:previousButton];
    
    
    UIImage *artwork = nil;// [selectedSong coverImage];
    if (!artwork) {
        artwork = self.noArtworkImage;
    }
    
    //[self showOverlayView];
    
    [artworkView setImage:artwork forState:UIControlStateNormal];
    self.artworkView.imageView.contentMode = UIViewContentModeScaleAspectFill;
    // [artworkView addTarget:self action:@selector(showOverlayView) forControlEvents:UIControlEventTouchUpInside];
    artworkView.showsTouchWhenHighlighted = NO;
    artworkView.adjustsImageWhenHighlighted = NO;
    artworkView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:artworkView];
    
    

}
- (void)dismissAudioPlayer
{
    [self dismissView];
//    if ([self respondsToSelector:@selector(presentingViewController)]){
//        [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
//    }
//    else {
//        [self.parentViewController dismissViewControllerAnimated:YES completion:nil];
//    }
    
    
}


- (void)updateSlider {

    dispatch_async(dispatch_get_main_queue(), ^(){
        //Add method, task you want perform on mainQueue
        //Control UIView, IBOutlet all here
        
        self.slider.value = self.audioPlayer.progress;
        currentTime.text = [NSString stringWithFormat:@"%.2f",self.audioPlayer.progress];

    });

}


- (IBAction)progressSliderMoved:(UISlider *)sender
{
	//player.currentTime = sender.value;
	//[self updateCurrentTimeForPlayer:player];
}



- (void)viewDidUnload
{
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (UIImage *)noArtworkImage
{
    if (_noArtworkImage) {
        return _noArtworkImage;
    }
    else {
        return self.noArtworkDefaultImage;
    }
}

- (UIImage *)noArtworkDefaultImage
{
    if (_noArtworkDefaultImage) {
        return _noArtworkDefaultImage;
    }
    else {
        _noArtworkDefaultImage = [UIImage imageNamed:@"AudioPlayerNoArtwork"];
        return _noArtworkDefaultImage;
    }
}



@end
