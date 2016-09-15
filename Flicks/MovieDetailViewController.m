//
//  MovieDetailViewController.m
//  Flicks
//
//  Created by Rama Pillutla on 9/13/16.
//  Copyright © 2016 codepath. All rights reserved.
//

#import "MovieDetailViewController.h"

@interface MovieDetailViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *movieDetailImage;

@end

@implementation MovieDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSLog(self.movie[@"title"]);
    
    NSString *imageURLString = [NSString stringWithFormat: @"https://image.tmdb.org/t/p/w342%@", self.movie[@"poster_path"]];
    
    NSLog(@"imagedetailurl: %@", imageURLString);
    
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
