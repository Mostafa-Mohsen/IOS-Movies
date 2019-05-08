//
//  MovieDetailPresenter.h
//  Popular Movies
//
//  Created by Mostafa on 4/5/19.
//  Copyright © 2019 M-M_M. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MovieContract.h"

@interface MovieDetailPresenter : NSObject <IDetailMoviePresenter>

@property Movie *movie;
@property id<IBaseDetailView> movieView;
-(instancetype)initWithDetailPresenter : (Movie*)movie : (id<IBaseDetailView>) movieView;

@end


