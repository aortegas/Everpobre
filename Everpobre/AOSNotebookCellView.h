//
//  AOSNotebookCellView.h
//  Everpobre
//
//  Created by Alberto on 16/8/16.
//  Copyright © 2016 aortegas.io. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AOSNotebookCellView : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel *nameView;
@property (nonatomic, strong) IBOutlet UILabel *numberOfNotesView;

+(NSString *) cellId;
+(CGFloat) cellHeight;

@end
