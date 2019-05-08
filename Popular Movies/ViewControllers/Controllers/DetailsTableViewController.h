//
//  DetailsTableViewController.h
//  Popular Movies
//
//  Created by Mostafa on 4/8/19.
//  Copyright © 2019 M-M_M. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import <HCSStarRatingView.h>
#import "Movie.h"
#import "TrailerTableViewCell.h"
#import "TitleTableViewCell.h"
#import "PosterTableViewCell.h"
#import "ReviewTableViewCell.h"
#import "OverviewTableViewCell.h"
#import "MovieReviews.h"
#import "MovieTrailers.h"
#import "SQLManager.h"
#import "MovieDetailPresenter.h"

@interface DetailsTableViewController : UITableViewController <IBaseDetailView>
- (IBAction)favFun:(id)sender;

@property MovieDetailPresenter *moviedetailPresenter;
@property Movie *movie;

@end


