//
//  AOSNotesTableViewController.h
//  Everpobre
//
//  Created by Alberto on 19/8/16.
//  Copyright © 2016 aortegas.io. All rights reserved.
//

//////////////////////////////////////////////////////
// IMPORTANTE: Este ViewController ya no se utiliza //
// Se utiliza el de las collections.                //
//////////////////////////////////////////////////////

#import "AOSCoreDataTableViewController.h"
@class AOSNotebook;

@interface AOSNotesTableViewController : AOSCoreDataTableViewController

-(id) initWithNotebook:(AOSNotebook *)notebook;

@end
