//
//  WebServiceMethods.h
//  PruebaTecnicaIOS
//
//  Created by Leonardo Puga-DeBiase on 3/8/16.
//  Copyright © 2016 SlashMobility. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WebServiceMethods;
@protocol webServiceDidRecieveResponseDelegate <NSObject>
-(void) webServiceReceivedResponse:(NSMutableDictionary *)response;
@end

@interface WebServiceMethods : NSObject

@property (nonatomic, weak) id<webServiceDidRecieveResponseDelegate> webServiceReceivedResponseDelegate;

-(void)requestType:(NSString *)requestType
          ifParams:(Boolean) ifParams
            params:(NSDictionary *) params
       withTimeout:(NSInteger) timeout;

@end
