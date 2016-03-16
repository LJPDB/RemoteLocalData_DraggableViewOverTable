//
//  CoreDataAccess.m
//  PruebaTecnicaIOS
//
//  Created by Leonardo Puga-DeBiase on 3/13/16.
//  Copyright © 2016 SlashMobility. All rights reserved.
//

#import "CoreDataAccess.h"

@implementation CoreDataAccess

+(BOOL)deleteAllInCD{
    NSManagedObjectContext *context = [self getCoreDataContext];
    // erease all content from schema entity..!!!
    NSFetchRequest * allSongs = [[NSFetchRequest alloc] init];
    [allSongs setEntity:[NSEntityDescription entityForName:@"Song" inManagedObjectContext:context]];
    //[allSongs setIncludesPropertyValues:NO]; //only fetch the managedObjectID
    NSError *error;
    NSArray * songs = [context executeFetchRequest:allSongs error:&error];
    //error handling goes here
    for (NSManagedObject * song in songs) {
        [context deleteObject:song];
    }
    error = nil;
    [context save:&error];
    //more error handling here
    if (error) {
        NSLog(@"CDClass: Error --> %@, %@", error, [error localizedDescription]);
        return NO;
    }else{
        return YES;
    }
    /////////////////// end of deleting all data from table..!
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

+(NSArray *)getDataFromDB{
    NSManagedObjectContext *context = [self getCoreDataContext];
    // erease all content from schema entity..!!!
    NSFetchRequest * allSongs = [NSFetchRequest fetchRequestWithEntityName:@"Song"];
    //[allSongs setEntity:[NSEntityDescription entityForName:@"Song" inManagedObjectContext:context]];
    //[allSongs setIncludesPropertyValues:NO]; //only fetch the managedObjectID
    NSError *error;
    NSArray * songs = [context executeFetchRequest:allSongs error:&error];
    if (error) {
        NSLog(@"Class %@: Error loading DB data.", [self class]);
    }
    return songs;
}

+(BOOL)saveSongList:(NSDictionary *) songListStructure{
    [self deleteAllInCD];
    //NSLog(@"value for results: %@", [songListStructure valueForKey:@"results"]);
    NSMutableArray *justSongList = [songListStructure valueForKey:@"results"];
    //Create new employee and add it.!!!
    NSManagedObjectContext *context = [self getCoreDataContext];
    
    /*[newSong setValue:@"leo core" forKey:@"name"];
    [newSong setValue:@"puga core" forKey:@"lastName"];*/
    NSError *error;
    //NSDictionary *oneItemExample = ;
    NSArray *justKeys = [justSongList[0] allKeys];
    int i = 0, j = 0;
    NSString *AddSubString = [[NSString alloc] init];
    if ([justSongList count]>0) {
        for (id songItem in justSongList) {
            NSManagedObject *newSong = [NSEntityDescription insertNewObjectForEntityForName:@"Song" inManagedObjectContext:context];
            for (id key in justKeys) {
                 if([key  isEqual: @"releaseDate"]){
                     //date
                     NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
                     [dateFormat setDateFormat:@"dd-mm-yyyy, HH:mm:ss Z"];
                     NSDate *date = [dateFormat dateFromString:[songItem valueForKey:key]];
                     [newSong setValue:date forKey:key];
                 }else{
                     if ([key  isEqual: @"collectionCensoredName"]||[key  isEqual: @"country"]||[key  isEqual: @"trackName"]) {
                         AddSubString = [NSString stringWithFormat:@"%@ <DB>", [songItem valueForKey:key]];
                         [newSong setValue:AddSubString forKey:key];
                     } else {
                         [newSong setValue:[songItem valueForKey:key] forKey:key];
                     }
                 }
                j++;
            }
            
            error = nil;
            // Save the object to persistent store
            if (![context save:&error]) {
                NSLog(@"CDClass: Error --> %@, %@", error, [error localizedDescription]);
                break;
            }else{
                // Storing data into NSUserdefaults to access it later in another app state (Background)
                NSLog(@"CDClass: Data saved correctly..!");
            }

            i++;
        }
        if (error) {
            return NO;
        } else {
            return YES;
        }
        
            } else {
        return NO;
    }
    ////////////////////  end of adding data from table...!
}


@end
