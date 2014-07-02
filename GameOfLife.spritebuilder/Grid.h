//
//  Grid.h
//  GameOfLife
//
//  Created by Richard Tubbs on 02/07/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "CCSprite.h"

@interface Grid : CCSprite


@property (nonatomic, assign) int totalAlive;
@property (nonatomic, assign) int generation;

@end