//
//  Song.h
//  PruebaTecnicaIOS
//
//  Created by Leonardo Puga-DeBiase on 3/8/16.
//  Copyright © 2016 SlashMobility. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface Song : NSManagedObject

@property (nonatomic, retain) NSString *wrapperType;
@property (nonatomic, retain) NSString *kind;
@property (nonatomic, retain) NSNumber *artistId;
@property (nonatomic, retain) NSNumber *collectionId;
@property (nonatomic, retain) NSNumber *trackId;
@property ( nonatomic, retain) NSString *artistName;
@property ( nonatomic, retain) NSString *collectionName;
@property ( nonatomic, retain) NSString *trackName;
@property ( nonatomic, retain) NSString *collectionCensoredName;
@property ( nonatomic, retain) NSString *trackCensoredName;
@property ( nonatomic, retain) NSString *artistViewUrl;
@property ( nonatomic, retain) NSString *collectionViewUrl;
@property ( nonatomic, retain) NSString *trackViewUrl;
@property ( nonatomic, retain) NSString *previewUrl;
@property ( nonatomic, retain) NSString *artworkUrl30;
@property ( nonatomic, retain) NSString *artworkUrl60;
@property ( nonatomic, retain) NSString *artworkUrl100;
@property ( nonatomic, retain) NSNumber *collectionPrice;
@property ( nonatomic, retain) NSNumber *trackPrice;
@property ( nonatomic, retain) NSDate *releaseDate;
@property ( nonatomic, retain) NSString *collectionExplicitness;
@property ( nonatomic, retain) NSString *trackExplicitness;
@property ( nonatomic, retain) NSNumber *discCount;
@property ( nonatomic, retain) NSNumber *discNumber;
@property ( nonatomic, retain) NSNumber *trackCount;
@property ( nonatomic, retain) NSNumber *trackNumber;
@property ( nonatomic, retain) NSNumber *trackTimeMillis;
@property ( nonatomic, retain) NSString *country;
@property ( nonatomic, retain) NSString *currency;
@property ( nonatomic, retain) NSString *primaryGenreName;
@property ( nonatomic, retain) NSNumber *isStreamable;

@end

