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
    
    int row = touchPosition.y / _cellHeight;
    
    int column = touchPosition.x / _cellWidth;
    
    creature = _gridArray[row][column];
    
    return creature;

}

- (BOOL)isIndexValidForX:(int)x andY:(int)y
   {
       BOOL isIndexValid = YES;
       if(x < 0 || y < 0 || x >= GRID_ROWS || y >= GRID_COLUMNS)
       {
           isIndexValid = NO;
       }
       return isIndexValid;
   }



-(void)evolveStep
{
    // update each Creature's neighbour count
    [self countNeighbors];
    
    // update each creature's state
    [self updateCreatures];
    
    // update the generation so the labels's text will display the correct generation
    _generation++;
    

}

- (void)updateCreatures;
{
    _totalAlive = 0;
    
    for ( int i = 0; i < [_gridArray count]; i++)
    {
        for ( int j = 0; j < [_gridArray count]; j++ )
        {
            Creature *currentCreature = _gridArray[i][j];
            if (currentCreature.livingNeighbors == 3)
            {
                currentCreature.isAlive = YES;
            }
            else if ( (currentCreature.livingNeighbors <=1) || (currentCreature.livingNeighbors >=4))
            {
                currentCreature.isAlive = NO;
            }
            if (currentCreature.isAlive)
            {
                _totalAlive++;
            }
        }
    }
}

- (void)countNeighbors;
{

// iterate through the rows
// note that NSArray has a method called 'count' that will return the number of elements
for (int i = 0; i < [_gridArray count]; i++)
{
    // iterate through all the columns for a given row
    for (int j = 0; j < [_gridArray[i] count]; j++)
    {
        // access the creature in the cell that corresponds to the current row / column
        Creature *currentCreature = _gridArray[i][j];
        
        // remember that every creature has a 'livingneighbors' property that we created
        currentCreature.livingNeighbors = 0;
        
        // now examine every cell around the current one
        
        // go othrough the row on top of the current cell, the row the cell is in and the
        for (int x = (i-1); x <= (i+1); x++)
            
            // go through the coulmn to the left of the current cell, the couln the cell
            for (int y = (j-1); y <= (j+1); y++)
        {
            // check that the cell we're checking isn't off the screen
            BOOL isIndexValid;
            isIndexValid = [self isIndexValidForX:x andY:y];
            
            // skip over all cells that are off screen and the the cell that contains the creature
            if (!((x == i) && (y == j)) && isIndexValid)
            {
                Creature *neighbor = _gridArray[x][y];
                if (neighbor.isAlive)
                {
                    currentCreature.livingNeighbors += 1;
                    
            }
        }
    }
}
}
}
@end
