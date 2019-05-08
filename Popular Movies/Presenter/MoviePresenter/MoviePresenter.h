//
//  MoviePresenter.h
//  Popular Movies
//
//  Created by Mostafa on 3/30/19.
//  Copyright © 2019 M-M_M. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MovieContract.h"
#import "MovieService.h"
#import "DetailsTableViewController.h"
#import "MovieDetailPresenter.h"


@interface MoviePresenter : NSObject <IMoviePresenter>

@property id<IMovieView> movieView;

-(instancetype)initWithMoviewView : (id<IMovieView>) movieView;

@end

