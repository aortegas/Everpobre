// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to AOSNote.m instead.

#import "_AOSNote.h"

const struct AOSNoteAttributes AOSNoteAttributes = {
	.text = @"text",
};

const struct AOSNoteRelationships AOSNoteRelationships = {
	.notebook = @"notebook",
	.photo = @"photo",
};

@implementation AOSNoteID
@end

@implementation _AOSNote

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Note" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Note";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Note" inManagedObjectContext:moc_];
}

- (AOSNoteID*)objectID {
	return (AOSNoteID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic text;

@dynamic notebook;

@dynamic photo;

@end

