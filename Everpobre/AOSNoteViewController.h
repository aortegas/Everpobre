//
//  AOSNoteViewController.h
//  Everpobre
//
//  Created by Alberto on 19/8/16.
//  Copyright © 2016 aortegas.io. All rights reserved.
//

@import UIKit;
@import MapKit;
#import "AOSDetailViewController.h"
@class AOSNote;
@class AOSNotebook;
@class AOSNoteViewController;

@interface AOSNoteViewController : UIViewController <AOSDetailViewController>

@property (weak, nonatomic) IBOutlet UILabel *modificationDateView;
@property (weak, nonatomic) IBOutlet UITextField *nameView;
@property (weak, nonatomic) IBOutlet UIImageView *photoView;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UITextView *textView;

-(id)initForNewNoteInNotebook:(AOSNotebook *) notebook;

@end
