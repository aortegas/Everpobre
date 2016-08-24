//
//  AOSNoteViewController.m
//  Everpobre
//
//  Created by Alberto on 19/8/16.
//  Copyright © 2016 aortegas.io. All rights reserved.
//

#import "AOSNoteViewController.h"
#import "AOSNote.h"
#import "AOSPhoto.h"
#import "AOSNotebook.h"

@interface AOSNoteViewController () <UITextFieldDelegate>

@property (nonatomic, strong) AOSNote *model;
@property (nonatomic) CGRect textViewOriginalFrame;
@property (nonatomic) BOOL new;
@property (nonatomic) BOOL deleteCurrentNote;

@end

@implementation AOSNoteViewController

#pragma mark - Init
-(id) initWithModel:(id) model {
    
    if (self = [super initWithNibName:nil bundle:nil]) {
        _model = model;
    }
    return self;
}

-(id)initForNewNoteInNotebook:(AOSNotebook *) notebook {

    AOSNote *newNote = [AOSNote noteWithName:@"" noteBook:notebook context:notebook.managedObjectContext];
    _new = YES;
    return [self initWithModel:newNote];
}


#pragma mark - View Life Cycle
-(void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.textView.translatesAutoresizingMaskIntoConstraints = YES;
    
    // Modelo -> Vista
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.dateStyle = NSDateFormatterLongStyle;
    self.modificationDateView.text = [dateFormatter stringFromDate:self.model.modificationDate];
    
    self.nameView.text = self.model.name;
    self.nameView.delegate = self;

    self.textView.text = self.model.text;
    
    UIImage *image = self.model.photo.image;
    if (image == nil) {
        image = [UIImage imageNamed:@"noImageInNote"];
    }
    self.photoView.image = image;
    
    // Start observing
    [self startObservingKeyboard];
    
    // Add Input Accessory View.
    [self setupInputAccessoryView];
    
    // Mostramos un boton de cancelar.
    if (self.new) {
        UIBarButtonItem *cancel = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                                target:self
                                                                                action:@selector(cancel:)];
        self.navigationItem.rightBarButtonItem = cancel;
    }
}

-(void) viewWillDisappear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (self.deleteCurrentNote) {

        // Delete CoreData object.
        [self.model.managedObjectContext deleteObject:self.model];
    } else {
        
        // Vista -> Modelo
        self.model.name = self.nameView.text;
        self.model.text = self.textView.text;
        self.model.photo.image = self.photoView.image;
    }
    
    // Stop observing
    [self stopObservingKeyboard];
}


#pragma mark - Keyboard
-(void) startObservingKeyboard {
    
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    [notificationCenter addObserver:self selector:@selector(notifyThatKeyboardWillAppear:) name:UIKeyboardWillShowNotification object:nil];
    [notificationCenter addObserver:self selector:@selector(notifyThatKeyboardWillDisappear:) name:UIKeyboardWillHideNotification object:nil];
}

-(void) stopObservingKeyboard {

    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    [notificationCenter removeObserver:self];
}

-(void) notifyThatKeyboardWillAppear:(NSNotification *) notification {

    // Averiguamos si el firstResponder es la Textview, para realizar solo en ese caso la animacion.
    if ([self.textView isFirstResponder]) {
    
        // Extraer el user info.
        NSDictionary *dictionary = notification.userInfo;
        
        // Extraer la duracion de la animacion.
        double duration = [[dictionary objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
        
        // Nos guardamos el frame original de la text view.
        _textViewOriginalFrame = self.textView.frame;
        
        // Cambiar las propiedades de la caja de texto.
        [UIView animateWithDuration:duration
                              delay:0
                            options:0
                         animations:^{
                             self.textView.frame = CGRectMake(self.modificationDateView.frame.origin.x,
                                                              self.modificationDateView.frame.origin.y,
                                                              self.textView.frame.size.width,
                                                              self.textView.frame.size.height);
                         }
                         completion:nil];
        
        [UIView animateWithDuration:duration
                         animations:^{
                             self.textView.alpha = 0.8;
                         }];
    }
}

-(void) notifyThatKeyboardWillDisappear:(NSNotification *) notification {
    
    // Averiguamos si el firstResponder es la Textview, para realizar solo en ese caso la animacion.
    if ([self.textView isFirstResponder]) {
    
        // Extraer el user info.
        NSDictionary *dictionary = notification.userInfo;
        
        // Extraer la duracion de la animacion.
        double duration = [[dictionary objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
        
        // Cambiar las propiedades de la caja de texto.
        [UIView animateWithDuration:duration
                              delay:0
                            options:0
                         animations:^{
                             self.textView.frame = self.textViewOriginalFrame;
                         }
                         completion:nil];
        
        [UIView animateWithDuration:duration
                         animations:^{
                             self.textView.alpha = 1;
                         }];
    }
}

-(void) setupInputAccessoryView {
    
    // Creamos una barra.
    UIToolbar *textViewToolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    UIToolbar *nameTextToolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    
    // Añadimos botones.
    UIBarButtonItem *separator = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                               target:nil
                                                                               action:nil];
    
    UIBarButtonItem *done = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                          target:self
                                                                          action:@selector(dismissKeyboard:)];
    
    UIBarButtonItem *smile = [[UIBarButtonItem alloc] initWithTitle:@":-)"
                                                              style:UIBarButtonItemStylePlain
                                                             target:self
                                                             action:@selector(insertTitle:)];

    [textViewToolBar setItems:@[smile, separator, done]];
    [nameTextToolBar setItems:@[separator, done]];
    
    // La asignamos como inputAccessoryView.
    self.textView.inputAccessoryView = textViewToolBar;
    self.nameView.inputAccessoryView = nameTextToolBar;
}

-(void) dismissKeyboard:(id)sender {
    [self.view endEditing:YES];
}

-(void) insertTitle:(UIBarButtonItem *)sender {
    [self.textView insertText:sender.title];
}


#pragma mark - Utils
-(void) cancel:(id)sender {
    
    self.deleteCurrentNote = YES;
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - UITextFieldDelegate
-(BOOL) textFieldShouldReturn:(UITextField *)textField {

    // Nos deshacemos del teclado cuando pulse enter.
    [textField resignFirstResponder];
    return YES;
}

@end
