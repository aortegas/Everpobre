//
//  AOSNotesViewController.m
//  Everpobre
//
//  Created by Alberto on 17/8/16.
//  Copyright © 2016 aortegas.io. All rights reserved.
//

#import "AOSNotesViewController.h"
#import "AOSNotebook.h"
#import "AOSNote.h"


@interface AOSNotesViewController ()

@property (strong, nonatomic) AOSNotebook *model;

@end

@implementation AOSNotesViewController

#pragma mark - Init
-(id) initWithNotebook:(AOSNotebook *)notebook {
    
    // Creamos el fetchedResults.
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:[AOSNote entityName]];
    // Creamos un predicado y se lo asignamos al NSFetchRequest.
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"Notebook == %@", notebook];
    // Añadimos la ordenacion por nombre de la nota.
    fetchRequest.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:AOSNamedEntityAttributes.name ascending:YES]];
    // Creamos un NSFetchResultController para trabajar con los datos obtenidos con el NSFetchRequest.
    NSFetchedResultsController *fechedResultController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                                                                             managedObjectContext:notebook.managedObjectContext
                                                                                               sectionNameKeyPath:nil
                                                                                                        cacheName:nil];
    // Le pasamos el NSFetchResultController a nuestra super clase para que con el, nos haga todo el trabajo.
    if (self = [super initWithFetchedResultsController:fechedResultController style:UITableViewStylePlain]) {
     
        self.fetchedResultsController = fechedResultController;
        self.model = notebook;
        self.title = notebook.name;
    }
    
    return self;
}


#pragma mark - Life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - Data Source
-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // Forma estandar.
    static NSString *cellId = @"noteCell";
    
    // Averiguar la nota.
    AOSNote *note = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    // Crear una celda.
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
    }
    
    // Sincronizar modelo con vista.
    cell.textLabel.text = note.name;
    
    // Devolver la celda.
    return cell;
}

@end
