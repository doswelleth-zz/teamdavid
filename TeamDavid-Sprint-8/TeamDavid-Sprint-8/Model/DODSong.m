//
//  DODSong.m
//  TeamDavid-Sprint-8
//
//  Created by David Doswell on 12/26/18.
//  Copyright © 2018 David Doswell. All rights reserved.
//

#import "DODSong.h"

@implementation DODSong

- (instancetype)initWithTitle:(NSString *)title artist:(NSString *)artist song:(NSString *)song rating:(NSInteger)rating context:(NSManagedObjectContext *)context
{
    if (self) {
        self.title = title;
        self.artist = artist;
        self.song = song;
        self.rating = rating;
    }
    return self;
}

@end
