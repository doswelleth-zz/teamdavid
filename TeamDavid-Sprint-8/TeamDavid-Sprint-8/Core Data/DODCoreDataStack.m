//
//  DODCoreDataStack.m
//  TeamDavid-Sprint-8
//
//  Created by David Doswell on 12/26/18.
//  Copyright © 2018 David Doswell. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "DODCoreDataStack.h"

@implementation DODCoreDataStack

- (instancetype)init
{
    self = [super init];
    if (self) {
        _container = [[NSPersistentContainer alloc] initWithName:@"Song"];
        [_container loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *d, NSError *error) {
            if (error != nil) {
                [NSException raise:@"UnloadedPersistentStore" format:@"Failed to load persistent stores: %@", error];
            }
        }];
        _container.viewContext.automaticallyMergesChangesFromParent = YES;
    }
    return self;
}

@end
