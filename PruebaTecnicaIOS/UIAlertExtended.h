//
//  UIAlertExtended.h
//  PruebaTecnicaIOS
//
//  Created by Leonardo Puga-DeBiase on 3/15/16.
//  Copyright © 2016 SlashMobility. All rights reserved.
//

//  AlertView.h
//

#import <UIKit/UIKit.h>

@interface UIAlertExtended : UIAlertView

@property (copy, nonatomic) void (^completion)(BOOL, NSInteger);

- (id)initWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles;

@end

