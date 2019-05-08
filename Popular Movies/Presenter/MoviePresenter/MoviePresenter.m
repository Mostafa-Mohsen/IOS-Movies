//
//  MoviePresenter.m
//  Popular Movies
//
//  Created by Mostafa on 3/30/19.
//  Copyright © 2019 M-M_M. All rights reserved.
//

#import "MoviePresenter.h"

@implementation MoviePresenter{
    Boolean state;
    
}

-(instancetype)initWithMoviewView : (id<IMovieView>) movieView{
    self = [super init];
    if(self){
        self.movieView = movieView;
    };
    return self;
}

-(void) getPopularMovies{
    [self.movieView showLoading];
    state = true;
    MovieService *movieService = [MovieService new];
    [movieService getMovies:self:@"https://api.themoviedb.org/3/movie/popular?&api_key=1e90167726d4a14aa046260118a10a24":@"popular"];
}

-(void) getRatingMovies{
    [self.movieView showLoading];
    state = true;
    MovieService *movieService = [MovieService new];
    [movieService getMovies:self:@"https://api.themoviedb.org/3/movie/top_rated?api_key=1e90167726d4a14aa046260118a10a24&language=en-US":@"rate"];
}

-(void) onSuccess : (NSMutableArray*) movies{
    [self.movieView renderMoviesWithObjects:movies];
    [self.movieView hideLoading];
    state = false;
}
-(void)onFail : (NSString*) errorMessage{
    [self.movieView showErrorMessage:errorMessage];
    [self.movieView hideLoading];
    state = false;
}
-(void)menuPop{
    if(!state){
        [self.movieView createPopMenu];
    }else{
        [self.movieView changeLoader];
    }
}
-(void) openMovieDetails: (Movie*)movie movieView: (id<IBaseDetailView>)movieView{
    MovieDetailPresenter *movieDetailPresenter = [[MovieDetailPresenter alloc] initWithDetailPresenter:movie:movieView];
    [self.movieView openDetails:movieDetailPresenter];
}


@end
