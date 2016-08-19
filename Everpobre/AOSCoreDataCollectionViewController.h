//
//  AOSCoreDataCollectionViewController.h
//  Everpobre
//
//  Created by Alberto on 17/8/16.
//  Copyright © 2016 aortegas.io. All rights reserved.
//

#import <UIKit/UIKit.h>
@import CoreData;

@interface AOSCoreDataCollectionViewController : UICollectionViewController

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;

+(instancetype) coreDataCollectionViewControllerWithFetchedResultsController:(NSFetchedResultsController *) resultsController
                                                                      layout:(UICollectionViewLayout*) layout;

-(id) initWithFetchedResultsController:(NSFetchedResultsController *) resultsController
                                layout:(UICollectionViewLayout*) layout;

@end
