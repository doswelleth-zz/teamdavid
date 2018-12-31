//
//  DODPokedexTableViewController.m
//  TeamDavid-Sprint-9
//
//  Created by David Doswell on 12/31/18.
//  Copyright © 2018 David Doswell. All rights reserved.
//

#import "DODPokedexTableViewController.h"
#import "DODPokemonDetailViewController.h"
#import "DODPokemon.h"
#import "TeamDavid_Sprint_9-Swift.h"


@interface DODPokedexTableViewController ()

@property DODPokemonController *pokemonController;
@property NSArray<DODPokemon *> *pokemons;

@end

@implementation DODPokedexTableViewController


- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        _pokemonController = [DODPokemonController sharedController];
    }
    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _pokemonController = [DODPokemonController sharedController];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.pokemonController fetchAllPokemonWithCompletion:^(NSArray<DODPokemon *> *pokemons, NSError *error) {
        self.pokemons = pokemons;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.pokemons.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    DODPokemon *pokemon = self.pokemons[indexPath.row];
    cell.textLabel.text = pokemon.name;
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString: @"showDetail"]) {
        DODPokemonDetailViewController *destination = segue.destinationViewController;
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        DODPokemon *pokemon = self.pokemons[indexPath.row];
        destination.pokemonController = [DODPokemonController sharedController];
        destination.pokemon = pokemon;
    }
}

@end
