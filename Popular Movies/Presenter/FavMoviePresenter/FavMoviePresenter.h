//
//  FavMoviePresenter.h
//  Popular Movies
//
//  Created by Mostafa on 4/9/19.
//  Copyright © 2019 M-M_M. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MovieContract.h"
#import "MovieService.h"
#import "MovieDetailPresenter.h"


@interface FavMoviePresenter : NSObject <IFavMoviePresenter>

@property id<IMovieView> movieView;

-(instancetype)initWithMoviewView : (id<IMovieView>) movieView;

@end
