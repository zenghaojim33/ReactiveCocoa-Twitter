//
//  TweetCell.m
//  twitter
//
//  Created by Anson on 15/7/10.
//
//

#import "TweetCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
@implementation TweetCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}



- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)bindViewModel:(TweetCellViewModel *)viewModel{

    self.viewModel = viewModel;
    self.name.text = self.viewModel.tweet.username;
    [self.avatar sd_setImageWithURL:[NSURL URLWithString:self.viewModel.tweet.profileImageURL]];
    self.content.text = self.viewModel.tweet.text;
    
    self.favouriteButton.rac_command = viewModel.favouriteCommand;

    
    [self.favouriteButton.rac_command.executionSignals subscribeNext:^(RACSignal * signal) {
        

        [signal subscribeNext:^(id x) {
            NSLog(@"已成功收藏");
        }];
    }];
    
    
    
    
}


#pragma mark ------Setter--------





@end
