//
//  AOSNotebooksViewController.m
//  Everpobre
//
//  Created by Alberto on 15/8/16.
//  Copyright © 2016 aortegas.io. All rights reserved.
//

#import "AOSNotebooksViewController.h"
#import "AOSNotebook.h"

@interface AOSNotebooksViewController ()

@end

@implementation AOSNotebooksViewController

#pragma mark - View Lifecycle
-(void) viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    self.title = @"Everpobre";
    
    // Creamos boton Add.
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                               target:self
                                                                               action:@selector(addNotebook:)];
    
    // Lo añadimos a la barra de navegacion.
    self.navigationItem.rightBarButtonItem = addButton;
    
    // Añadimos el boton de edicion.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    // Alta en notificacion de sensor de proximidad.
    UIDevice *device = [UIDevice currentDevice];
    if ([self hasProximitySensor]) {
        
        [device setProximityMonitoringEnabled:YES];
        NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
        [notificationCenter addObserver:self selector:@selector(proximityStateDidChange:) name:UIDeviceProximityStateDidChangeNotification object:nil];
    }
}

-(void) viewDidDisappear:(BOOL)animated {

    [super viewDidDisappear:animated];
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    [notificationCenter removeObserver:self];
}


#pragma mark - Actions
-(void) addNotebook:(id)sender{
    
    // Creamos una nueva libreta.
    // Importante, tomamos el contexto del NSFetchedResutlsController.
    [AOSNotebook notebookWithName:@"New Notebook" context:self.fetchedResultsController.managedObjectContext];
}


#pragma mark - Data Source
-(void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
                                            forRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        // Vemos la libreta que se esta queriendo borrar.
        AOSNotebook *notebook = [self.fetchedResultsController objectAtIndexPath:indexPath];
        
        // La eliminamos del modelo.
        [self.fetchedResultsController.managedObjectContext deleteObject:notebook];
    }
}

-(UITableViewCell *) tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellId = @"cellId";
    
    // Averiguar el notebook.
    AOSNotebook *notebook = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    // Crear una celda.
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
    }
    
    // Sincronizar modelo con vista.
    cell.textLabel.text = notebook.name;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateStyle = NSDateFormatterMediumStyle;
    cell.detailTextLabel.text = [dateFormatter stringFromDate:notebook.modificationDate];
    
    // Devolver la celda.
    return cell;
}


#pragma mark - Proximity sensor.
-(BOOL) hasProximitySensor {
    
    // Creamos una instancia del dispositivo.
    UIDevice *device = [UIDevice currentDevice];
    
    // Obtenemos el valor del sensor de proximidad, lo cambiamos y comparamos.
    BOOL oldValue = [device isProximityMonitoringEnabled];
    [device setProximityMonitoringEnabled:!oldValue];
    BOOL newValue = [device isProximityMonitoringEnabled];
    [device setProximityMonitoringEnabled:oldValue];
    
    // Si son distintos, es que hay un sensor de proximidad que nos puede servir para las notificaciones de proximidad.
    return (oldValue != newValue);
}

// UIDeviceProximityStateDidChangeNotification
-(void) proximityStateDidChange:(NSNotification *)notification {
    [self.fetchedResultsController.managedObjectContext.undoManager undo];
}

@end
