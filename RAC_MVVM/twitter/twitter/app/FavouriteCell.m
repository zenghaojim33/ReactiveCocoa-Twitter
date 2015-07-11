//
//  FavouriteCell.m
//  twitter
//
//  Created by Anson on 15/7/11.
//
//

#import "FavouriteCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
@implementation FavouriteCell

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


-(void)configureCellWithTweet:(Tweet *)tweet
{
    self.name.text = tweet.username;
    [self.avatar sd_setImageWithURL:[NSURL URLWithString:tweet.profileImageURL]];
    self.content.text = tweet.text;
    
}

@end
