//
//  DODSongController.m
//  TeamDavid-Sprint-8
//
//  Created by David Doswell on 12/26/18.
//  Copyright © 2018 David Doswell. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "DODSongController.h"

@class DODCoreDataStack;
@class DODSong;

@interface DODSongController ()

@property NSMutableArray *internalSongs;
@property NSString *internalFilePath;

@end

@implementation DODSongController

- (instancetype)init
{
    self = [super init];
    if (self) {
        _internalSongs = [[NSMutableArray alloc] init];
    }
    return self;
}

// MARK: - Public methods

- (void)fetchSongsWithTitle:(NSString *)title artist:(NSString *)artist completion:(void (^)(DODSong *song, NSError *))completion
{
    NSURL *baseURL = [NSURL URLWithString:baseUrlString];
    
    NSURLComponents *components = [NSURLComponents componentsWithURL:baseURL resolvingAgainstBaseURL:YES];
    NSURLQueryItem *artistQueryItem = [NSURLQueryItem queryItemWithName:@"q_artist" value:artist];
    NSURLQueryItem *trackQueryItem = [NSURLQueryItem queryItemWithName:@"q_track" value:title];
    [components setQueryItems:@[artistQueryItem, trackQueryItem]];
    
    NSURL *requestURL = [components URL];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:requestURL];
    [request setValue:apiKey forHTTPHeaderField:@"X-Mashape-Key"];
    
    [[NSURLSession.sharedSession dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Error fetching data: %@", error);
            completion(nil, error);
            return;
        }
        
    }] resume];
}

- (void)fetchSongsFromLocalStore:(void (^)(NSError *))completion
{
    if([[NSFileManager defaultManager] fileExistsAtPath:self.internalFilePath])
    {
        NSData *data = [[NSFileManager defaultManager] contentsAtPath:self.internalFilePath];
        DODSong *fetchedSongs = [NSKeyedUnarchiver unarchivedObjectOfClass: [NSArray class] fromData:data error:nil];
        [self.internalSongs addObject:fetchedSongs];
    }
    else
    {
        NSLog(@"File not exits");
    }
}

- (void)persistSongToLocalStore:(DODSong *)song completion:(void (^)(NSError *))completion;
{
    if (![[NSFileManager defaultManager] fileExistsAtPath:self.internalFilePath]) {
        NSData *songData = [NSKeyedArchiver archivedDataWithRootObject:song requiringSecureCoding:NO error:NULL];
        [songData writeToFile:self.internalFilePath atomically:YES];
    }
}

- (void)updateSongsInLocalStore:(DODSong *)song completion:(void (^)(NSError * _Nonnull))completion
{
    
    // TODO Before Jan. 2
}


- (NSArray *)songs
{
    return [_internalSongs copy];
}

- (void)setFilePath:(NSString *)internalFilePath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filePath = [NSString stringWithFormat:@"%@/%@", documentsDirectory, @"songs"];
    self.internalFilePath = filePath;
}

static NSString * const baseUrlString = @"https://musixmatchcom-musixmatch.p.mashape.com/wsr/1.1/artist.get";
static NSString * const apiKey = @"t1b8XlSgBFmshQvFmX7jTixPqpt5p1fv59wjsn6ATQ6Xu9DD7h";


@end
