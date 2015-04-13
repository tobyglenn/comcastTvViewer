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

@implementation TvTestTests

- (void)setUp {
    [super setUp];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    self.vc = [storyboard instantiateViewControllerWithIdentifier:@"MasterViewController"];
    [self.vc performSelectorOnMainThread:@selector(loadView) withObject:nil waitUntilDone:YES];
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


@end
