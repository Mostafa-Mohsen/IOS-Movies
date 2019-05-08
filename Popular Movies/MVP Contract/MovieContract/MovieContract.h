//
//  MovieContract.h
//  Popular Movies
//
//  Created by Mostafa on 3/30/19.
//  Copyright © 2019 M-M_M. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseContract.h"
#import "Movie.h"
@class MovieDetailPresenter;



@protocol IMovieView <NSObject,IBaseView>

-(void) renderMoviesWithObjects : (NSMutableArray*) movies;
-(void) openDetails : (MovieDetailPresenter*) movieDetailPresenter;
@end

@protocol IMoviePresenter <NSObject>

-(void) getPopularMovies;
-(void) getRatingMovies;
-(void) menuPop;
-(void) openMovieDetails: (Movie*)movie movieView: (id<IBaseDetailView>)movieView;
-(void) onSuccess : (NSMutableArray*) movies;
-(void)onFail : (NSString*) errorMessage;

@end

@protocol IFavMoviePresenter <NSObject>

-(void) getFavPopularMovies;
-(void) getFavRatingMovies;
-(void) getAllFavMovies;
-(void) menuPop;
-(void) openMovieDetails: (Movie*)movie movieView: (id<IBaseDetailView>)movieView;
-(void) onSuccess : (NSMutableArray*) movies;
-(void)onFail : (NSString*) errorMessage;

@end

@protocol IDetailMoviePresenter <NSObject>

-(Movie*) getMovie;
-(void) openTrailer : (int) trailer;
-(void) updateState : (Movie*) movie : (UIButton*) favBtn;
-(void) reloadAfterUpdate;

@end

@protocol IMovieManager <NSObject>

-(void) getMovies : (id<IMoviePresenter>) moviePresenter : (NSString*) dataUrl:(NSString*)type;
-(void)getFavMovies:(id<IFavMoviePresenter>)favMoviePresenter:(NSString*)type;
-(void) updateMovie :(id<IDetailMoviePresenter>) detialMoviePresenter movie:(Movie*)movie fav: (NSString*) fav;
@end




