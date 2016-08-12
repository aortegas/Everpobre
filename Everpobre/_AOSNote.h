// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to AOSNote.h instead.

@import CoreData;
#import "AOSNamedEntity.h"

extern const struct AOSNoteAttributes {
	__unsafe_unretained NSString *text;
} AOSNoteAttributes;

extern const struct AOSNoteRelationships {
	__unsafe_unretained NSString *notebook;
	__unsafe_unretained NSString *photo;
} AOSNoteRelationships;

@class AOSNotebook;
@class AOSPhoto;

@interface AOSNoteID : AOSNamedEntityID {}
@end

@interface _AOSNote : AOSNamedEntity {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) AOSNoteID* objectID;

@property (nonatomic, strong) NSString* text;

//- (BOOL)validateText:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) AOSNotebook *notebook;

//- (BOOL)validateNotebook:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) AOSPhoto *photo;

//- (BOOL)validatePhoto:(id*)value_ error:(NSError**)error_;

@end

@interface _AOSNote (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveText;
- (void)setPrimitiveText:(NSString*)value;

- (AOSNotebook*)primitiveNotebook;
- (void)setPrimitiveNotebook:(AOSNotebook*)value;

- (AOSPhoto*)primitivePhoto;
- (void)setPrimitivePhoto:(AOSPhoto*)value;

@end
