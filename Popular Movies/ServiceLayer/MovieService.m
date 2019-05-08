//
//  MovieService.m
//  Popular Movies
//
//  Created by Mostafa on 3/30/19.
//  Copyright © 2019 M-M_M. All rights reserved.
//

#import "MovieService.h"

@implementation MovieService

-(void)getMovies:(id<IMoviePresenter>)moviePresenter:(NSString*)dataUrl:(NSString*)type{
    
    self.moviePresenter = moviePresenter;
    self.type = type;
//    @"https://api.themoviedb.org/3/movie/popular?&api_key=1e90167726d4a14aa046260118a10a24"
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status){
        NSLog(@"status changed");
        //check for isReachable here
        bool isThere = [[AFNetworkReachabilityManager sharedManager] isReachable];
        if(isThere){
            printf("there is network\n");
            [NetworkManager connectGetToURL:dataUrl serviceName:@"MoviesService" serviceProtocol:self];
        }else{
            printf("no network\n");
            if([self.type isEqualToString:@"popular"]){
                [SQLManager ReadFromSqlServiceName:@"MoviesSQLService" serviceProtocol:self type:@"type == 'popular'"];
            }else if([self.type isEqualToString:@"rate"]){
                [SQLManager ReadFromSqlServiceName:@"MoviesSQLService" serviceProtocol:self type:@"type == 'rate'"];
            }
        }
    }];

}

-(void)handleSuccessWithJSONData:(id)jsonData :(NSString *)serviceName{
    
    if ([serviceName isEqualToString:@"MoviesService"]) {
        NSDictionary *dic = (NSDictionary*)jsonData;
        NSArray *array = [dic objectForKey:@"results"];
        self.movies = [NSMutableArray new];
        for(int i = 0 ; i < array.count ; i++){
            NSDictionary *dic1 = array[i];
            Movie *movie = [Movie new];
            movie.idd = [dic1 objectForKey:@"id"];
            movie.vote_average = [dic1 objectForKey:@"vote_average"];
            movie.title = [dic1 objectForKey:@"title"];
            movie.poster_path = [dic1 objectForKey:@"poster_path"];
            movie.overview = [dic1 objectForKey:@"overview"];
            movie.release_date = [dic1 objectForKey:@"release_date"];
            movie.type = self.type;
            movie.fav = @"false";
            [self.movies addObject:movie];
        }
        self.counter = 0;
        [NetworkManager connectGetToURL:[NSString stringWithFormat:@"http://api.themoviedb.org/3/movie/%@/videos?api_key=1e90167726d4a14aa046260118a10a24",self.movies[self.counter].idd] serviceName:@"TrailersService" serviceProtocol:self];
        
    }

    else if ([serviceName isEqualToString:@"TrailersService"]) {
        NSDictionary *dic = (NSDictionary*)jsonData;
        NSArray* array = [dic objectForKey:@"results"];
        for(int i = 0 ; i < array.count ; i++){
            NSDictionary *dic1 = array[i];
            NSString *idd1 = [dic1 objectForKey:@"key"];
            MovieTrailers *mt = [MovieTrailers new];
            mt.url = idd1;
            [self.movies[self.counter].trailers addObject:mt];
        }
        self.counter++;
        if(self.counter < self.movies.count){
            [NetworkManager connectGetToURL:[NSString stringWithFormat:@"http://api.themoviedb.org/3/movie/%@/videos?api_key=1e90167726d4a14aa046260118a10a24",self.movies[self.counter].idd] serviceName:@"TrailersService" serviceProtocol:self];
        }else{
            self.counter = 0;
            [NetworkManager connectGetToURL:[NSString stringWithFormat:@"https://api.themoviedb.org/3/movie/%@/reviews?api_key=1e90167726d4a14aa046260118a10a24",self.movies[self.counter].idd] serviceName:@"ReviewsService" serviceProtocol:self];
        }
        
    }
    else if ([serviceName isEqualToString:@"ReviewsService"]) {
        NSDictionary *dic = (NSDictionary*)jsonData;
        NSArray* array = [dic objectForKey:@"results"];
        for(int i = 0 ; i < array.count ; i++){
            NSDictionary *dic1 = array[i];
            MovieReviews *mr = [MovieReviews new];
            mr.author = [dic1 objectForKey:@"author"];
            mr.content = [dic1 objectForKey:@"content"];
            [self.movies[self.counter].reviews addObject:mr];
        }
        self.counter++;
        if(self.counter < self.movies.count){
           [NetworkManager connectGetToURL:[NSString stringWithFormat:@"https://api.themoviedb.org/3/movie/%@/reviews?api_key=1e90167726d4a14aa046260118a10a24",self.movies[self.counter].idd] serviceName:@"ReviewsService" serviceProtocol:self];
        }else{
            self.counter = 0;
//            NSLog(@"%@",self.movies[0].reviews);
//            [self.moviePresenter onSuccess:self.movies];
            if([self.type isEqualToString:@"popular"]){
                [SQLManager saveToSQL:self.movies serviceName:@"MoviesSQLService" serviceProtocol:self type:@"type == 'popular' AND fav == 'false'"];
            }else if([self.type isEqualToString:@"rate"]){
                [SQLManager saveToSQL:self.movies serviceName:@"MoviesSQLService" serviceProtocol:self type:@"type == 'rate' AND fav == 'false'"];
            }
            if([self.type isEqualToString:@"popular"]){
                [SQLManager ReadFromSqlServiceName:@"MoviesSQLService" serviceProtocol:self type:@"type == 'popular'"];
            }else if([self.type isEqualToString:@"rate"]){
                [SQLManager ReadFromSqlServiceName:@"MoviesSQLService" serviceProtocol:self type:@"type == 'rate'"];
            }
        }
    }

}

