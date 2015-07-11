//
//  FavouriteCell.h
//  twitter
//
//  Created by Anson on 15/7/11.
//
//

#import <UIKit/UIKit.h>
#import "Tweet.h"
@interface FavouriteCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *avatar;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *content;

-(void)configureCellWithTweet:(Tweet *)tweet;


@end
