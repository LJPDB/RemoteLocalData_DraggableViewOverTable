//
//  ValidationsClass.h
//  PruebaTecnicaIOS
//
//  Created by Leonardo Puga-DeBiase on 3/8/16.
//  Copyright © 2016 SlashMobility. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"
#import "LoadDataViewController.h"

@interface ValidationsClass : NSObject

+(bool)checkNetworkConn;
+(void)printGeneralMessage:(NSString*) message withTitle:(NSString*) title fromClass:(Class) className;
+(void)printAndRefreshAppWithGeneralMessage:(NSString*) message withTitle:(NSString*) title fromVC:(UIViewController *) VC;
+(WebServiceMethods*)getWSMOInstance;
+(NSManagedObjectContext *)getCoreDataContext;

@end
