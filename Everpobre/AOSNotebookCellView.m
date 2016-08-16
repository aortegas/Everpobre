//
//  AOSNotebookCellView.m
//  Everpobre
//
//  Created by Alberto on 16/8/16.
//  Copyright © 2016 aortegas.io. All rights reserved.
//

#import "AOSNotebookCellView.h"

@implementation AOSNotebookCellView

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}


#pragma mark - Class Methods
+(NSString *) cellId {
    // Devolvemos el nombre de nuestra propia clase.
    return NSStringFromClass(self);
}

+(CGFloat) cellHeight {
    return 60.0f;
}

@end
