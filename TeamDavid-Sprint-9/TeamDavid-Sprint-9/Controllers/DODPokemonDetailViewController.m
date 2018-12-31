//
//  DODPokemonDetailViewController.m
//  TeamDavid-Sprint-9
//
//  Created by David Doswell on 12/31/18.
//  Copyright © 2018 David Doswell. All rights reserved.
//

#import "DODPokemonDetailViewController.h"
#import "DODPokemon.h"
#import "TeamDavid_Sprint_9-Swift.h"

@interface DODPokemonDetailViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *idLabel;
@property (weak, nonatomic) IBOutlet UILabel *abilitiesLabel;

@end

void *KVOContext = &KVOContext;

@implementation DODPokemonDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.pokemonController fillInDetailsFor:_pokemon];
}

- (void)dealloc
{
    [_pokemon removeObserver:self forKeyPath:@"imageView"];
    [_pokemon removeObserver:self forKeyPath:@"identifier"];
    [_pokemon removeObserver:self forKeyPath:@"abilities"];
}

- (void)setPokemon:(DODPokemon *)pokemon
{
    if (_pokemon) {
        [_pokemon removeObserver:self forKeyPath:@"imageView"];
        [_pokemon removeObserver:self forKeyPath:@"identifier"];
        [_pokemon removeObserver:self forKeyPath:@"abilities"];
    }
    
    _pokemon = pokemon;
    
    [_pokemon addObserver:self forKeyPath:@"imageView" options:0 context:KVOContext];
    [_pokemon addObserver:self forKeyPath:@"identifier" options:0 context:KVOContext];
    [_pokemon addObserver:self forKeyPath:@"abilities" options:0 context:KVOContext];
}

- (void)updateViewForImg:(BOOL)img identifier:(BOOL)identifier abilities:(BOOL)abilities
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (img == YES) {
            self.imageView.image = self.pokemon.image;
        }
        if (identifier == YES) {
            self.idLabel.text = [NSString stringWithFormat:@"Id: %@", self.pokemon.identifier];
        }
        if (abilities == YES) {
            self.abilitiesLabel.text = [NSString stringWithFormat:@"Abilities: %@", self.pokemon.abilities];
        }
    });
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (context != KVOContext) {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        return;
    }
    
    BOOL img = NO;
    BOOL identifier = NO;
    BOOL abilities = NO;
    
    if ([keyPath isEqualToString: @"imageView"]) {
        img = YES;
    }
    if ([keyPath isEqualToString: @"identifier"]) {
        identifier = YES;
    }
    if ([keyPath isEqualToString: @"abilities"]) {
        abilities = YES;
    }
    
    [self updateViewForImg:img identifier:identifier abilities:abilities];
}

@end
