//
//  MovieReviews.h
//  Popular Movies
//
//  Created by Mostafa on 4/7/19.
//  Copyright © 2019 M-M_M. All rights reserved.
//

#import "RLMObject.h"


@interface MovieReviews : RLMObject

@property NSString *author;
@property NSString *content;

@end
RLM_ARRAY_TYPE(MovieReviews)

