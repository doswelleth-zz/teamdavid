//
//  DODSong.h
//  TeamDavid-Sprint-8
//
//  Created by David Doswell on 12/26/18.
//  Copyright © 2018 David Doswell. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface DODSong : NSObject

-(instancetype)initWithTitle:(NSString *)title artist:(NSString *)artist song:(NSString *)song rating:(NSInteger)rating context:(NSManagedObjectContext *)context;

@property NSString *title;
@property NSString *artist;
@property NSString *song;
@property NSInteger rating;

@end

NS_ASSUME_NONNULL_END
