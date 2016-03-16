//
//  SongDetailsVCViewController.m
//  PruebaTecnicaIOS
//
//  Created by Leonardo Puga-DeBiase on 3/16/16.
//  Copyright © 2016 SlashMobility. All rights reserved.
//

#import "SongDetailsVCViewController.h"

@interface SongDetailsVCViewController ()
@property (weak, nonatomic) IBOutlet UILabel *songLabel;
@property (weak, nonatomic) IBOutlet UILabel *artistLabel;
@property (weak, nonatomic) IBOutlet UILabel *artistViewUrlLabel;
@property (weak, nonatomic) IBOutlet UILabel *collectionCensoredNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *collectionExplicitnessLabel;
@property (weak, nonatomic) IBOutlet UILabel *collectionPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *countryLabel;
@property (weak, nonatomic) IBOutlet UILabel *currencyLabel;


@property (weak, nonatomic) IBOutlet UILabel *songValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *artistValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *artistViewUrlValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *collectionCensoredNameValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *collectionExplicitnessValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *collectionPriceValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *countryValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *currencyValueLabel;

@end

@implementation SongDetailsVCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"Rows: %@", _songDetails);
    _songLabel.text = NSLocalizedString(@"songLabel", nil);
    _artistLabel.text = NSLocalizedString(@"artistLabel", nil);
    _artistViewUrlLabel.text = NSLocalizedString(@"artistViewUrlLabel", nil);
    _collectionCensoredNameLabel.text = NSLocalizedString(@"collectionCensoredNameLabel", nil);
    _collectionExplicitnessLabel.text = NSLocalizedString(@"collectionExplicitnessLabel", nil);
    _collectionPriceLabel.text = NSLocalizedString(@"collectionPriceLabel", nil);
    _countryLabel.text = NSLocalizedString(@"countryLabel", nil);
    _currencyLabel.text = NSLocalizedString(@"currencyLabel", nil);
    
    
    _songValueLabel.text = [_songDetails valueForKey:@"trackCensoredName"];
    _artistValueLabel.text = [_songDetails valueForKey:@"artistName"];
    _artistViewUrlValueLabel.text = [_songDetails valueForKey:@"artistViewUrl"];
    _collectionCensoredNameValueLabel.text = [_songDetails valueForKey:@"collectionCensoredName"];
    _collectionExplicitnessValueLabel.text = [_songDetails valueForKey:@"collectionExplicitness"];
    _collectionPriceValueLabel.text = [[_songDetails valueForKey:@"collectionPrice"] stringValue];
    _countryValueLabel.text = [_songDetails valueForKey:@"country"];
    _currencyValueLabel.text = [_songDetails valueForKey:@"currency"];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
