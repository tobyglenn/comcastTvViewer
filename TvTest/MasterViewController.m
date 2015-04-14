//
//  MasterViewController.m
//  TvTest
//
//  Created by Peters, Toby on 4/13/15.
//  Copyright (c) 2015 Peters, Toby. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import <AFNetworking/AFHTTPRequestOperation.h>
#import "TVSummaryCell.h"
#import <AFNetworking/UIImageView+AFNetworking.h>

@interface MasterViewController ()
@property NSMutableArray *allData;
@property NSMutableArray *tvListings;
-(void)setTVListingsData:(int)index;
@end

@implementation MasterViewController

- (void)awakeFromNib {
    [super awakeFromNib];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.clearsSelectionOnViewWillAppear = NO;
        self.preferredContentSize = CGSizeMake(320.0, 600.0);
    }
    NSURL *url = [NSURL URLWithString:@"http://xfinitytv.comcast.net/api/xfinity/ipad/home/videos?filter&type=json"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.allData = [responseObject objectForKey:@"videoGalleries"];
        [self setTVListingsData:0];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Retrieving TV Listings"
                                                            message:[error localizedDescription]
                                                           delegate:nil
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil];
        [alertView show];
    }];
    [operation start];
}

-(void)setTVListingsData:(int)index {
    self.tvListings = [self.allData[index] objectForKey:@"items"];
    NSString *dateForListings = [self.allData[index] valueForKeyPath:@"header.name"];
    self.title = [NSString stringWithFormat:@"TV Listings from %@", dateForListings];
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSDate *tvListing = self.tvListings[indexPath.row];
        DetailViewController *controller = (DetailViewController *)[[segue destinationViewController] topViewController];
        [controller setDetailItem:tvListing];
        controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
        controller.navigationItem.leftItemsSupplementBackButton = YES;
    }
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tvListings.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TVSummaryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    NSDate *object = self.tvListings[indexPath.row];
    cell.name.text = [object valueForKey:@"videoName"];
    [cell.thumb setImageWithURL:[NSURL URLWithString:[object valueForKeyPath:@"entityThumbnailUrl"]]];
    [cell.brand setImageWithURL:[NSURL URLWithString:[object valueForKeyPath:@"networkLogoUrl"]]];
    [cell.brand setAccessibilityLabel:[object valueForKeyPath:@"videoBrand"]];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return NO;
}
- (IBAction)clickedListing:(UIButton *)sender {
    UIAlertController *alert = [self createAlert];
    
    // Finally present the action
    [self presentViewController:alert animated:YES completion:nil];
}

-(UIAlertController *)createAlert {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"What day would you like to view?" preferredStyle:UIAlertControllerStyleAlert];
    
    __weak MasterViewController *wself = self;
    
    //used just in case the API ever returns more than two days
    for (int i = 0; i < self.allData.count; i++) {
        [alert addAction:[UIAlertAction actionWithTitle:[self.allData[i] valueForKeyPath:@"header.name"] style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [wself setTVListingsData:i];
        }]];
    }
    
    // Add actions to the controller so they will appear
    [alert addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil]];

    return alert;
}

@end
