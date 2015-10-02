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

- (RLMResults *) getLastTwitterQueries;
- (TwitterQuery *) getLastTwitterQueryAtIndex:(NSInteger)index;

@end
