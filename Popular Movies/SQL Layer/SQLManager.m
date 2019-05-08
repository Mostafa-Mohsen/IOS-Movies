//
//  SQLManager.m
//  Popular Movies
//
//  Created by Mostafa on 3/31/19.
//  Copyright © 2019 M-M_M. All rights reserved.
//

#import "SQLManager.h"

@implementation SQLManager

static id<SQLObserver> SQLObserverDelegate;
static NSString* classServiceName;

+(void) saveToSQL : (NSArray*) movies serviceName : (NSString*) serviceName serviceProtocol : (id<SQLServiceProtocol>) serviceProtocol type: (NSString*)type{
    classServiceName = serviceName;
    SQLObserverDelegate = serviceProtocol;
    
    RLMRealm *realm = [RLMRealm defaultRealm];
    
    
    RLMResults *results = [Movie objectsWhere:type];
    if(results.count > 0){
        [realm beginWriteTransaction];
        for (Movie *movie in results){
            [realm deleteObject:movie];
        }
        [realm commitWriteTransaction];
    }else{
        
    }
    
    [realm beginWriteTransaction];
    for (Movie *movie in movies) {
        movie.idd = [NSString stringWithFormat:@"%@",movie.idd];
        RLMResults<Movie*> *updateMovie =  [Movie objectsWhere:[NSString stringWithFormat:@"idd == \"%@\"",movie.idd]];
        if(updateMovie.count > 0){
            printf("i am here\n");
            [[updateMovie firstObject] setValue:[NSDate date] forKeyPath:@"date"];
            [realm commitWriteTransaction];
            [realm beginWriteTransaction];
        }else{
            movie.vote_average = [NSString stringWithFormat:@"%@",movie.vote_average];
            movie.date = [NSDate date];
            [realm addObject:movie];
        }
    }
    [realm commitWriteTransaction];
    
   
}

+(void) ReadFromSqlServiceName : (NSString*) serviceName serviceProtocol : (id<SQLServiceProtocol>) serviceProtocol type: (NSString*) type{
    classServiceName = serviceName;
    SQLObserverDelegate = serviceProtocol;
    RLMRealm *realm = [RLMRealm defaultRealm];
    RLMResults *results = [Movie objectsWhere:type];
    [results sortedResultsUsingKeyPath:@"date" ascending:NO];
    if(results.count > 0){
        [SQLObserverDelegate handleSuccessWithSQL:classServiceName :results];
    }else{
        [SQLObserverDelegate handleSQLFailWithErrorMessage:serviceName :@"failed to load data"];
    }
}

+(void) UpdateFav: (Movie*)movie favourite: (NSString*)fav serviceName: (NSString*)serviceName serviceProtocol: (id<SQLServiceProtocol>) serviceProtocol{
    classServiceName = serviceName;
    SQLObserverDelegate = serviceProtocol;
    RLMRealm *realm =[RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    if([fav isEqualToString:@"true"]){
        movie.fav = @"true";
    }else{
        movie.fav = @"false";
    }
    [realm commitWriteTransaction];
    RLMResults *results = [Movie objectsWhere:[NSString stringWithFormat:@"idd == '%@'",movie.idd]];
    [SQLObserverDelegate handleSuccessWithSQL:classServiceName :results];
}

@end
