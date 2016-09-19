//
//  MovieDetailViewController.m
//  Flicks
//
//  Created by Rama Pillutla on 9/13/16.
//  Copyright © 2016 codepath. All rights reserved.
//

#import "MovieDetailViewController.h"
#import "UIImageView+AFNetworking.h"

@interface MovieDetailViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageDetailView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailsLabel;
@property (weak, nonatomic) IBOutlet UIScrollView *movieDetailsScrollView;
@property (weak, nonatomic) IBOutlet UILabel *overviewLabel;
@property (weak, nonatomic) IBOutlet UIView *infoView;


@end

@implementation MovieDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(self.movie[@"title"]);
    
    NSString *imageURLString = [NSString stringWithFormat: @"https://image.tmdb.org/t/p/original%@", self.movie[@"poster_path"]];
    
    NSLog(@"imagedetailurl: %@", imageURLString);
    
    [self.imageDetailView setImageWithURL:[NSURL URLWithString:(imageURLString)]];
    
    self.overviewLabel.text = self.movie[@"overview"];
    self.overviewLabel.lineBreakMode = UILineBreakModeWordWrap;
    self.overviewLabel.numberOfLines = 0;
    [self.overviewLabel sizeToFit];
    
    self.titleLabel.text = self.movie[@"original_title"];
    self.detailsLabel.text = self.movie[@"release_date"];
    
    
    CGRect frame = self.infoView.frame;
    frame.size.height = self.titleLabel.frame.size.height + self.detailsLabel.frame.size.height +self.overviewLabel.frame.size.height + self.overviewLabel.frame.origin.y + 10;
    self.infoView.frame = frame;
    
    self.movieDetailsScrollView.contentSize = CGSizeMake(self.movieDetailsScrollView.frame.size.width, 130 + self.infoView.frame.origin.y + self.infoView.frame.size.height);
    

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
