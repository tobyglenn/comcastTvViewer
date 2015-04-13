//
//  DetailViewController.m
//  TvTest
//
//  Created by Peters, Toby on 4/13/15.
//  Copyright (c) 2015 Peters, Toby. All rights reserved.
//

#import "DetailViewController.h"
#import <AFNetworking/UIImageView+AFNetworking.h>

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *videoImage;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@property (weak, nonatomic) IBOutlet UIImageView *brandLogo;
@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
            
        // Update the view.
        [self configureView];
    }
}

- (void)configureView {
    // Update the user interface for the detail item.
    if (self.detailItem) {
        self.detailDescriptionLabel.text = [self.detailItem valueForKey:@"videoDescription"];
        [self.videoImage setImageWithURL:[NSURL URLWithString:[self.detailItem valueForKeyPath:@"image.src"]]];
        [self.videoImage setAccessibilityLabel:[self.detailItem valueForKeyPath:@"image.alt"]];
    }else {
        self.detailDescriptionLabel.text = @"please select a listing to view the full content";
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
