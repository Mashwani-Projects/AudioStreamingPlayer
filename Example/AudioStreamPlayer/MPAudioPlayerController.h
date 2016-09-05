//
//  AudioPlayer.h
//  MobileTheatre
//
//  Created by Matt Donnelly on 27/03/2010.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import <QuartzCore/QuartzCore.h>
#import "STKAudioPlayer.h"



@interface MPAudioPlayerController : UIViewController
{
//	NSMutableArray		*soundFiles;
//	NSString			*soundFilesPath;
//	NSUInteger			selectedIndex;
	
	
	CAGradientLayer		*gradientLayer;
	
	UIButton			*playButton;
	UIButton			*pauseButton;
	UILabel				*currentTime;
	UILabel				*duration;
	
	UIButton			*artworkView;
	UIView				*containerView;
	UIView				*overlayView;
	
	
	
}

@property(nonatomic ,retain) STKAudioPlayer *audioPlayer;

@property (nonatomic, strong) UIViewController *parentController;

@property (nonatomic, strong) NSURL *streamUrl;
@property(nonatomic ,retain) UISlider *slider;


@property (nonatomic, strong) UIImage *noArtworkImage;
@property (nonatomic, strong) UIImage *noArtworkDefaultImage;

@property (nonatomic, strong) UIButton *playButton;
@property (nonatomic, strong) UIButton *pauseButton;

@property (nonatomic, strong) UIButton *artworkView;

@property (nonatomic, strong) UIView *containerView;

- (void)dismissAudioPlayer;

- (IBAction)progressSliderMoved:(UISlider*)sender;


@end


