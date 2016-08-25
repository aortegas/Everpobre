//
//  AOSPhotoViewController.m
//  Everpobre
//
//  Created by Alberto on 24/8/16.
//  Copyright © 2016 aortegas.io. All rights reserved.
//

#import "AOSPhotoViewController.h"
#import "AOSPhoto.h"
@import CoreImage;

@interface AOSPhotoViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) AOSPhoto *model;

@end


@implementation AOSPhotoViewController

#pragma mark - Init
-(id) initWithModel:(id)model {
    
    NSAssert(model, @"model can't be nil");
    
    if (self = [super initWithNibName:nil bundle:nil]) {
        _model = model;
    }
    
    return self;
}


#pragma mark - Life cycle
-(void) viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
    self.photoView.image = self.model.image;
}

-(void) viewWillDisappear:(BOOL)animated {

    [super viewWillDisappear:animated];
    self.model.image = self.photoView.image;
}


#pragma mark - Actions
- (IBAction)takePhoto:(UIBarButtonItem *)sender {
    
    // Crear un imagePicker.
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    
    // Configurar.
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    } else {
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    picker.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    
    // Asignarnos como delegados
    picker.delegate = self;
    
    // Mostrarlo
    [self presentViewController:picker animated:YES completion:^{}];
}

- (IBAction)deletePhoto:(UIBarButtonItem *)sender {
    
    // Estado inicial
    CGRect oldBouns = self.photoView.bounds;
    
    // Eliminamos de la vista
    [UIView animateWithDuration:0.6
                          delay:0
                        options:0
                     animations:^{
                         self.photoView.bounds = CGRectZero;
                         self.photoView.alpha = 0;
                     } completion:^(BOOL finished) {
                         self.photoView.image = nil;
                         self.photoView.alpha = 1;
                         self.photoView.bounds = oldBouns;
                     }];
    
    // Eliminarla del modelo
    self.model.image = nil;
}

- (IBAction)applyVintageEffect:(id)sender {
    
    // Crear un contexto de Core Image
    CIContext *context = [CIContext contextWithOptions:nil];
    
    // Crear una CIImage de entrada
    CIImage *imageInput = [CIImage imageWithCGImage:self.model.image.CGImage];
    
    // Creamos un filtro CIFalseColor
    CIFilter *oldFilter = [CIFilter filterWithName:@"CIFalseColor"];
    [oldFilter setDefaults]; // Se asignan valores por defecto.
    [oldFilter setValue:imageInput forKey:kCIInputImageKey];
    
    // Creamos un filtro Vignette
    CIFilter *vignetteFilter = [CIFilter filterWithName:@"CIVignette"];
    [vignetteFilter setDefaults];
    [vignetteFilter setValue:@12 forKey:kCIInputIntensityKey];
    
    // Encadenamos los dos filtros.
    [vignetteFilter setValue:oldFilter.outputImage forKey:kCIInputImageKey];
    
    // Obtener imagen de salida
    CIImage *imageOutput = vignetteFilter.outputImage;
    
    // Aplicar el filtro. Como las aplicaciones de los filtros son costosas, las mandamos a segundo plano.
    [self.activityView startAnimating];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{

        // Aplicamos el filtro en segundo plano. CGImageRef ya de por si es un puntero, por eso no indicamos "*".
        CGImageRef result = [context createCGImage:imageOutput fromRect:[imageOutput extent]];
        
        // Actualizamos la foto en primer plano.
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.activityView stopAnimating];
            
            // Guardamos la nueva imagen
            UIImage *img = [UIImage imageWithCGImage:result];
            self.photoView.image = img;

            // Liberamos recursos
            CGImageRelease(result);
        });
    });
}

- (IBAction)zoomToFace:(id)sender {
    
    // Obtenemos las caras de la imagen.
    NSArray *features = [self featuresInImage:self.photoView.image];
    
    if (features) {
        
        // Obtenemos la ultima de las caras.
        CIFeature *face = [features lastObject];
        // Obtenemos el CGRect de la cara.
        CGRect faceBounds = [face bounds];
        // Creamos una imagen a partir de la imagen que tenemos.
        CIImage *image = [CIImage imageWithCGImage:self.photoView.image.CGImage];
        // Creamos el zoom al bounds de la cara.
        CIImage *crop = [image imageByCroppingToRect:faceBounds];
        // Convertimos la CIImage en UIImage.
        UIImage *imageFinal = [UIImage imageWithCIImage:crop];
        // Asignamos a la vista la UIImage.
        self.photoView.image = imageFinal;
    }
}

// Metodo para devolver array con caras.
- (NSArray *)featuresInImage:(UIImage *)image {
    
    // Creamos un contexto.
    CIContext *context = [CIContext contextWithOptions:nil];
    
    // Creamos el detector facial. Con las opciones forzamos a detectar una siempre.
    CIDetector *detector = [CIDetector detectorOfType:CIFeatureTypeFace
                                              context:context
                                              options:@{CIDetectorAccuracy: CIDetectorAccuracyHigh}];
    
    // Creamos una CIImage a partir de la UIImage de entrada.
    CIImage *img = [CIImage imageWithCGImage:(__bridge CGImageRef _Nonnull)(image.CIImage)];
    
    // Creamos un array a partir de las caras que reconozca el detector.
    NSArray *features = [detector featuresInImage:img];
    
    if ([features count]) {
        return features;
    } else {
        return nil;
    }
}


#pragma mark - UIImagePickerControllerDelegate Delegate
-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    // Lo metemos en CoreData de inmediato, para que gestione el gran espacio grande de la foto.
    self.model.image = image;

    // Hacemos que desaparezca el picker.
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

@end
