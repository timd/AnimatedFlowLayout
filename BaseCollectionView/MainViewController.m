//
//  ViewController.m
//  BaseCollectionView
//
//  Created by Tim on 16/07/14.
//  Copyright (c) 2014 Charismatic Megafauna Ltd. All rights reserved.
//

#import "MainViewController.h"
#import "BaseCollectionViewCell.h"
#import "CollectionViewFlowLayout.h"

@interface MainViewController ()
@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) CollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) UIImageView *blob;
@property (nonatomic, strong) NSIndexPath *originalIndexPath;
@property (nonatomic, strong) NSString *movingItem;
@end

@implementation MainViewController

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupData];
    
    [self setupCollectionView];
    
    [self setupPanHandler];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark Setup methods

- (void)setupData {
    NSMutableArray *tempArray = [[NSMutableArray alloc] initWithCapacity:50];
    for (int count = 0; count < 25; count++) {
        [tempArray addObject:[NSString stringWithFormat:@"Item %d", count]];
    }
    
    self.dataArray = tempArray;
}

- (void)setupCollectionView {
    [self.collectionView registerClass:[BaseCollectionViewCell class] forCellWithReuseIdentifier:@"CellIdentifier"];
    
    self.flowLayout = [[CollectionViewFlowLayout alloc] initWithCellSize:CGSizeMake(100.0f, 100.0f)];
    [self.collectionView setCollectionViewLayout:self.flowLayout];
    
    [self.collectionView setContentInset:UIEdgeInsetsMake(10.0f, 10.0f, 10.0f, 10.0f)];
}

- (void)setupPanHandler {
    
    UIPanGestureRecognizer *pgr = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    [pgr setDelaysTouchesBegan:YES];
    [self.collectionView addGestureRecognizer:pgr];
    
}

#pragma mark - UICollectionView methods

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.dataArray count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BaseCollectionViewCell *cell = (BaseCollectionViewCell *)[self.collectionView dequeueReusableCellWithReuseIdentifier:@"CellIdentifier" forIndexPath:indexPath];
    
    cell.contentString = [self.dataArray objectAtIndex:indexPath.row];
    [cell prepareForReuse];
    
    return cell;
}

#pragma mark -
#pragma mark Interaction methods

-(IBAction)didTapAddItemButton:(id)sender {

    // Create new item and add it to the data model
    NSInteger lastItemIndex = [self.dataArray count];
    NSString *itemString = [NSString stringWithFormat:@"Item %d", lastItemIndex];
    [self.dataArray addObject:itemString];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:lastItemIndex inSection:0];
    [self.collectionView insertItemsAtIndexPaths:@[indexPath]];
    
    
}

-(IBAction)didTapAddRemoveButton:(id)sender {
    
    // Prevent attempting to remove an item from an empty array!
    if ([self.dataArray count] == 0) {
        return;
    }

    // Remove the last item from the data model
    [self.dataArray removeLastObject];

    // Get the index path of the item that will be removed
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:self.dataArray.count inSection:0];

    // update the table view
    [self.collectionView deleteItemsAtIndexPaths:@[indexPath]];
    
}

-(void)handlePan:(UIPanGestureRecognizer *)pgr {
    
    CGPoint locationPoint = [pgr locationInView:self.collectionView];
    
    if (pgr.state == UIGestureRecognizerStateBegan) {

        self.originalIndexPath = [self.collectionView indexPathForItemAtPoint:locationPoint];
        BaseCollectionViewCell *cell = (BaseCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:self.originalIndexPath];
        
        UIGraphicsBeginImageContext(cell.bounds.size);
        [cell.layer renderInContext:UIGraphicsGetCurrentContext()];
        UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        self.blob = [[UIImageView alloc] initWithImage:viewImage];
        [self.blob setAlpha:0.75f];
        [self.blob setCenter:locationPoint];
        [self.collectionView addSubview:self.blob];
        
    }

    if (pgr.state == UIGestureRecognizerStateEnded) {
        [self.blob removeFromSuperview];
    }
    

    if (pgr.state == UIGestureRecognizerStateChanged) {
        [self.blob setCenter:locationPoint];
    }
    
}


@end
