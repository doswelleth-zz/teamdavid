//
//  DODSongController.h
//  TeamDavid-Sprint-8
//
//  Created by David Doswell on 12/26/18.
//  Copyright © 2018 David Doswell. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NSManagedObjectContext;
@class DODSong;

NS_ASSUME_NONNULL_BEGIN

@interface DODSongController : NSObject

@property (nonatomic, readonly) NSArray *songs;
@property (nonatomic, readonly) NSString *song;

- (void)fetchSongsWithTitle:(NSString *)title artist:(NSString *)artist completion:(void (^)(DODSong *songs, NSError *))completion;
- (void)persistSongToLocalStore:(DODSong *)song completion:(void (^)(NSError *))completion;
- (void)updateSongsInLocalStore:(DODSong *)song completion:(void (^)(NSError *))completion;
- (void)fetchSongsFromLocalStore:(void (^)(NSError *))completion;

@end

NS_ASSUME_NONNULL_END
