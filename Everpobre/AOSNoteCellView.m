//
//  AOSNoteCellView.m
//  Everpobre
//
//  Created by Alberto on 19/8/16.
//  Copyright © 2016 aortegas.io. All rights reserved.
//

#import "AOSNoteCellView.h"
#import "AOSNote.h"
#import "AOSPhoto.h"

@interface AOSNoteCellView ()

@property (strong, nonatomic) AOSNote* note;

@end

@implementation AOSNoteCellView

// IMPORTANTE: Nos saltamos el MVC y hacemos que la esta vista de la collection este observando los cambios en el modelo.
// En cuanto cambie cualquier dato de la nota, mediante KVO aplicamos notificaciones para actulizar los datos de la collection.
+(NSArray *) keys {
    return @[@"title", @"modificationDate", @"photo.image"];
}

-(void) syncWithNote {
    
    self.titleView.text  = self.note.name;
    
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.dateStyle = NSDateFormatterMediumStyle;
    self.modificationDateView.text = [dateFormatter stringFromDate:self.note.modificationDate];

    UIImage *img;
    if (self.note.photo.image != nil) {
        img = self.photoView.image = self.note.photo.image;
        self.photoView.image = img;
    }
}


#pragma mark - KVO
-(void) observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSString *,id> *)change
                       context:(void *)context {
    
    // Sincronizamos el valor de todas las propiedades de la nota, solo que cambie algun dato de esta.
    [self syncWithNote];
}

-(void) observeNote:(AOSNote *) note {
    
    // Guardamos la nota que nos pasan en la propiedad.
    self.note = note;
    
    // Observar ciertas propiedades de la nota.
    for (NSString *key in [AOSNoteCellView keys]) {
        [self.note addObserver:self forKeyPath:key options:NSKeyValueObservingOptionNew context:NULL];
    }
    
    [self syncWithNote];
}

-(void) prepareForReuse {
    
    self.note = nil;
    
    // Sincronizamos con valores nulos.
    [self syncWithNote];
}

@end
