//
//  ValidationsClass.m
//  PruebaTecnicaIOS
//
//  Created by Leonardo Puga-DeBiase on 3/8/16.
//  Copyright © 2016 SlashMobility. All rights reserved.
//

#import "ValidationsClass.h"
#import "UIAlertExtended.h"

@implementation ValidationsClass

+(bool)checkNetworkConn{
    AppDelegate *appDelegateAUX =  (AppDelegate *)[[UIApplication sharedApplication] delegate];
    Reachability *networkConn = appDelegateAUX.testConnectionObject;
    [networkConn startNotifier];
    
    NetworkStatus status = [networkConn currentReachabilityStatus];
    
    if(status == NotReachable)
    {
        NSLog(@"Connection null");
        //No internet
    }
    else if (status == ReachableViaWiFi)
    {
        NSLog(@"Connection type: WIFI");
    }
    else if (status == ReachableViaWWAN)
    {
        NSLog(@"Connection type: 3G");
    }
    return status;
}

+(void)printGeneralMessage:(NSString*) message withTitle:(NSString*) title fromClass:(Class) className{
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(title, @"just a comment") message:NSLocalizedString(message, @"just a comment") delegate:className cancelButtonTitle: NSLocalizedString(@"accept btn", @"just a comment") otherButtonTitles:nil, nil];
    [alert show];
}

+(void)printAndRefreshAppWithGeneralMessage:(NSString*) message withTitle:(NSString*) title fromVC:(UIViewController *) VC{
    UIAlertExtended* alert = [[UIAlertExtended alloc] initWithTitle:NSLocalizedString(title, @"just a comment") message:NSLocalizedString(message, @"just a comment") cancelButtonTitle:NSLocalizedString(@"refresh app", @"just a comment") otherButtonTitles:nil];
    alert.completion = ^(BOOL cancelled, NSInteger buttonIndex) {
        [VC viewDidLoad]; [VC viewWillAppear:YES];
    };
    [alert show];
}


+(WebServiceMethods*)getWSMOInstance{
    AppDelegate *appDelegateAUX =  (AppDelegate *)[[UIApplication sharedApplication] delegate];
    return appDelegateAUX.WS_API;
}

+(NSManagedObjectContext *)getCoreDataContext{
    AppDelegate *coreDataDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [coreDataDelegate managedObjectContext];
    //NSError * error = nil;
    //NSDictionary *result = [[NSDictionary alloc] init];
    //[result setValue:[NSString stringWithFormat:@"%@", error] forKey:@"error"];
   // [result setValue:context forKey:@"contextObj"];
    return context;
}

@end
