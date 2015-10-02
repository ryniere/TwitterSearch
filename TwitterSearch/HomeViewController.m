//
//  ViewController.m
//  TwitterSearch
//
//  Created by Ryniere S Silva on 22/09/15.
//  Copyright © 2015 Ryniere S Silva. All rights reserved.
//

#import "HomeViewController.h"
#import <TwitterKit/TwitterKit.h>
#import "TwitterSearchTimeline.h"
#import "TwitterAPI.h"
#import <UIColor_HexRGB/UIColor+HexRGB.h>
#import "TwitterQueryManager.h"


@interface HomeViewController ()

@property (weak, nonatomic) IBOutlet UITextField *searchTextField;
@property (nonatomic,strong) NSArray *trends;
@property (strong, nonatomic) IBOutlet UITableView *lastSearchsTableView;
@property (strong, nonatomic) IBOutlet UITableView *trendsTableView;

@end

@implementation HomeViewController

static NSString *const kBackgroundColor = @"#F5F5F5";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.view setBackgroundColor:[UIColor colorWithHex:kBackgroundColor]];
    [self.lastSearchsTableView setBackgroundColor:[UIColor colorWithHex:kBackgroundColor]];
    [self.trendsTableView setBackgroundColor:[UIColor colorWithHex:kBackgroundColor]];
    
    [self.trendsTableView registerClass:UITableViewCell.self forCellReuseIdentifier:@"trendCell"];
    self.trendsTableView.delegate = self;
    self.trendsTableView.dataSource = self;
    
    [self.lastSearchsTableView registerClass:UITableViewCell.self forCellReuseIdentifier:@"trendCell"];
    self.lastSearchsTableView.delegate = self;
    self.lastSearchsTableView.dataSource = self;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self reloadLastSearchData];
    [self reloadTrendsData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)reloadTrendsData{
    
    [[TwitterAPI sharedManager] getTrends:@"1" success:^(NSArray *trends) {
        
        self.trends = trends;
        
        [self.trendsTableView reloadData];
        
    } fail:^(NSError *error) {
        
    }];
}

- (void)reloadLastSearchData{
    
    [self.lastSearchsTableView reloadData];
}

#pragma TableView Delegate Methods

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 30;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == self.trendsTableView) {
        
        NSDictionary *trend = (self.trends)[indexPath.row];
        [self openTwitterSearchTimelineWithQuery:trend[@"name"]];
    }
    else if (tableView == self.lastSearchsTableView){
        
        TwitterQuery *query = [[TwitterQueryManager sharedManager] getLastTwitterQueryAtIndex:[indexPath row]];
        [self openTwitterSearchTimelineWithQuery:query.query];
    }
    
    
}

#pragma TableView Data Source Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (tableView == self.trendsTableView) {
        
        if (self.trends) {
            return [self.trends count];
        }
        return 0;
    }
    else if (tableView == self.lastSearchsTableView){
        
        return [[[TwitterQueryManager sharedManager] getLastTwitterQueries] count];
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"trendCell"];
    
    
    [cell.contentView setBackgroundColor:[UIColor colorWithHex:kBackgroundColor]];
    cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:9];
    
    if (tableView == self.trendsTableView) {
        
        NSDictionary *trend = (self.trends)[indexPath.row];
        cell.textLabel.text = trend[@"name"];
    }
    else if (tableView == self.lastSearchsTableView){
        
        TwitterQuery *query = [[TwitterQueryManager sharedManager] getLastTwitterQueryAtIndex:[indexPath row]];
        
        cell.textLabel.text = query.query;
    }
  
    
    return cell;
    
}

- (IBAction)searchButtonAction:(id)sender {
    
    if (![@"" isEqualToString:self.searchTextField.text]) {
        TwitterQuery *query = [[TwitterQuery alloc] init];
        query.query = self.searchTextField.text;
        
        [[TwitterQueryManager sharedManager] addTwitterQuery:query];
        
        [self openTwitterSearchTimelineWithQuery:query.query];
    }  
}

- (void)openTwitterSearchTimelineWithQuery:(NSString *)query{
    
    TwitterSearchTimeline *viewController = [TwitterSearchTimeline loadFromNib:query];
    
    [self presentViewController:viewController animated:true completion:nil];
    
}

@end
