//
//  DODSongDetailViewController.m
//  TeamDavid-Sprint-8
//
//  Created by David Doswell on 12/27/18.
//  Copyright © 2018 David Doswell. All rights reserved.
//

#import "DODSongDetailViewController.h"
#import "DODSongController.h"
#import "DODSong.h"

@interface DODSongDetailViewController ()

@property (weak, nonatomic) IBOutlet UILabel *ratingsLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *ratingStepper;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *save;
@property (weak, nonatomic) IBOutlet UIButton *searchButton;

@end

@implementation DODSongDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateViews];
}

- (void)updateViews
{
    if (self.song) {
        NSNumber *rating = [NSNumber numberWithInteger:self.song.rating];
        [self.ratingTextLabel setText: [NSString stringWithFormat:@"Rating: %i", (int)rating.integerValue]];
        self.ratingStepper.value = rating.doubleValue;
        self.songTextField.text = self.song.title;
        self.artistTextField.text = self.song.artist;
        self.lyricsTextView.text = self.song.lyric;
    }
}

- (IBAction)save:(id)sender {
    NSNumber *rating = [NSNumber numberWithInteger:self.ratingStepper.value];
    if (self.song) {
        if (self.song.rating != rating.integerValue) {
            [self.songController updateSong:self.song rating:rating.integerValue];
            [self.navigationController popViewControllerAnimated:YES];
        }
    } else {
        NSString *song = self.songTextField.text;
        NSString *artist = self.artistTextField.text;
        NSString *lyrics = self.lyricsTextView.text;
        [self.songController createWithTitle:title artist:artist lyrics:lyrics rating:rating.integerValue];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (IBAction)search:(UIButton *)sender {
}

- (IBAction)ratingStepper:(UISegmentedControl *)sender {
    NSString *title = self.songTextField.text;
    NSString *artist = self.artistTextField.text;
    [self.songController fetchSongLyricsWithTitle:title artist:artist completionHandler:^(NSString *lyrics, NSError *error) {
        if (error) {
            NSLog(@"Error fetching song lyrics: %@", error);
            return;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            self.lyricsTextView.text = lyrics;
            self.searchButton.hidden = YES;
        });
    }];
}
@end
