//
//  AOSEntityObserver.h
//  Everpobre
//
//  Created by Alberto on 17/8/16.
//  Copyright © 2016 aortegas.io. All rights reserved.
//
//
//  CAMBIOS EN OBJETOS RELACIONADOS
//
//  Si estás observando la clase AGTJedi que tiene una propiedad lightSabre que
//  apunta a un AGTLightSabre y este último cambia, NO se enviará el mensaje
//  de cambio al delegado, puesto que sólo se observa a AGTLighTSabre.
//
//  ¡¡ NO LLAMES A SAVE EN LOS MÉTODOS DE DELEGADO!!
//
//  La notificación NSManagedObjectContextObjectsDidChangeNotification, en la
//  que se basa esta clase, se envía cuando el contexto recibe el mensaje
//  `processPendingChanges`. Esto se hace cada vez que se termina el RunLoop.
//  Uséase:
//      * por un lado, la notificación se recibirá pasado un cierto tiempo
//      después de haber llevado a cabo la modificación de los objetos.
//
//      * además, las notificaciones se consolidan y si creas un objeto y
//      luego lo cambias, solo recibirás un aviso de creación ya con el nuevo valor
//
//  `processPendingChanges` envía la notificación cuando todavía no es
//  seguro guardar. NO envies el mensaje save al contexto desde ninguno
//  de los métodos de delegado de esta clase, o provocarás una fermosa
//  recursión infinita.
//
//  Si te es vital guardar después de uno de estos métodos, hazlo de forma aplazada,
//  mediante GCD o el mensaje performSelector:withObject:afterDelay: para que se haga
//  en la siguiente vuelta del RunLoop.
//
#import <Foundation/Foundation.h>
@import CoreData;

@class AOSEntityObserver;

@protocol AOSEntityObserverDelegate <NSObject>
@optional
-(void) entityObserver:(AOSEntityObserver *) observer didUpdateObjects:(NSSet*) objects;
-(void) entityObserver:(AOSEntityObserver *) observer didDeleteObjects:(NSSet*) objects;
-(void) entityObserver:(AOSEntityObserver *) observer didInsertObjects:(NSSet*) objects;


@end

@interface AOSEntityObserver : NSObject

@property (weak,nonatomic) id<AOSEntityObserverDelegate> delegate;

+(instancetype) entityObserverWithEntityDescription:(NSEntityDescription *) description
                             inManagedObjectContext:(NSManagedObjectContext *)context;

+(instancetype) entityObserverWithEntityName:(NSString *) name
                      inManagedObjectContext:(NSManagedObjectContext *)context;

-(id) initWithEntityDescription:(NSEntityDescription *) description
         inManagedObjectContext:(NSManagedObjectContext *)context;


-(id) initWithEntityEntityName:(NSString *) name
        inManagedObjectContext:(NSManagedObjectContext *)context;


-(void) startObserving;
-(void) stopObserving;

@end
