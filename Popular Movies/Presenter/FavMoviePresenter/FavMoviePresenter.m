//
//  FavMoviePresenter.m
//  Popular Movies
//
//  Created by Mostafa on 4/9/19.
//  Copyright © 2019 M-M_M. All rights reserved.
//

#import "FavMoviePresenter.h"

@implementation FavMoviePresenter

-(instancetype)initWithMoviewView : (id<IMovieView>) movieView{
    self = [super init];
    if(self){
        self.movieView = movieView;
    };
    return self;
}

-(void) getFavPopularMovies{
    [self.movieView showLoading];
    MovieService *movieService = [MovieService new];
    [movieService getFavMovies:self:@"popular"];
}

-(void) getFavRatingMovies{
    [self.movieView showLoading];
    MovieService *movieService = [MovieService new];
    [movieService getFavMovies:self:@"rate"];
}

-(void) getAllFavMovies{
    [self.movieView showLoading];
    MovieService *movieService = [MovieService new];
    [movieService getFavMovies:self:@"rate AND type == 'popular'"];
}

-(void) onSuccess : (NSMutableArray*) movies{
    [self.movieView renderMoviesWithObjects:movies];
    [self.movieView hideLoading];
}
-(void)onFail : (NSString*) errorMessage{
    [self.movieView showErrorMessage:errorMessage];
    [self.movieView hideLoading];
}

-(void)menuPop{
    [self.movieView createPopMenu];
}
-(void) openMovieDetails: (Movie*)movie movieView: (id<IBaseDetailView>)movieView{
    MovieDetailPresenter *movieDetailPresenter = [[MovieDetailPresenter alloc] initWithDetailPresenter:movie:movieView];
    [self.movieView openDetails:movieDetailPresenter];
}


@end
