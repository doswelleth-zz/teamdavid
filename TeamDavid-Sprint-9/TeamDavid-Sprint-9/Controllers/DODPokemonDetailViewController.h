//
//  DODPokemonDetailViewController.h
//  TeamDavid-Sprint-9
//
//  Created by David Doswell on 12/31/18.
//  Copyright © 2018 David Doswell. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class DODPokemon;
@class DODPokemonController;

@interface DODPokemonDetailViewController : UIViewController

@property (nonatomic, nullable) DODPokemon *pokemon;
@property (nullable) DODPokemonController *pokemonController;

@end

NS_ASSUME_NONNULL_END
