//
//  TwitterQuery.m
//  TwitterSearch
//
//  Created by Ryniere S Silva on 01/10/15.
//  Copyright © 2015 Ryniere S Silva. All rights reserved.
//

#import "TwitterQuery.h"

@implementation TwitterQuery

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.searchedAt = [NSDate date];
    }
    return self;
}

@end
