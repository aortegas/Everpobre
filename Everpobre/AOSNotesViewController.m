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

@end
