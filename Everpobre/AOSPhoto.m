#import "AOSPhoto.h"

@interface AOSPhoto ()

// Private interface goes here.

@end

@implementation AOSPhoto

@synthesize image = _image;

#pragma mark - Properties.
-(void) setImage:(UIImage *)image {
    
    //_image = image;
    self.imageData = UIImagePNGRepresentation(image);
}

-(UIImage *) image {

    //if (_image == nil) {
    //    _image = [UIImage imageWithData:self.imageData];
    //}
    //return _image;
    return [UIImage imageWithData:self.imageData];
}


#pragma mark - Class Methods.
+(instancetype) photoWithImage:(UIImage *)image
                       context:(NSManagedObjectContext *)context {

    AOSPhoto *photo = [NSEntityDescription insertNewObjectForEntityForName:[AOSPhoto entityName]
                                                    inManagedObjectContext:context];
    
    //photo.imageData = UIImagePNGRepresentation(image);
    photo.imageData = UIImageJPEGRepresentation(image, 0.9);
    
    // We register memory notices.
    //[[NSNotificationCenter defaultCenter] addObserver:photo
    //                                         selector:@selector(notifyThatDidReceiveMemoryWarning:)
    //                                             name:UIApplicationDidReceiveMemoryWarningNotification
    //                                           object:nil];
    
    return photo;
}


#pragma mark - Life Cycle.
//-(void) dealloc {
//
//    // We unsubscribe memory notices.
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
//}


#pragma mark - Notifications.
// UIApplicationDidReceiveMemoryWarningNotification
//-(void) notifyThatDidReceiveMemoryWarning: (NSNotification *)notification {
//
//    _image = nil;
//}

@end
