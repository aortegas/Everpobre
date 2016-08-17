//
//  AOSNotesViewController.h
//  Everpobre
//
//  Created by Alberto on 17/8/16.
//  Copyright © 2016 aortegas.io. All rights reserved.
//

#import "AOSCoreDataTableViewController.h"
@class AOSNotebook;

@interface AOSNotesViewController : AOSCoreDataTableViewController

-(id) initWithNotebook:(AOSNotebook *)notebook;

@end


