//
//  WebServiceMethods.m
//  PruebaTecnicaIOS
//
//  Created by Leonardo Puga-DeBiase on 3/8/16.
//  Copyright © 2016 SlashMobility. All rights reserved.
//

#import "WebServiceMethods.h"

@interface WebServiceMethods ()

@property (nonatomic, strong) NSMutableDictionary *JSONparsed;
@property (nonatomic, strong) NSString *webServiceURL;

@end


@implementation WebServiceMethods

-(id) init{
    if (self) {
        self = [super init];
        _webServiceURL = @"http://itunes.apple.com/search?term=Michael+jackson";
    }
    
    return self;
}

-(void)requestType:(NSString *)requestType
          ifParams:(Boolean) ifParams
            params:(NSDictionary *) params
       withTimeout:(NSInteger) timeout{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        NSURL *url = [NSURL URLWithString:_webServiceURL];
        NSError* error;
        //NSString *content = [[NSString alloc] initWithContentsOfURL:url encoding:NSUTF8StringEncoding error:&error ];
        
        NSData* data = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:url] returningResponse:nil error:&error];
        //NSLog(@"Data from URL from TXT file: %@", data);
        //NSString *URLwithCharacters = [URLstring stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString: _webServiceURL] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:timeout];
        [request    setHTTPMethod:requestType];
        
        //to accept data
        [request  setValue:@"application/json; charset=UTF-8" forHTTPHeaderField:@"Accept"];
       // [request  setValue:_clientID forHTTPHeaderField:@"ClientID"];
        
        //NSOperationQueue *queue = [[NSOperationQueue alloc] init];
        //__block NSMutableDictionary * JSONparsed = [[NSMutableDictionary alloc] init];
        
        if (NSFoundationVersionNumber <= NSFoundationVersionNumber_iOS_8_3) {
            [NSURLConnection sendAsynchronousRequest: request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError){
                if ([data length] > 0 && connectionError == nil) {
                    //NSLog(@"Response from service: %@", response);
                    NSError *JSONerror = nil;
                    
                        if (!JSONerror) {
                            _JSONparsed = [NSJSONSerialization JSONObjectWithData:data options:0 error:&JSONerror];
                            [self.webServiceReceivedResponseDelegate webServiceReceivedResponse:_JSONparsed];
                            //NSLog(@"Response parsed to JSON: %@", JSONinDictionary);
                        }else{
                            [self.webServiceReceivedResponseDelegate webServiceReceivedResponse:nil];
                        }
                        
                    
                } else if ([data length] == 0 && connectionError ==nil) {
                    NSLog(@"Nothing back in Response from service");
                    [self.webServiceReceivedResponseDelegate webServiceReceivedResponse:nil];
                }else if ( connectionError != nil && connectionError.code == ECONNABORTED) {
                    NSLog(@"Fail to connect before Timeout!");
                    [self.webServiceReceivedResponseDelegate webServiceReceivedResponse:nil];
                }else if (connectionError != nil){
                    NSLog(@"Error: %@", connectionError);
                    [self.webServiceReceivedResponseDelegate webServiceReceivedResponse:nil];
                }
            }];
        }else{
            NSURLSession *session = [NSURLSession sharedSession];
            [[session dataTaskWithRequest:(NSURLRequest *) request completionHandler:^(NSData *data, NSURLResponse *response, NSError *connectionError){
                if ([data length] > 0 && connectionError == nil) {
                    //NSLog(@"Response from service: %@", response);
                    NSError *JSONerror = nil;
                  
                        if (!JSONerror) {
                            _JSONparsed = [NSJSONSerialization JSONObjectWithData:data options:0 error:&JSONerror];
                            [self.webServiceReceivedResponseDelegate webServiceReceivedResponse: _JSONparsed];
                           // NSLog(@"Response parsed to JSON: %@", JSONinDictionary);
                        }else{
                            [self.webServiceReceivedResponseDelegate webServiceReceivedResponse:nil];
                        }
                    
                } else if ([data length] == 0 && connectionError ==nil) {
                    NSLog(@"Nothing back in Response from service");
                    [self.webServiceReceivedResponseDelegate webServiceReceivedResponse:nil];
                }else if ( connectionError != nil && connectionError.code == ECONNABORTED) {
                    NSLog(@"Fail to connect before Timeout!");
                    [self.webServiceReceivedResponseDelegate webServiceReceivedResponse:nil];
                }else if (connectionError != nil){
                    NSLog(@"Error: %@", connectionError);
                    [self.webServiceReceivedResponseDelegate webServiceReceivedResponse:nil];
                }
            }]resume];
        }
        //return _JSONparsed;
    });
}



@end
