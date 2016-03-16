//
//  SongsDataTableViewController.m
//  PruebaTecnicaIOS
//
//  Created by Leonardo Puga-DeBiase on 3/8/16.
//  Copyright © 2016 SlashMobility. All rights reserved.
//

#import "SongsDataTableViewController.h"

@interface SongsDataTableViewController ()
@property (weak, nonatomic) IBOutlet UIView *redVC;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *networkConn;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *dataBase;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) NSInteger selectedItem;

@end

@implementation SongsDataTableViewController

- (IBAction)refreshDataBtn:(id)sender {
    WebServiceMethods *WSM = [ValidationsClass getWSMOInstance];
    WSM.webServiceReceivedResponseDelegate = self;
    if ([self checkNetworkConn]) {
        [WSM requestType:@"GET" ifParams:NO params:nil withTimeout:80.0];
    }else{
        NSArray *dataFromDB = [CoreDataAccess getDataFromDB];
        if ([dataFromDB count]>0) {
            _songsList = [NSMutableArray arrayWithArray:dataFromDB];
            _byNetwork = NO;
            [_tableView reloadData];
        } else {
            [ValidationsClass printGeneralMessage:@"app does not have any CD so need network" withTitle:@"no CD no network" fromClass:self.class];
        }
    }

}

- (void)viewDidLoad {
    [super viewDidLoad];
    WebServiceMethods *WSM = [ValidationsClass getWSMOInstance];
    WSM.webServiceReceivedResponseDelegate = self;
    [NSTimer scheduledTimerWithTimeInterval:5.0f target:self selector:@selector(checkNetworkConn) userInfo:nil repeats:YES];
    
    [self.view bringSubviewToFront:_redVC];
    
    if (_byNetwork) {
        
        [_networkConn setTintColor:[UIColor blueColor]];
        
        [_dataBase setTintColor:[UIColor darkGrayColor]];
    }else{
        
        [_dataBase setTintColor:[UIColor blueColor]];
        
        [_networkConn setTintColor:[UIColor darkGrayColor]];
    }
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return _songsList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"simpleCell"];
    id aux = _songsList[indexPath.row];
    UILabel *tituloLabel = (UILabel *)[cell.contentView viewWithTag:2];
    UILabel *albumLabel = (UILabel *)[cell.contentView viewWithTag:3];
    UILabel *paisLabel = (UILabel *)[cell.contentView viewWithTag:4];
    
    UILabel *tituloValueLabel = (UILabel *)[cell.contentView viewWithTag:5];
    UILabel *albumValueLabel = (UILabel *)[cell.contentView viewWithTag:6];
    UILabel *paisValueLabel = (UILabel *)[cell.contentView viewWithTag:7];
    
    tituloLabel.text = NSLocalizedString(@"title", nil);
    albumLabel.text = NSLocalizedString(@"album", nil);
    paisLabel.text = NSLocalizedString(@"country", nil);
    
    tituloValueLabel.text = [aux valueForKey:@"trackName"];
    albumValueLabel.text = [aux valueForKey:@"collectionCensoredName"];
    paisValueLabel.text = [aux valueForKey:@"country"];
    //[label setText:@"test 3"];//[NSString stringWithFormat:@"%@", [aux valueForKey:@"_id"]]];
    // Configure the cell...
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier:@"showDetails" sender:self];
}



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showDetails"]) {
        //UINavigationController *navigationController = segue.destinationViewController;
        //SongDetailsVCViewController *nextController = (SongDetailsVCViewController *)navigationController.topViewController;
        SongDetailsVCViewController *nextController = segue.destinationViewController;
        NSIndexPath *selectedIndexPath = [self.tableView indexPathForSelectedRow];
        NSLog(@"Selected row in segue: %ld", (long)selectedIndexPath.row);
        NSLog(@"Rows before Segue: %@", _songsList[(long)selectedIndexPath.row]);
        [nextController setSongDetails:_songsList[(long)selectedIndexPath.row]];
    }
}


#pragma MARK - Network check methods

-(BOOL)checkNetworkConn{
    if ([ValidationsClass checkNetworkConn] != NotReachable) {
        //[ValidationsClass printGeneralMessage:@"Message Test" withTitle:@"Title Test" fromClass:self.class];
        NSLog(@"NetworkConn okay!");
        if (!_byNetwork) {
            WebServiceMethods *WSM = [ValidationsClass getWSMOInstance];
            [WSM requestType:@"GET" ifParams:NO params:nil withTimeout:80.0];
            [_networkConn setTintColor:[UIColor blueColor]];
            [_dataBase setTintColor:[UIColor darkGrayColor]];
            [ValidationsClass printGeneralMessage:@"app working with internet data" withTitle:@"online data" fromClass:self.class];
        }
        return YES;
    } else {
        NSManagedObjectContext *tryCoreDataLoad = [ValidationsClass getCoreDataContext];
        if (tryCoreDataLoad) {
            NSArray *dataFromDB = [CoreDataAccess getDataFromDB];
            if ([dataFromDB count]>0) {
                if (_byNetwork) {
                    _songsList = dataFromDB;
                    [self.tableView reloadData];
                    [ValidationsClass printGeneralMessage:@"app working with local data" withTitle:@"local data" fromClass:self.class];
                }                
            } else {
                [ValidationsClass printAndRefreshAppWithGeneralMessage:@"app does not have any CD so need network" withTitle:@"no CD no network" fromVC:self];
            }
        } else {
            [ValidationsClass printAndRefreshAppWithGeneralMessage:@"app does not have any CD so need network" withTitle:@"no CD no network" fromVC:self];
        }
        _byNetwork = NO;
        [_dataBase setTintColor:[UIColor blueColor]];
        [_networkConn setTintColor:[UIColor darkGrayColor]];
        NSLog(@"NetworkConn down!");
        return NO;
    }
}


-(void)webServiceReceivedResponse:(NSMutableDictionary *)response{
    NSLog(@"Delegate running fine!");
    if ([CoreDataAccess saveSongList:response]) {
        // NSLog(@"response: %@", response);
        
        [_networkConn setTintColor:[UIColor blueColor]];
        [_dataBase setTintColor:[UIColor darkGrayColor]];
        
        _byNetwork = YES;
        _songsList = [response valueForKey:@"results"];
    } else {
        if(_byNetwork){
            [_dataBase setTintColor:[UIColor blueColor]];
            [_networkConn setTintColor:[UIColor darkGrayColor]];
        }
        _byNetwork = NO;
        _songsList = [CoreDataAccess getDataFromDB];
        [ValidationsClass printGeneralMessage:@"Something went wrong with the data. Bad data received." withTitle:@"Wrong Data" fromClass:self.class];
    }
    [_tableView reloadData];
}


#pragma MARK - Movement handler method
- (IBAction)handlePan:(UIPanGestureRecognizer *)recognizer {
    
    CGPoint translation = [recognizer translationInView:self.view];
    recognizer.view.center = CGPointMake(recognizer.view.center.x + translation.x,
                                         recognizer.view.center.y + translation.y);
    [recognizer setTranslation:CGPointMake(0, 0) inView:self.view];
    
}


@end
