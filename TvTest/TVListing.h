//
//  TVListing.h
//  TvTest
//
//  Created by Peters, Toby on 4/13/15.
//  Copyright (c) 2015 Peters, Toby. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TVListing : NSObject
@property (nonatomic) int entityEpisodeCount;
@property (weak, nonatomic) NSString* entityName;
@property (weak, nonatomic) NSString* entityPosterArtUrl;
@property (weak, nonatomic) NSString* entityThumbnailUrl;
@property (weak, nonatomic) NSString* imgSrc;
@property (weak, nonatomic) NSString* imgAlt;
@property (weak, nonatomic) NSString* networkLogoUrl;
@property (nonatomic) int episodeNumber;
@property (nonatomic) int episodeSeasonNumber;
@property (weak, nonatomic) NSString* link;
@property (weak, nonatomic) NSString* videoRating;
@property (weak, nonatomic) NSString* videoAirDate;
@property (weak, nonatomic) NSString* videoDescription;
@end
