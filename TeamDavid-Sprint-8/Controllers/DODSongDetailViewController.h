//
//  DODSongDetailViewController.h
//  TeamDavid-Sprint-8
//
//  Created by David Doswell on 12/27/18.
//  Copyright © 2018 David Doswell. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DODSong;
@class DODSongController;

NS_ASSUME_NONNULL_BEGIN

@interface DODSongDetailViewController : UIViewController

@property DODSong *song;
@property DODSongController *songController;

@property (weak, nonatomic) IBOutlet UILabel *ratingTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *rating;
@property (weak, nonatomic) IBOutlet UITextField *songTextField;
@property (weak, nonatomic) IBOutlet UITextField *artistTextField;
@property (weak, nonatomic) IBOutlet UITextView *lyricsTextView;

-(void)updateViews;
- (IBAction)save:(UIButton *)sender;
- (IBAction)search:(UIButton *)sender;
- (IBAction)ratingStepper:(UISegmentedControl *)sender;

@end

NS_ASSUME_NONNULL_END
