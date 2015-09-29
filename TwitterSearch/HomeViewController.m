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


@interface HomeViewController ()

@property (weak, nonatomic) IBOutlet UITextField *searchTextField;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)searchButtonAction:(id)sender {
    
    TwitterSearchTimeline *viewController = [TwitterSearchTimeline loadFromNib:self.searchTextField.text];
    
    [self presentViewController:viewController animated:true completion:nil];
    
}

@end
