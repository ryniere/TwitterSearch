//
//  TwitterSearchTimeline.h
//  TwitterSearch
//
//  Created by Ryniere S Silva on 23/09/15.
//  Copyright © 2015 Ryniere S Silva. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TweetCellTableViewCell.h"

@interface TwitterSearchTimeline : UIViewController<UITableViewDelegate, UITableViewDataSource, SWTableViewCellDelegate>

+ (instancetype)loadFromNib:(NSString *)query;

@end
