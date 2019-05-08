//
//  NetworkManager.m
//  Popular Movies
//
//  Created by Mostafa on 3/30/19.
//  Copyright © 2019 M-M_M. All rights reserved.
//

#import "NetworkManager.h"

@implementation NetworkManager

static id<NetworkObserver> networkObserverDelegate;
static NSString* classServiceName;

+(void)connectGetToURL:(NSString *)url serviceName:(NSString *)serviceName serviceProtocol:(id<ServiceProtocol>)serviceProtocol{
    
    classServiceName = serviceName;
    networkObserverDelegate = serviceProtocol;
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *URL = [NSURL URLWithString:url];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            
            [networkObserverDelegate handleFailWithErrorMessage:[error localizedDescription]];
        } else {
            
            [networkObserverDelegate handleSuccessWithJSONData: responseObject:classServiceName];
        }
    }];
    [dataTask resume];
    
}

@end
