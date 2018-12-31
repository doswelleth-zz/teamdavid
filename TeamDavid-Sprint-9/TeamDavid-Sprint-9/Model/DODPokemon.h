//
//  DODPokemon.h
//  TeamDavid-Sprint-9
//
//  Created by David Doswell on 12/30/18.
//  Copyright © 2018 David Doswell. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class UIImage;

@interface DODPokemon : NSObject

- (instancetype)initWithDictionary:(NSDictionary<NSString *, NSString *> *)dictionary;

@property NSString *name;
@property NSURL *url;
@property (readonly, nullable) NSURL *imageURL;
@property (nullable) UIImage *image;
@property (readonly, nullable) NSString *identifier;
@property (readonly, nullable) NSString *abilities;

- (void)updateWithDictionary:(NSDictionary<NSString *, id> *)dictionary;

@end

NS_ASSUME_NONNULL_END
