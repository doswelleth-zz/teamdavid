//
//  DODSongTableViewController.m
//  TeamDavid-Sprint-8
//
//  Created by David Doswell on 12/27/18.
//  Copyright © 2018 David Doswell. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "DODSongTableViewController.h"
#import "DODSongDetailViewController.h"
#import "DODSongController.h"
#import "DODSong.h"

@class DODSongDetailViewController;

@interface DODSongsTableViewController ()

@property DODSongController *songController;
@property NSFetchedResultsController *frc;

@end

@implementation DODSongsTableViewController

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        _songController = [[DODSongController alloc] init];
        _frc = [self createFRC];
        NSError *error;
        __unused BOOL success = [_frc performFetch:&error];
        _frc.delegate = self;
    }
    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _songController = [[DODSongController alloc] init];
        _frc = [self createFRC];
        NSError *error;
        __unused BOOL success = [_frc performFetch:&error];
        _frc.delegate = self;
    }
    return self;
}

- (NSFetchedResultsController *)createFRC {
    NSManagedObjectContext *context = self.songController.moc;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"SMFSong"];
    NSSortDescriptor *titleDescriptor = [[NSSortDescriptor alloc] initWithKey:@"title" ascending:YES];
    NSSortDescriptor *ratingDescriptor = [[NSSortDescriptor alloc] initWithKey:@"rating" ascending:YES];
    [fetchRequest setSortDescriptors:@[ratingDescriptor, titleDescriptor]];
    
    return [[NSFetchedResultsController alloc]
            initWithFetchRequest:fetchRequest
            managedObjectContext:context
            sectionNameKeyPath:@"rating"
            cacheName:nil];
    
    
}

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView beginUpdates];
}
- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex]
                          withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex]
                          withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeMove:
            break;
        case NSFetchedResultsChangeUpdate:
            break;
    }
}
- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath {
    
    UITableView *tableView = self.tableView;
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeUpdate:
            [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:5];
            break;
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}
- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView endUpdates];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.frc.sections.count;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.frc.sections[section].name;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.frc.sections[section].numberOfObjects;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    DODSong *song = [self.frc objectAtIndexPath:indexPath];
    cell.textLabel.text = song.title;
    cell.detailTextLabel.text = song.artist;
    
    return cell;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        DODSong *song = [self.frc objectAtIndexPath:indexPath];
        [self.songController deleteSong:song];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    SMFSongDetailViewController *destinationVC = segue.destinationViewController;
    destinationVC.songController = self.songController;
    
    if ([segue.identifier  isEqualToString: @"ShowSongDetail"]) {
        NSIndexPath *indexPath = self.tableView.indexPathForSelectedRow;
        destinationVC.song = [self.frc objectAtIndexPath:indexPath];
    }
}


@end
