//
//  FavCollectionViewController.h
//  Popular Movies
//
//  Created by Mostafa on 4/9/19.
//  Copyright © 2019 M-M_M. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FavMoviePresenter.h"
#import "MovieContract.h"
#import "Movie.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <FTPopOverMenu.h>
#import "DetailsTableViewController.h"

@interface FavCollectionViewController : UICollectionViewController <IMovieView>

@property FavMoviePresenter *favMoviePresenter;
@property NSMutableArray *urls;

- (IBAction)menuBtn:(id)sender;

-(instancetype)initWithDetailPresenter : (FavMoviePresenter*) favMovieView;

@end

