//
//  FavCollectionViewController.m
//  Popular Movies
//
//  Created by Mostafa on 4/9/19.
//  Copyright © 2019 M-M_M. All rights reserved.
//

#import "FavCollectionViewController.h"

@interface FavCollectionViewController (){
    DetailsTableViewController *DTVC;
}

@end

@implementation FavCollectionViewController
static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Favourite";
    self.urls = [NSMutableArray new];
    
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated{
    self.favMoviePresenter = [[FavMoviePresenter alloc] initWithMoviewView:self];
    [self.favMoviePresenter getAllFavMovies];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
#warning Incomplete implementation, return the number of sections
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of items
    return self.urls.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    if(self.urls.count > 0){
        Movie *movie = self.urls[indexPath.row];
        NSMutableString *link = [[NSMutableString alloc]initWithString:@"http://image.tmdb.org/t/p/w185/"];
        [link appendString:movie.poster_path];
        UIImageView *imageV = (UIImageView*)[cell viewWithTag:1];
        NSURL *url = [[NSURL alloc] initWithString:link];
        [cell setAutoresizesSubviews:YES];
        [imageV sd_setImageWithURL:url placeholderImage:nil];
    }
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat devWidth;
    CGSize size;
    if(UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation)){
        devWidth = self.view.bounds.size.width;
        size = CGSizeMake((devWidth/3),210.0);
    }else{
        devWidth = self.view.frame.size.width;
        size = CGSizeMake((devWidth/2),190.0);
    }
    return size;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    DTVC = [self.storyboard instantiateViewControllerWithIdentifier:@"DTVC"];
    [self.favMoviePresenter openMovieDetails:self.urls[indexPath.row] movieView:DTVC];
}

#pragma mark <UICollectionViewDelegate>

/*
 // Uncomment this method to specify if the specified item should be highlighted during tracking
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
 return YES;
 }
 */

/*
 // Uncomment this method to specify if the specified item should be selected
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
 return YES;
 }
 */

/*
 // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
 return NO;
 }
 
 - (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
 return NO;
 }
 
 - (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
 
 }
 */

-(void) renderMoviesWithObjects : (NSMutableArray*) movies{
    self.urls = movies;
    [self.collectionView reloadData];
}

-(void) showLoading{
    printf("show Loading\n");
    self.urls = [NSMutableArray new];
    [self.collectionView reloadData];
}

-(void) hideLoading{
    printf("hide Loading\n");
}
-(void) showErrorMessage : (NSString*) errorMessage{
    printf("Show Error\n");
}

- (IBAction)menuBtn:(id)sender {
    [self.favMoviePresenter menuPop];
    
}

-(instancetype)initWithDetailPresenter : (FavMoviePresenter*) favMovieView{
    self = [super init];
    if(self){
        self.favMoviePresenter = favMovieView;
    };
    return self;
}

-(void) createPopMenu{
    [FTPopOverMenu showFromSenderFrame:CGRectMake(self.view.frame.size.width - 47, 20, 40, 40) withMenuArray:@[@"All",@"Popular",@"Rating"] doneBlock:^(NSInteger selectedIndex) {
        switch (selectedIndex) {
            case 0:{
                [self.favMoviePresenter getAllFavMovies];
            }
                break;
            case 1:{
                printf("popular\n");
                [self.favMoviePresenter getFavPopularMovies];
            }
                break;
            case 2:{
                printf("rate\n");
                [self.favMoviePresenter getFavRatingMovies];
            }
                break;
            default:
                break;
        }
    } dismissBlock:^(){
        
    }];
}

-(void) openDetails : (MovieDetailPresenter*) movieDetailPresenter{
    DTVC.moviedetailPresenter = movieDetailPresenter;
    [DTVC setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:DTVC animated:YES];
}


@end

