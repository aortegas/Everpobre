//
//  UIViewController+Navigation.m
//  Everpobre
//
//  Created by Alberto on 16/8/16.
//  Copyright © 2016 aortegas.io. All rights reserved.
//

#import "UIViewController+Navigation.h"

@implementation UIViewController (Navigation)

-(UINavigationController *) wrapperInNavigation {

    // Creamos un UINavigationController y nos metemos como UIViewController (self) dentro de él.
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:self];
    
    // Devolvemos el UINavigationController.
    return nav;
}

@end
