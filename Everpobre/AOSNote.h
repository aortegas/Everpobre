#import "_AOSNote.h"

@interface AOSNote : _AOSNote {}

#pragma mark - Class Methods.
+(instancetype) noteWithName:(NSString *)name
                    noteBook:(AOSNotebook *)notebook
                     context:(NSManagedObjectContext *)context;

@end
