//
//  BaseContract.h
//  Popular Movies
//
//  Created by Mostafa on 3/30/19.
//  Copyright © 2019 M-M_M. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@protocol IBaseView <NSObject>

-(void) showLoading;
-(void) hideLoading;
-(void) createPopMenu;
-(void) changeLoader;
-(void) showErrorMessage : (NSString*) errorMessage;

@end

@protocol IBaseDetailView <NSObject>

-(void) opeTrailerPage : (NSURL*) url;
-(void) updateFavState: (UIButton*) favBtnImg;

@end
