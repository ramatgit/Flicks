//
//  ViewController.m
//  Flicks
//
//  Created by Rama Pillutla on 9/13/16.
//  Copyright © 2016 codepath. All rights reserved.
//

#import "ViewController.h"
#import "MovieCellTableViewCell.h"
#import "MovieDetailViewController.h"
#import "UIImageView+AFNetworking.h"
#import "MBProgressHUD.h"


@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *movies;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
//@property (weak, nonatomic) IBOutlet UIView *networkErrorView;


@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    //self.tableView.rowHeight = UITableViewAutomaticDimension;
    //self.tableView.estimatedRowHeight = 100;
    
    self.tableView.separatorInset = UIEdgeInsetsZero;
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self
                action:@selector(refreshControlAction:)
      forControlEvents:UIControlEventValueChanged];

    [self.tableView insertSubview:(refreshControl) atIndex:(0)];
    
    NSLog(@"endpoint: %@", self.endPoint);
    [self loadMovieDataFromNetwork];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.movies.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MovieCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"MovieCellTableViewCell"];
    
    NSLog(@"row: %ld", (long)indexPath.row);
    
    NSDictionary *movie = self.movies[indexPath.row];
    
    cell.titleLabel.text = movie[@"title"];
    cell.synopsisLabel.text = movie[@"overview"];
    
    cell.synopsisLabel.lineBreakMode = UILineBreakModeWordWrap;
    cell.synopsisLabel.numberOfLines = 0;
    [cell.synopsisLabel sizeToFit];


    
    NSString *imageURLString = [NSString stringWithFormat: @"https://image.tmdb.org/t/p/w92%@", movie[@"poster_path"]];
    NSLog(@"imageurl: %@", imageURLString);
    
    [cell.movieImage setImageWithURL:[NSURL URLWithString:(imageURLString)]];
    
    
    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    UITableViewCell *cell = sender;
    
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    
    MovieDetailViewController *vc = segue.destinationViewController;
    
    vc.movie = self.movies[indexPath.row];
    
}

-(void)refreshControlAction:(UIRefreshControl *)refreshControl {

    [self loadMovieDataFromNetwork];
        [refreshControl endRefreshing];
}

-(void)loadMovieDataFromNetwork {
    NSString *apiKey = @"a07e22bc18f5cb106bfe4cc1f83ad8ed";
    NSString *baseString = @"https://api.themoviedb.org/3/movie/";
    NSString *urlString =
    [baseString stringByAppendingFormat:@"%@?api_key=%@", self.endPoint, apiKey];
    
    NSLog(@"URL String: %@", urlString);
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    
    NSURLSession *session =
    [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]
                                  delegate:nil
                             delegateQueue:[NSOperationQueue mainQueue]];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:^(NSData * _Nullable data,
                                                                NSURLResponse * _Nullable response,
                                                                NSError * _Nullable error) {
                                                [MBProgressHUD hideHUDForView:self.view animated:YES];
                                                if (!error) {
                                                    NSError *jsonError = nil;
                                                    NSDictionary *responseDictionary =
                                                    [NSJSONSerialization JSONObjectWithData:data
                                                                                    options:kNilOptions
                                                                                      error:&jsonError];
                                                    NSLog(@"Response: %@", responseDictionary);
                                                    self.movies = responseDictionary[@"results"];
                                                    [self.tableView reloadData];
                                                } else {
                                                    NSLog(@"An error occurred: %@", error.description);

                                                }
                                            }];
    [task resume];


}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    
    NSString *titleString = @"Error Loading Page";
    NSString *messageString = [error localizedDescription];
    NSString *moreString = [error localizedFailureReason] ?
    [error localizedFailureReason] :
    NSLocalizedString(@"Try typing the URL again.", nil);
    messageString = [NSString stringWithFormat:@"%@. %@", messageString, moreString];
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:titleString
                                                        message:messageString delegate:self
                                              cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
    [alertView show];
}

@end
