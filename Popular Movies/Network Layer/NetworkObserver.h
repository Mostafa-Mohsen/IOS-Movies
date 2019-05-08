//
//  NetworkObserver.h
//  Popular Movies
//
//  Created by Mostafa on 3/30/19.
//  Copyright © 2019 M-M_M. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol NetworkObserver <NSObject>

-(void) handleSuccessWithJSONData : (id) jsonData : (NSString*) serviceName;
-(void) handleFailWithErrorMessage : (NSString*) errorMessage;

@end

NS_ASSUME_NONNULL_END
