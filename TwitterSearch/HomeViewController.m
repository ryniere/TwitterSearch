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
    
    [[TwitterAPI sharedManager] getTrends:@"1" success:^(NSArray *trends) {
        
        self.trends = trends;
        
        [self.trendsTableView reloadData];
        
    } fail:^(NSError *error) {
        
    }];


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma TableView Delegate Methods

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == self.trendsTableView) {
        
        return 30;
    }
    return 20;
}

#pragma TableView Data Source Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (tableView == self.trendsTableView) {
        
        if (self.trends) {
            return [self.trends count];
        }
        return 0;
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"trendCell"];
    
    
     [cell.contentView setBackgroundColor:[UIColor colorWithHex:kBackgroundColor]];
    
    NSDictionary *tweet = (self.trends)[indexPath.row];
    cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:9];
    cell.textLabel.text = tweet[@"name"];
    
  
    
    
    return cell;
    
}

- (IBAction)searchButtonAction:(id)sender {
    
    TwitterSearchTimeline *viewController = [TwitterSearchTimeline loadFromNib:self.searchTextField.text];
    
    [self presentViewController:viewController animated:true completion:nil];
    
}

@end
