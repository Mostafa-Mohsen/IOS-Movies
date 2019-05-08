//
//  SQLObserver.h
//  Popular Movies
//
//  Created by Mostafa on 3/31/19.
//  Copyright © 2019 M-M_M. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol SQLObserver <NSObject>

-(void) handleSuccessWithSQL : (NSString*) serviceName  : (NSArray*) movies;
-(void) handleSQLFailWithErrorMessage : (NSString*) serviceName : (NSString*) errorMessage;

@end


