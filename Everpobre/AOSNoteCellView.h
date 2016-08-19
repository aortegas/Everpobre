//
//  AOSNoteCellView.h
//  Everpobre
//
//  Created by Alberto on 19/8/16.
//  Copyright © 2016 aortegas.io. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AOSNote;

@interface AOSNoteCellView : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *photoView;
@property (weak, nonatomic) IBOutlet UILabel *modificationDateView;
@property (weak, nonatomic) IBOutlet UILabel *titleView;

-(void) observeNote:(AOSNote *) note;

@end
