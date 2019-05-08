//
//  CollectionViewController.h
//  Popular Movies
//
//  Created by Mostafa on 3/30/19.
//  Copyright © 2019 M-M_M. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MoviePresenter.h"
#import "MovieContract.h"
#import "Movie.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <FTPopOverMenu.h>
#import <DGActivityIndicatorView.h>
#import "DetailsTableViewController.h"
NS_ASSUME_NONNULL_BEGIN

@interface CollectionViewController : UICollectionViewController    <IMovieView>

- (IBAction)menuBtn:(id)sender;
@property MoviePresenter *moviePresenter;


@property NSMutableArray *urls;

@end

NS_ASSUME_NONNULL_END
