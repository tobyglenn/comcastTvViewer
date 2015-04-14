//
//  TvTestTests.m
//  TvTestTests
//
//  Created by Peters, Toby on 4/13/15.
//  Copyright (c) 2015 Peters, Toby. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "MasterViewController.h"

@interface TvTestTests : XCTestCase

@property (nonatomic, strong) MasterViewController *vc;

@end

@interface MasterViewController (Testing)
@property NSMutableArray *allData;
@property NSMutableArray *tvListings;
-(UIAlertController *)createAlert;
@end

@implementation TvTestTests

- (void)setUp {
    [super setUp];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    self.vc = [storyboard instantiateViewControllerWithIdentifier:@"MasterViewController"];
    [self.vc performSelectorOnMainThread:@selector(loadView) withObject:nil waitUntilDone:YES];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"json"];
    NSError *error = nil;
    NSData *JSONData = [NSData dataWithContentsOfFile:filePath options:NSDataReadingMappedIfSafe error:&error];
    NSDictionary * parsedData = [NSJSONSerialization JSONObjectWithData:JSONData options:kNilOptions error:&error];
    self.vc.allData = [parsedData objectForKey:@"videoGalleries"];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

-(void)testThatViewLoads
{
    XCTAssertNotNil(self.vc.view, @"View not initiated properly");
}

-(void)testThatTableViewLoads
{
    XCTAssertNotNil(self.vc.tableView, @"TableView not initiated");
}

-(void)testThatDataIsThere
{
    XCTAssertNotNil(self.vc.allData, @"Data must be there from filesystem data file");
}

-(void)testAlert
{
    UIAlertController *alert = [self.vc createAlert];
    NSArray *actionsFromComponent = alert.actions;
    XCTAssertNotNil(actionsFromComponent, @"UIAlertController should have actions");
    UIAlertAction *first = actionsFromComponent[0];
    XCTAssertEqualObjects(@"Sun Night TV", first.title);
    UIAlertAction *second = actionsFromComponent[1];
    XCTAssertEqualObjects(@"Fri Night TV", second.title);
    UIAlertAction *cancel = actionsFromComponent[2];
    XCTAssertEqualObjects(@"Cancel", cancel.title);
}


@end
