//
//  AOSPhotoViewController.h
//  Everpobre
//
//  Created by Alberto on 24/8/16.
//  Copyright © 2016 aortegas.io. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AOSDetailViewController.h"

@interface AOSPhotoViewController : UIViewController <AOSDetailViewController>

@property (weak, nonatomic) IBOutlet UIImageView *photoView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityView;

- (IBAction)takePhoto:(UIBarButtonItem *)sender;
- (IBAction)deletePhoto:(UIBarButtonItem *)sender;
- (IBAction)applyVintageEffect:(id)sender;
- (IBAction)zoomToFace:(id)sender;

@end
