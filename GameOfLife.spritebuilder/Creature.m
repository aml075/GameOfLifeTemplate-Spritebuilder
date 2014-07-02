//
//  Creature.m
//  GameOfLife
//
//  Created by Richard Tubbs on 02/07/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Creature.h"

@implementation Creature

- (instancetype)initCreature {
    // since we made Creature inherit from CCSprite, 'super' below refers to CCSprite
    self = [super initWithImageNamed:@"GameOfLifeAssets/Assets/bubble.png"];
    
    if(self) {
        self.isAlive = NO;
    }
    
    return self;
}

- (void)setIsALive:(BOOL)newState {
    // when you create an @property as we did inthe .h, an instance variable with a lea
    _isAlive = newState;
    
    // 'visible' is a property of any class that inherits from CCNode. CCSprite is a su
    self.visible = _isAlive;
}

@end
