//
//  AOSSimpleCoreDataStack.h
//  Everpobre
//
//  Created by Alberto on 11/8/16.
//  Copyright © 2016 aortegas.io. All rights reserved.
//

@import Foundation;
@import CoreData;

@interface AOSSimpleCoreDataStack : NSObject

@property (strong, nonatomic, readonly) NSManagedObjectContext *context;

+ (NSString *)persistentStoreCoordinatorErrorNotificationName;

+ (instancetype)coreDataStackWithModelName:(NSString *)aModelName
                          databaseFilename:(NSString *)aDBName;

+ (instancetype)coreDataStackWithModelName:(NSString *)aModelName;

+ (instancetype)coreDataStackWithModelName:(NSString *)aModelName
                               databaseURL:(NSURL *)aDBURL;

- (id)initWithModelName:(NSString *)aModelName databaseURL:(NSURL *)aDBURL;

- (void)zapAllData;

- (void)saveWithErrorBlock:(void(^)(NSError *error))errorBlock;

- (NSArray *)executeRequest:(NSFetchRequest *)request
                  withError:(void(^)(NSError *error))errorBlock;

@end





