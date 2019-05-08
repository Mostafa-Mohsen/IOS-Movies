//
//  NetworkManager.h
//  Popular Movies
//
//  Created by Mostafa on 3/30/19.
//  Copyright © 2019 M-M_M. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetworkObserver.h"
#import "ServiceProtocol.h"
#import <AFNetworking.h>



@interface NetworkManager : NSObject

+(void) connectGetToURL : (NSString*) url serviceName : (NSString*) serviceName serviceProtocol : (id<ServiceProtocol>) serviceProtocol;

@end


