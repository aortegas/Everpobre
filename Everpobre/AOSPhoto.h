#import "_AOSPhoto.h"
@import UIKit;

@interface AOSPhoto : _AOSPhoto {}

#pragma mark - Properties.
@property(nonatomic, strong) UIImage *image;

#pragma mark - Class Methods.
+(instancetype) photoWithImage:(UIImage *)image
                       context:(NSManagedObjectContext *)context;

@end
