//
//  TwitterQuery.h
//  TwitterSearch
//
//  Created by Ryniere S Silva on 01/10/15.
//  Copyright © 2015 Ryniere S Silva. All rights reserved.
//

#import <Realm/Realm.h>

@interface TwitterQuery : RLMObject

@property NSString *query;
@property NSDate *searchedAt;

@end
