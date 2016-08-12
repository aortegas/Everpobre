#import "AOSNamedEntity.h"

@interface AOSNamedEntity ()

+(NSArray *)observableKeyNames;

@end

@implementation AOSNamedEntity


#pragma mark - Class Methods.
+(NSArray *) observableKeyNames {
    
    return @[@"name", @"creationDate"];
}


#pragma mark - Life Cycle.
-(void) awakeFromInsert {
    
    [super awakeFromInsert];
    [self setupKVO];
}

-(void) awakeFromFetch {
    
    [super awakeFromFetch];
    [self setupKVO];
}

-(void) willTurnIntoFault {
    
    [super willTurnIntoFault];
    [self tearDownKVO];
}


#pragma mark - KVO.
-(void) setupKVO {
    
    for (NSString *key in [[self class] observableKeyNames]) {
        
        [self addObserver:self
               forKeyPath:key
                  options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
                  context:NULL];
    }
}

-(void) tearDownKVO {
    
    for (NSString *key in [[self class] observableKeyNames]) {
        
        [self removeObserver:self
                  forKeyPath:key];
    }
}

// Override notification change properties method.
-(void) observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSString *,id> *)change
                       context:(void *)context {
    
    self.modificationDate = [NSDate date];
}

@end
