//
//  Grid.m
//  GameOfLife
//
//  Created by Richard Tubbs on 02/07/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Grid.h"
#import "Creature.h"

// these are variables that cannot be changed

static const int GRID_ROWS = 8;
static const int GRID_COLUMNS = 10;

@implementation Grid {
    
    NSMutableArray *_gridArray;
    float _cellWidth;
    float _cellHeight;
}

- (void)onEnter
{
    [super onEnter];
    
    [self setupGrid];
    
    //accepts touches on the grid
    
    self.userInteractionEnabled = YES;
}

- (void)setupGrid
{
    //divide the grid's size by the number of columns / rows to figure out the reight wi
    _cellWidth = self.contentSize.width / GRID_COLUMNS;
    _cellHeight = self.contentSize.height / GRID_ROWS;
    
    float x = 0;
    float y = 0;
    
    
    // initalise the array as a blank NSMutableArray
    
    _gridArray = [NSMutableArray array];
    
    // initialise Creatures
    
    for (int i = 0; i < GRID_ROWS; i++) {
        // this is how you create two dimensional arrays in Obj-. You put arrays
        _gridArray[i] = [NSMutableArray array];
        x = 0;
        
        for (int j = 0; j < GRID_COLUMNS; j++) {
            Creature *creature = [[Creature alloc] initCreature];
            creature.anchorPoint = ccp(0, 0);
            creature.position = ccp(x, y);
            [self addChild:creature];
            
            //this is shorthand to access an array inside an array
            _gridArray[i][j] = creature;
            
            // make creatures visible to test this methos, remove this once we know we have
            
            // creature.isAlive = YES;
            
            x+=_cellWidth;
        }
        
        y += _cellHeight;
    }
}

- (void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    // get the x,y coordinates of the touch
    CGPoint touchLocation = [touch locationInNode:self];
    
    // get the creature at that location
    Creature *creature = [self creatureForTouchPosition:touchLocation];
    
    //invert its state - kill if it is alive, bring to life if dead
    
    creature.isAlive = !creature.isAlive;

}

- (Creature *)creatureForTouchPosition:(CGPoint)touchPosition
{
    // get the row and column that was touched, return the Creature inside the corresponding
    
    NSInteger(row) = touchPosition.y / _cellHeight;
    
    NSInteger(column) = touchPosition.x / _cellWidth;
    
    return _gridArray[row][column];

}

@end
