//
//  AOSNotesViewController.m
//  Everpobre
//
//  Created by Alberto on 19/8/16.
//  Copyright © 2016 aortegas.io. All rights reserved.
//

#import "AOSNotesViewController.h"
#import "AOSNote.h"
#import "AOSNoteCellView.h"
#import "AOSPhoto.h"
#import "AOSNoteViewController.h"
#import "AOSNotebook.h"

static NSString *cellId = @"NoteCellId";

@interface AOSNotesViewController ()

@end

@implementation AOSNotesViewController

#pragma mark - View Lifecycle
-(void) viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
    [self registerNib];
    
    self.collectionView.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
    self.title = @"Notas";
    
    self.detailViewControllerClassName = NSStringFromClass([AOSNoteViewController class]);
    
    UIBarButtonItem *add = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                         target:self
                                                                         action:@selector(addNewNote:)];
    self.navigationItem.rightBarButtonItem = add;
}


#pragma mark - Xib Registration
-(void) registerNib {
    
    UINib *nib = [UINib nibWithNibName:@"AOSNoteCollectionViewCell" bundle:nil];
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:cellId];
}


#pragma mark - Data Source
-(UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    // Obtener el objeto
    AOSNote *note = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    // Obtener una collection
    AOSNoteCellView *collection = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    
    // Configurar la celda
    [collection observeNote:note];
    
    // Devolver la celda
    return collection;
}


#pragma mark - Utils
-(void) addNewNote:(id)sender {
    
    AOSNoteViewController *newNoteVC = [[AOSNoteViewController alloc] initForNewNoteInNotebook:self.notebook];
    [self.navigationController pushViewController:newNoteVC animated:YES];
}


#pragma mark - Delegate
- (void) backToDelegate:(AOSNoteViewController *)vc {
    [self.collectionView reloadData];
}




//-(void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//
//    // Obtener el objeto nota.
//    AOSNote *note = [self.fetchedResultsController objectAtIndexPath:indexPath];
//
//    // Crear el controlador de nota.
//    AOSNoteViewController *noteVC = [[AOSNoteViewController alloc] initWithModel:note];
//
//    // Hacer un push.
//    [self.navigationController pushViewController:noteVC animated:YES];
//}

@end
