#import "AOSNote.h"

@interface AOSNote ()

+(NSArray *)observableKeyNames;

@end

@implementation AOSNote

#pragma mark - Class Methods.
+(instancetype) noteWithName:(NSString *)name
                    noteBook:(AOSNotebook *)notebook
                     context:(NSManagedObjectContext *)context {
    
    AOSNote *note = [NSEntityDescription insertNewObjectForEntityForName:[AOSNote entityName]
                                                  inManagedObjectContext:context];
    
    note.name = name;
    note.creationDate = [NSDate date];
    note.modificationDate = [NSDate date];
    note.notebook = notebook;
    return note;
}

+(NSArray *) observableKeyNames {
    
    return @[@"name", @"creationDate", @"notebook", @"photo"];
}

@end
