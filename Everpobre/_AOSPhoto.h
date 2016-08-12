// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to AOSPhoto.h instead.

@import CoreData;

extern const struct AOSPhotoAttributes {
	__unsafe_unretained NSString *imageData;
} AOSPhotoAttributes;

extern const struct AOSPhotoRelationships {
	__unsafe_unretained NSString *notes;
} AOSPhotoRelationships;

@class AOSNote;

@interface AOSPhotoID : NSManagedObjectID {}
@end

@interface _AOSPhoto : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) AOSPhotoID* objectID;

@property (nonatomic, strong) NSData* imageData;

//- (BOOL)validateImageData:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSSet *notes;

- (NSMutableSet*)notesSet;

@end

@interface _AOSPhoto (NotesCoreDataGeneratedAccessors)
- (void)addNotes:(NSSet*)value_;
- (void)removeNotes:(NSSet*)value_;
- (void)addNotesObject:(AOSNote*)value_;
- (void)removeNotesObject:(AOSNote*)value_;

@end

@interface _AOSPhoto (CoreDataGeneratedPrimitiveAccessors)

- (NSData*)primitiveImageData;
- (void)setPrimitiveImageData:(NSData*)value;

- (NSMutableSet*)primitiveNotes;
- (void)setPrimitiveNotes:(NSMutableSet*)value;

@end
