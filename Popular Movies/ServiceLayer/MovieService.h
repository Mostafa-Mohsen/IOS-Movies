//
//  MovieService.h
//  Popular Movies
//
//  Created by Mostafa on 3/30/19.
//  Copyright © 2019 M-M_M. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetworkObserver.h"
#import "ServiceProtocol.h"
#import "MovieContract.h"
#import "NetworkManager.h"
#import "Movie.h"
#import "SQLServiceProtocol.h"
#import "SQLObserver.h"
#import "SQLManager.h"
#import "MovieTrailers.h"

NS_ASSUME_NONNULL_BEGIN

@interface MovieService : NSObject <NetworkObserver , ServiceProtocol , IMovieManager , SQLObserver , SQLServiceProtocol>

@property id<IMoviePresenter> moviePresenter;
@property NSString *type;
@property NSMutableArray<Movie*> *movies;
@property int counter;

@property id<IFavMoviePresenter> favMoviePresenter;
@property id<IDetailMoviePresenter> detailMoviePresenter;

@end

NS_ASSUME_NONNULL_END
