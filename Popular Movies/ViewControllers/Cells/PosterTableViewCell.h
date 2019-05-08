//
//  PosterTableViewCell.h
//  Popular Movies
//
//  Created by Mostafa on 4/8/19.
//  Copyright © 2019 M-M_M. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PosterTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *posterV;
@property (weak, nonatomic) IBOutlet UILabel *dateV;

@property (weak, nonatomic) IBOutlet UILabel *rateV;


@property (weak, nonatomic) IBOutlet UIView *starV;


@end

