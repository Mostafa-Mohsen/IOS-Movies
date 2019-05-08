//
//  Movie.h
//  Popular Movies
//
//  Created by Mostafa on 3/30/19.
//  Copyright © 2019 M-M_M. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RLMObject.h"
#import "RLMArray.h"
#import "MovieTrailers.h"
#import "MovieReviews.h"


@interface Movie : RLMObject
@property NSString *idd;
@property NSString *vote_average;
@property NSString *title;
@property NSString *poster_path;
@property NSString *overview;
@property NSString *release_date;
@property NSString *type;
@property NSString *fav;
@property NSDate *date;
@property RLMArray<MovieTrailers *><MovieTrailers> *trailers;
@property RLMArray<MovieReviews *><MovieReviews> *reviews;
@end


