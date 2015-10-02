//
//  TweetCellTableViewCell.h
//  TwitterSearch
//
//  Created by Ryniere S Silva on 27/09/15.
//  Copyright © 2015 Ryniere S Silva. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SWTableViewCell/SWTableViewCell.h>

@interface TweetCellTableViewCell : SWTableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UILabel *text;

@end
