#import "_AOSNotebook.h"

@interface AOSNotebook : _AOSNotebook {}

#pragma mark - Class Methods.
+(instancetype) notebookWithName:(NSString *)name
                         context:(NSManagedObjectContext *)context;

@end
