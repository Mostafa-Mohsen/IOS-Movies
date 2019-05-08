//
//  MovieTrailers.h
//  Popular Movies
//
//  Created by Mostafa on 4/7/19.
//  Copyright © 2019 M-M_M. All rights reserved.
//

#import "RLMObject.h"



@interface MovieTrailers : RLMObject

@property NSString *url;

@end

RLM_ARRAY_TYPE(MovieTrailers)
