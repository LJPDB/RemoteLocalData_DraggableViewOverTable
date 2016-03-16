//
//  SongsDataTableViewController.h
//  PruebaTecnicaIOS
//
//  Created by Leonardo Puga-DeBiase on 3/8/16.
//  Copyright © 2016 SlashMobility. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ValidationsClass.h"
#import "WebServiceMethods.h"

@interface SongsDataTableViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, webServiceDidRecieveResponseDelegate>

@property (nonatomic, strong) NSArray *songsList;
@property (nonatomic) BOOL byNetwork;
- (IBAction)handlePan:(UIPanGestureRecognizer *)recognizer;

@end
