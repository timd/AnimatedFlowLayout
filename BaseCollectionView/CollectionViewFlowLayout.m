//
//  CollectionViewFlowLayout.m
//  BaseCollectionView
//
//  Created by Tim on 16/07/14.
//  Copyright (c) 2014 Charismatic Megafauna Ltd. All rights reserved.
//

#import "CollectionViewFlowLayout.h"

@implementation CollectionViewFlowLayout

-(id)init {
    if (self = [super init]) {
        //
    }
    
    return self;
}

-(id)initWithCellSize:(CGSize)cellSize {
    
    if (self = [super init]) {
        self.itemSize = cellSize;
        self.scrollDirection = UICollectionViewScrollDirectionVertical;
        self.minimumInteritemSpacing = 10.0f;
        self.minimumLineSpacing = 10.0f;
    }
    
    return self;
    
}

-(UICollectionViewLayoutAttributes *)initialLayoutAttributesForAppearingItemAtIndexPath:(NSIndexPath *)itemIndexPath {
    
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:itemIndexPath];
    
    attributes.center = CGPointMake(self.collectionView.bounds.size.width/2, self.collectionView.bounds.size.height);
    attributes.alpha = 0.0f;
    return attributes;
    
}

-(UICollectionViewLayoutAttributes *)finalLayoutAttributesForDisappearingItemAtIndexPath:(NSIndexPath *)itemIndexPath {
    
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:itemIndexPath];
    
    attributes.center = CGPointMake(self.collectionView.bounds.size.width/2, self.collectionView.bounds.size.height);
    attributes.alpha = 0.0f;
    return attributes;
    
}


@end
