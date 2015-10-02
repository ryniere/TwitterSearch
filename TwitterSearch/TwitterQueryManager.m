//
//  TwitterQueryManager.m
//  TwitterSearch
//
//  Created by Ryniere S Silva on 01/10/15.
//  Copyright © 2015 Ryniere S Silva. All rights reserved.
//

#import "TwitterQueryManager.h"

@interface TwitterQueryManager()

@property RLMRealm *realm;

@end

@implementation TwitterQueryManager

+ (id)sharedManager {
    static TwitterQueryManager *sharedTwitterQueryManager= nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedTwitterQueryManager = [[self alloc] init];
        sharedTwitterQueryManager.realm = [RLMRealm defaultRealm];
    });
    return sharedTwitterQueryManager;
}

- (void) addTwitterQuery:(TwitterQuery *) twitterQuery{
    
    // Add to Realm with transaction
    [self.realm beginWriteTransaction];
    [self.realm addObject:twitterQuery];
    [self.realm commitWriteTransaction];
    
}

- (RLMResults *) getLastTwitterQueries{
    
    return [[TwitterQuery allObjects] sortedResultsUsingProperty:@"searchedAt" ascending:false];
}

- (TwitterQuery *) getLastTwitterQueryAtIndex:(NSInteger)index{
    
    return [[self getLastTwitterQueries] objectAtIndex:index];
}

@end
