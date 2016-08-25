//
//  AOSNotesViewController.h
//  Everpobre
//
//  Created by Alberto on 19/8/16.
//  Copyright © 2016 aortegas.io. All rights reserved.
//

#import "AOSCoreDataCollectionViewController.h"
#import "AOSNoteViewController.h"
@class AOSNotebook;

@interface AOSNotesViewController : AOSCoreDataCollectionViewController 

@property (nonatomic, strong) AOSNotebook *notebook;

-(void) back:(AOSNoteViewController *)vc;

@end
