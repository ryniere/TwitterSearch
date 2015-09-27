//
//  TwitterAPI.m
//  TwitterSearch
//
//  Created by Ryniere S Silva on 27/09/15.
//  Copyright © 2015 Ryniere S Silva. All rights reserved.
//

#import "TwitterAPI.h"

@implementation TwitterAPI

static NSString *const kTwitterApiBaseUrl = @"https://api.twitter.com/1.1/";


- (id)init {
    self = [super init];
    if(!self) return nil;
    
    
    return self;
}

+ (id)sharedManager {
    static TwitterAPI *_twitterAPI = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _twitterAPI = [[self alloc] init];
    });
    
    return _twitterAPI;
}


- (void) searchTweetsWithQuery:(NSString *)query success:(void(^)(NSDictionary *searchMetadata, NSArray *statuses))success fail:(void(^)(NSError *error))fail{
    
    NSError *clientError;
    NSString *url = [NSString stringWithFormat:@"%@%@", kTwitterApiBaseUrl, @"search/tweets.json" ];
    NSURLRequest *request = [[[Twitter sharedInstance] APIClient]URLRequestWithMethod:@"GET" URL:url parameters:@{@"q" : query} error:&clientError];
    
    if (request) {
        [self sendTwitterRequest:request completion:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
            if (data) {
                // handle the response data e.g.
                NSError *jsonError;
                NSDictionary *response = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
                
                if (jsonError == nil) {
                    NSDictionary *searchMetadata = [response valueForKey:@"search_metadata"];
                    NSArray *statuses = [response valueForKey:@"statuses"];
                    success(searchMetadata, statuses);
                }
                else{
                    NSLog(@"Error: %@", jsonError);
                    fail(jsonError);
                }
            }
            else {
                NSLog(@"Error: %@", connectionError);
                fail(connectionError);
            }
        }];
    }
    else {
        NSLog(@"Error: %@", clientError);
        fail(clientError);
    }
}

@end
