//
//  MovieCellTableViewCell.h
//  Flicks
//
//  Created by Rama Pillutla on 9/13/16.
//  Copyright © 2016 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieCellTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *synopsisLabel;
@property (weak, nonatomic) IBOutlet UIImageView *movieImage;

@end
