//
//  TwitterSearchTimeline.m
//  TwitterSearch
//
//  Created by Ryniere S Silva on 23/09/15.
//  Copyright © 2015 Ryniere S Silva. All rights reserved.
//

#import "TwitterSearchTimeline.h"
#import "TwitterAPI.h"
#import "TweetCellTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface TwitterSearchTimeline ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic,strong) NSArray *results;
@property (nonatomic,strong) NSString *query;

@end

@implementation TwitterSearchTimeline

/**
 *
 *
 *  @param query value to search
 *
 *  @return the class inntance
 */
+ (instancetype)loadFromNib:(NSString *)query
{
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    TwitterSearchTimeline *viewController = [storyBoard instantiateViewControllerWithIdentifier:NSStringFromClass(self.class)];
    
    viewController.query = query;
    
    return viewController;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"TweetCellTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
    [self reloadData];
}

- (void) reloadData{
    
    [[TwitterAPI sharedManager] searchTweetsWithQuery:self.query success:^(NSDictionary *searchMetadata, NSArray *statuses) {
        
        self.results = statuses;
        
        [self.tableView reloadData];
        
    } fail:^(NSError *error) {
        
    }];
}

#pragma TableView Delegate Methods

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 90.0;
    
}

#pragma TableView Data Source Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (self.results) {
        return [self.results count];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TweetCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    
   
    
    NSDictionary *tweet = (self.results)[indexPath.row];
    cell.nameLabel.text = tweet[@"user"][@"name"];
    NSString *profileUrl = tweet[@"user"][@"profile_image_url"];
    
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    [manager downloadImageWithURL: [[NSURL alloc] initWithString:profileUrl] options: 0 progress: nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        if (image) {
            [cell.profileImage setImage:image];
        }
    }];
    
    //Circular avatar
    cell.profileImage.layer.cornerRadius = cell.profileImage.frame.size.height /2;
    cell.profileImage.layer.masksToBounds = YES;
    cell.profileImage.layer.borderWidth = 0;
    
    cell.text.text = tweet[@"text"];
    
    return cell;
    
}

- (IBAction)close:(id)sender {
    
    [self dismissViewControllerAnimated:true completion:nil];
}

@end
