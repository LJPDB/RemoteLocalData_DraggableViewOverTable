//
//  UIAlertExtended.m
//  PruebaTecnicaIOS
//
//  Created by Leonardo Puga-DeBiase on 3/15/16.
//  Copyright © 2016 SlashMobility. All rights reserved.
//

#import "UIAlertExtended.h"

//
//  AlertView.m

#import "UIAlertExtended.h"

@interface UIAlertExtended () <UIAlertViewDelegate>

@end

@implementation UIAlertExtended

- (id)initWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles {
    
    self = [self initWithTitle:title message:message delegate:self cancelButtonTitle:cancelButtonTitle otherButtonTitles:nil];
    
    if (self) {
        for (NSString *buttonTitle in otherButtonTitles) {
            [self addButtonWithTitle:buttonTitle];
        }
    }
    return self;
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    
    if (self.completion) {
        self.completion(buttonIndex==self.cancelButtonIndex, buttonIndex);
        self.completion = nil;
    }
}

@end