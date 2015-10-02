//
//  TwitterQueryManager.h
//  TwitterSearch
//
//  Created by Ryniere S Silva on 01/10/15.
//  Copyright © 2015 Ryniere S Silva. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>
#import "TwitterQuery.h"

@interface TwitterQueryManager : NSObject

+ (id)sharedManager;

- (void) addTwitterQuery:(TwitterQuery *) twitterQuery;

/**
 *  Get the queries already searched
 *
 *  @return
 */
- (RLMResults *) getLastTwitterQueries;

/**
 *  Get the searched query at given index
 *
 *  @param index index to retrieve
 *
 *  @return query at given index
 */
- (TwitterQuery *) getLastTwitterQueryAtIndex:(NSInteger)index;

@end
