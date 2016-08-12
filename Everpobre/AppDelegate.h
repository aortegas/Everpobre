//
//  AppDelegate.h
//  Everpobre
//
//  Created by Alberto on 11/8/16.
//  Copyright © 2016 aortegas.io. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AOSSimpleCoreDataStack;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) AOSSimpleCoreDataStack *model;

@end

