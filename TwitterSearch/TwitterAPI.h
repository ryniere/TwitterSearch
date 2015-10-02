//
//  TwitterAPI.h
//  TwitterSearch
//
//  Created by Ryniere S Silva on 27/09/15.
//  Copyright © 2015 Ryniere S Silva. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <TwitterKit/TwitterKit.h>

@interface TwitterAPI : TWTRAPIClient


/**
 *  Singleton Instance
 *
 *  @return return the singleton instance of the class TwitterAPI
 */
+ (id)sharedManager;

/**
 *  Search for tweets
 *
 *  @param query   query to search
 *  @param success block to execute on success
 *  @param fail    block to execute on fail
 */
- (void) searchTweetsWithQuery:(NSString *)query success:(void(^)(NSDictionary *searchMetadata, NSArray *statuses))success fail:(void(^)(NSError *error))fail;

/**
 *  Get the trending topics of a specific location
 *
 *  @param locationID  The Yahoo! Where On Earth ID of the location to return trending information for. Global information is available by using 1 as the WOEID
 *  @param success    block to execute on success
 *  @param fail       block to execute on fail
 */
- (void) getTrends:(NSString *)locationID success:(void(^)(NSArray *trends))success fail:(void(^)(NSError *error))fail;

@end
