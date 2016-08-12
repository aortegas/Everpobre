//
//  AppDelegate.m
//  Everpobre
//
//  Created by Alberto on 11/8/16.
//  Copyright © 2016 aortegas.io. All rights reserved.
//

#import "AppDelegate.h"
#import "AOSSimpleCoreDataStack.h"

#import "AOSNotebook.h"
#import "AOSNote.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // Crear una instancia del stack de Core Data
    self.model = [AOSSimpleCoreDataStack coreDataStackWithModelName:@"Model"];
    
    [self trastearConDatos];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    [self save];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [self save];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


#pragma mark - Utils
-(void) trastearConDatos{
    
    AOSNotebook *libreta = [AOSNotebook notebookWithName:@"Libreta de prueba"
                                                 context:self.model.context];
    
    [AOSNote noteWithName:@"Nota1"
                 noteBook:libreta
                  context:self.model.context];
    
    [AOSNote noteWithName:@"Nota2"
                 noteBook:libreta
                  context:self.model.context];

    [self save];
    
    // Crear una nota
    //NSManagedObject *note = [NSEntityDescription insertNewObjectForEntityForName:@"Note"
    //                                                      inManagedObjectContext:self.model.context];
    
    // Asignamos valores a las propiedads mediante KVC
    //[note setValue:@"WWDC" forKey:@"name"];
    //[note setValue:[NSDate date] forKey:@"creationDate"];
    
    //NSLog(@"%@", note);
}

-(void) save {
    
    // __func__ devolveria el nombre del metodo, es decir, AppDelegate save.
    [self.model saveWithErrorBlock:^(NSError *error) {
        NSLog(@"Error al guardar %s \n\n %@", __func__, error);
    }];
}

@end
