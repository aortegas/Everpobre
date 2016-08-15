#import "AOSNotebook.h"

@interface AOSNotebook ()

+(NSArray *)observableKeyNames;

@end

@implementation AOSNotebook

#pragma mark - Class Methods.
+(instancetype) notebookWithName:(NSString *)name
                         context:(NSManagedObjectContext *)context {
    
    AOSNotebook *noteBook = [NSEntityDescription insertNewObjectForEntityForName:[AOSNotebook entityName]
                                                          inManagedObjectContext:context];
    
    noteBook.name = name;
    noteBook.creationDate = [NSDate date];
    noteBook.modificationDate = [NSDate date];
    return noteBook;
}

+(NSArray *) observableKeyNames {
    
    return @[@"creationDate", @"name", @"notes"];
}

@end
