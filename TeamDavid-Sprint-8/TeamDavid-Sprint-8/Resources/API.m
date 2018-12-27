//
//  API.m
//  TeamDavid-Sprint-8
//
//  Created by David Doswell on 12/27/18.
//  Copyright © 2018 David Doswell. All rights reserved.
//

#import "API.h"

@implementation API

- (instancetype)init:(NSString *)api;
{
    self = [super init];
    if (self) {
        self.api = api;
    }
    return self;
}

@end
