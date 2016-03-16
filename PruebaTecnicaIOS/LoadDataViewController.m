//
//  ViewController.m
//  PruebaTecnicaIOS
//
//  Created by Carlos Machado on 22/1/15.
//  Copyright (c) 2015 SlashMobility. All rights reserved.
//

#define kUrl @"https://itunes.apple.com/search?term=Michael+jackson"

#import "LoadDataViewController.h"

@interface LoadDataViewController ()
@property (weak, nonatomic) IBOutlet UIButton *loadDataBtn;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@property (nonatomic, retain) Reachability* networkConn;
@property (nonatomic, weak) WebServiceMethods* WSM;
@property (nonatomic) BOOL itWasByButton;
@property (nonatomic) BOOL byNetwork;
@property (nonatomic, strong) NSMutableArray *justSongList;
@end

@implementation LoadDataViewController
- (IBAction)cargarDataBtn:(id)sender {    
    WebServiceMethods *WSM = [ValidationsClass getWSMOInstance];
    _itWasByButton = YES;
    WSM.webServiceReceivedResponseDelegate = self;
    [self activateLoadingGif];
    if ([self checkNetworkConn]) {
        [WSM requestType:@"GET" ifParams:NO params:nil withTimeout:80.0];
    }else{
        NSArray *dataFromDB = [CoreDataAccess getDataFromDB];
        if ([dataFromDB count]>0) {
            _justSongList = [NSMutableArray arrayWithArray:dataFromDB];
            _itWasByButton = NO;
            _byNetwork = NO;
            [self performSegueWithIdentifier:@"loadDataTable" sender:self];
        } else {
            [ValidationsClass printGeneralMessage:@"app does not have any CD so need network" withTitle:@"no CD no network" fromClass:self.class];
            [self deactivateLoadingGif];
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _justSongList = [[NSMutableArray alloc] init];
    _itWasByButton = NO;
    [self deactivateLoadingGif];
    [_loadDataBtn setTitle:NSLocalizedString(@"load data btn", @"first button to load data from TXT") forState:UIControlStateNormal];
    [_loadDataBtn setTitle:NSLocalizedString(@"loading data btn", @"first button to load data from TXT") forState:UIControlStateDisabled];
    [_loadDataBtn setTitle:NSLocalizedString(@"loading data btn", @"first button to load data from TXT") forState:UIControlStateHighlighted];
    [_loadDataBtn setTitle:NSLocalizedString(@"loading data btn", @"first button to load data from TXT") forState:UIControlStateSelected];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)checkNetworkConn{
    if ([ValidationsClass checkNetworkConn] != NotReachable) {
        //[ValidationsClass printGeneralMessage:@"Message Test" withTitle:@"Title Test" fromClass:self.class];
        NSLog(@"NetworkConn okay!");
        return YES;
    } else {
        NSManagedObjectContext *tryCoreDataLoad = [ValidationsClass getCoreDataContext];
        if (tryCoreDataLoad) {
            NSArray *dataFromDB = [CoreDataAccess getDataFromDB];
            if ([dataFromDB count]>0) {
                //[self performSegueWithIdentifier:@"loadDataTable" sender:self];
            } else {
                //[ValidationsClass printAndRefreshAppWithGeneralMessage:@"app does not have any CD so need network" withTitle:@"no CD no network" fromVC:self];
            }
        } else {
            [ValidationsClass printGeneralMessage:@"app does not have any CD so need network" withTitle:@"no CD no network" fromClass:self.class];
        }
        NSLog(@"NetworkConn down!");
        return NO;
    }
}

-(void)webServiceReceivedResponse:(NSMutableDictionary *)response{
    NSLog(@"Delegate running fine!");
        if (response) {            
            [CoreDataAccess saveSongList:response];
            _justSongList = [response valueForKey:@"results"];
            _byNetwork = YES;
            _itWasByButton = NO;
            [self performSegueWithIdentifier:@"loadDataTable" sender:self];
           // NSLog(@"response: %@", response);
        } else {
            [ValidationsClass printGeneralMessage:@"Something went wrong with the data. Bad data received." withTitle:@"Wrong Data" fromClass:self.class];
            [self deactivateLoadingGif];
        }
    
}

-(void)activateLoadingGif{
    _activityIndicator.hidden = NO;
    _loadDataBtn.enabled = NO;
}

-(void)deactivateLoadingGif{
    _activityIndicator.hidden = YES;
    _loadDataBtn.enabled = YES;
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"loadDataTable"] && !_itWasByButton) {
        UINavigationController *navigationController = segue.destinationViewController;
        SongsDataTableViewController *nextController = (SongsDataTableViewController *)navigationController.topViewController;
        [nextController setSongsList:_justSongList];
        [nextController setByNetwork:_byNetwork];
    }
}

@end