-(void)handleFailWithErrorMessage:(NSString *)errorMessage{

    [self.moviePresenter onFail:errorMessage];
    
}

-(void) handleSuccessWithSQL : (NSString*) serviceName  : (NSArray*) movies{
    if ([serviceName isEqualToString:@"MoviesSQLService"]) {
        [self.moviePresenter onSuccess:movies];
    }else if([serviceName isEqualToString:@"MoviesFavSQLService"]){
        [self.favMoviePresenter onSuccess:movies];
    }else if([serviceName isEqualToString:@"update"]){
        [self.detailMoviePresenter reloadAfterUpdate];
    }
}
-(void) handleSQLFailWithErrorMessage : (NSString*) serviceName : (NSString*) errorMessage{
    if ([serviceName isEqualToString:@"MoviesSQLService"]) {
        [self.moviePresenter onFail:errorMessage];
    }else if([serviceName isEqualToString:@"MoviesFavSQLService"]){
        [self.favMoviePresenter onFail:errorMessage];
    }
}

-(void)getFavMovies:(id<IFavMoviePresenter>)favMoviePresenter:(NSString*)type{
    self.favMoviePresenter = favMoviePresenter;
    self.type = type;
    if([self.type isEqualToString:@"popular"]){
        [SQLManager ReadFromSqlServiceName:@"MoviesFavSQLService" serviceProtocol:self type:@"type == 'popular' AND fav == 'true'"];
    }else if([self.type isEqualToString:@"rate"]){
        [SQLManager ReadFromSqlServiceName:@"MoviesFavSQLService" serviceProtocol:self type:@"type == 'rate' AND fav == 'true'"];
    }else if([self.type isEqualToString:@"rate AND type == 'popular'"]){
        [SQLManager ReadFromSqlServiceName:@"MoviesFavSQLService" serviceProtocol:self type:@"fav == 'true'"];
    }
}

-(void) updateMovie :(id<IDetailMoviePresenter>) detialMoviePresenter movie:(Movie*)movie fav: (NSString*) fav{
    self.detailMoviePresenter = detialMoviePresenter;
    [SQLManager UpdateFav:movie favourite:fav serviceName:@"update" serviceProtocol:self];
}
@end
