//
//  ViewController.h
//  PruebaTecnicaIOS
//
//  Created by Carlos Machado on 22/1/15.
//  Copyright (c) 2015 SlashMobility. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ValidationsClass.h"
#import "WebServiceMethods.h"
#import "CoreDataAccess.h"
#import "SongsDataTableViewController.h"

@interface LoadDataViewController : UIViewController <webServiceDidRecieveResponseDelegate>


@end

