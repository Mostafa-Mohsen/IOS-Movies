//
//  DetailsTableViewController.m
//  Popular Movies
//
//  Created by Mostafa on 4/8/19.
//  Copyright © 2019 M-M_M. All rights reserved.
//

#import "DetailsTableViewController.h"

@interface DetailsTableViewController ()

@end

@implementation DetailsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.movie = [self.moviedetailPresenter getMovie];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section == 0){
        return 3;
    }else if(section == 1){
        return self.movie.trailers.count;
    }else{
        return self.movie.reviews.count;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 0 && indexPath.row == 0){
        TitleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell1" forIndexPath:indexPath];
        cell.TitleV.text = self.movie.title;
         [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return cell;
    }else if(indexPath.section == 0 && indexPath.row == 1){
        PosterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell2" forIndexPath:indexPath];
        cell.rateV.text = [NSString stringWithFormat:@"%@/10",self.movie.vote_average];
        cell.dateV.text = self.movie.release_date;
        NSMutableString *link = [[NSMutableString alloc]initWithString:@"http://image.tmdb.org/t/p/w185/"];
        [link appendString:self.movie.poster_path];
        NSURL *url = [[NSURL alloc] initWithString:link];
        [cell.posterV sd_setImageWithURL:url placeholderImage:nil];
        
        HCSStarRatingView *starRatingView = [[HCSStarRatingView alloc] initWithFrame:CGRectMake(0  , 0, cell.starV.frame.size.width, cell.starV.frame.size.height)];
        starRatingView.maximumValue = 5;
        starRatingView.minimumValue = 0;
        starRatingView.allowsHalfStars = YES;
        starRatingView.accurateHalfStars = YES;
        starRatingView.value = [self.movie.vote_average floatValue]/2;
        starRatingView.tintColor = [UIColor yellowColor];
        [cell.starV addSubview:starRatingView];
        
        UIButton *favBtn = [cell viewWithTag:1];
        if([self.movie.fav isEqualToString:@"true"]){
            [favBtn setImage:[UIImage imageNamed:@"heart-full.png"] forState:UIControlStateNormal];
        }else{
            [favBtn setImage:[UIImage imageNamed:@"heart-empty.png"] forState:UIControlStateNormal];
        }
         [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return cell;
    }else if(indexPath.section == 0 && indexPath.row == 2){
        OverviewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell5" forIndexPath:indexPath];
        cell.overViewV.text = self.movie.overview;
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return cell;
    }else if(indexPath.section == 1){
        TrailerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell3" forIndexPath:indexPath];
        cell.trailerV.text = [NSString stringWithFormat:@"Trailer %d",indexPath.row+1];
        return cell;
    }else{
        ReviewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell4" forIndexPath:indexPath];
        MovieReviews *mr = self.movie.reviews[indexPath.row];
        cell.nameV.text = mr.author;
        cell.contentV.text = mr.content;
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return cell;
    }
 
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 1){
        [self.moviedetailPresenter openTrailer:indexPath.row];
    }
}

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if(section == 1){
        return @"Trailers";
    }else if(section == 2){
        return @"Reviews";
    }else{
        return @"";
    }
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

//-(void)favBtnClicked{
//    if([self.favBtn.currentImage isEqual:[UIImage imageNamed:@"heart-empty.png"]]){
//        [self.favBtn setImage:[UIImage imageNamed:@"heart-full.png"] forState:UIControlStateNormal];
//        [SQLManager UpdateFav:self.movie favourite:@"true"];
//    }else{
//        [self.favBtn setImage:[UIImage imageNamed:@"heart-empty.png"] forState:UIControlStateNormal];
//        [SQLManager UpdateFav:self.movie favourite:@"false"];
//    }
//}

- (IBAction)favFun:(id)sender {
    [self.moviedetailPresenter updateState:self.movie :sender];
}

-(void) opeTrailerPage : (NSURL*) url{
    UIApplication *app = [UIApplication sharedApplication];
    [app openURL:url];
}

-(void) updateFavState: (UIButton*) favBtnImg{
    if([self.movie.fav isEqualToString:@"true"]){
        [favBtnImg setImage:[UIImage imageNamed:@"heart-full.png"] forState:UIControlStateNormal];
    }else{
        [favBtnImg setImage:[UIImage imageNamed:@"heart-empty.png"] forState:UIControlStateNormal];
    }
}
@end
