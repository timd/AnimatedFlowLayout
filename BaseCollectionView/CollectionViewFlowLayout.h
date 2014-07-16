//
//  CollectionViewFlowLayout.h
//  BaseCollectionView
//
//  Created by Tim on 16/07/14.
//  Copyright (c) 2014 Charismatic Megafauna Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionViewFlowLayout : UICollectionViewFlowLayout

-(id)initWithCellSize:(CGSize)cellSize;
@property (nonatomic) CGSize cellSize;

@end
