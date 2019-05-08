//
//  SQLManager.h
//  Popular Movies
//
//  Created by Mostafa on 3/31/19.
//  Copyright © 2019 M-M_M. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SQLObserver.h"
#import "SQLServiceProtocol.h"
#import <Realm.h>
#import "Movie.h"

@interface SQLManager : NSObject

+(void) saveToSQL : (NSArray*) movies serviceName : (NSString*) serviceName serviceProtocol : (id<SQLServiceProtocol>) serviceProtocol type: (NSString*)type;
+(void*) ReadFromSqlServiceName : (NSString*) serviceName serviceProtocol : (id<SQLServiceProtocol>) serviceProtocol type: (NSString*)type;
+(void) UpdateFav: (Movie*)movie favourite: (NSString*)fav serviceName: (NSString*)serviceName serviceProtocol: (id<SQLServiceProtocol>) serviceProtocol;


@end

