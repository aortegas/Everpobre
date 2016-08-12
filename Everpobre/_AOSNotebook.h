// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to AOSNotebook.h instead.

@import CoreData;
#import "AOSNamedEntity.h"

extern const struct AOSNotebookRelationships {
	__unsafe_unretained NSString *notes;
} AOSNotebookRelationships;

@class AOSNote;

@interface AOSNotebookID : AOSNamedEntityID {}
@end

@interface _AOSNotebook : AOSNamedEntity {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) AOSNotebookID* objectID;

@property (nonatomic, strong) NSSet *notes;

- (NSMutableSet*)notesSet;

@end

@interface _AOSNotebook (NotesCoreDataGeneratedAccessors)
- (void)addNotes:(NSSet*)value_;
- (void)removeNotes:(NSSet*)value_;
- (void)addNotesObject:(AOSNote*)value_;
- (void)removeNotesObject:(AOSNote*)value_;

@end

@interface _AOSNotebook (CoreDataGeneratedPrimitiveAccessors)

- (NSMutableSet*)primitiveNotes;
- (void)setPrimitiveNotes:(NSMutableSet*)value;

@end
