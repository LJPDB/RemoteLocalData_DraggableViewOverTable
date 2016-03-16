//
//  CoreDataAccess.h
//  PruebaTecnicaIOS
//
//  Created by Leonardo Puga-DeBiase on 3/13/16.
//  Copyright © 2016 SlashMobility. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"
#import "ValidationsClass.h"
#import "Song.h"

@interface CoreDataAccess : NSObject

+(BOOL)saveSongList:(NSDictionary *) songList;
+(NSArray *)getDataFromDB;

@end
