//
//  TwitterSearchTimeline.m
//  TwitterSearch
//
//  Created by Ryniere S Silva on 23/09/15.
//  Copyright © 2015 Ryniere S Silva. All rights reserved.
//

#import "TwitterSearchTimeline.h"
#import "TwitterAPI.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <UIColor_HexRGB/UIColor+HexRGB.h>

@interface TwitterSearchTimeline ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *queryLabel;

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
    
    [self.view setBackgroundColor:[UIColor colorWithHex:@"5E9FCA"]];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.queryLabel.text = [NSString stringWithFormat:@"\"%@\"", self.query ];
    
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
    
    return 170;
    
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
    
    cell.leftUtilityButtons = [self leftButtons];
    cell.delegate = self;
    
    NSDictionary *tweet = (self.results)[indexPath.row];
    cell.nameLabel.text = tweet[@"user"][@"name"];
    [cell.nameLabel sizeToFit];
    NSString *profileUrl = tweet[@"user"][@"profile_image_url"];
    
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    [cell.profileImage setImage:nil];
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
    [cell.text sizeToFit];
    
    
    return cell;
}

- (NSArray *)leftButtons
{
    NSMutableArray *leftUtilityButtons = [NSMutableArray new];
    
    [leftUtilityButtons sw_addUtilityButtonWithColor:
     [UIColor colorWithRed:0.07 green:0.75f blue:0.16f alpha:1.0]
                                                icon:[UIImage imageNamed:@"check.png"]];
    [leftUtilityButtons sw_addUtilityButtonWithColor:
     [UIColor colorWithRed:1.0f green:1.0f blue:0.35f alpha:1.0]
                                                icon:[UIImage imageNamed:@"clock.png"]];
    [leftUtilityButtons sw_addUtilityButtonWithColor:
     [UIColor colorWithRed:1.0f green:0.231f blue:0.188f alpha:1.0]
                                                icon:[UIImage imageNamed:@"cross.png"]];
    [leftUtilityButtons sw_addUtilityButtonWithColor:
     [UIColor colorWithRed:0.55f green:0.27f blue:0.07f alpha:1.0]
                                                icon:[UIImage imageNamed:@"list.png"]];
    
    return leftUtilityButtons;
}

- (IBAction)close:(id)sender {
    
    [self dismissViewControllerAnimated:true completion:nil];
}

@end
