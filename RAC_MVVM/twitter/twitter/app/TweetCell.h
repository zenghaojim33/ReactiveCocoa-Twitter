//
//  TweetCell.h
//  twitter
//
//  Created by Anson on 15/7/10.
//
//

#import <UIKit/UIKit.h>
#import "TweetCellViewModel.h"
#import "Tweet.h"
@interface TweetCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *avatar;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *content;
@property (weak, nonatomic) IBOutlet UIButton *favouriteButton;
@property(nonatomic,strong)TweetCellViewModel * viewModel;

-(void)bindViewModel:(TweetCellViewModel *)viewModel;


@end
