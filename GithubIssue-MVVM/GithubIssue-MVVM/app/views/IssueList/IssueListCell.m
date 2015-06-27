//
//  IssueListCell.m
//  GithubIssue-MVVM
//
//  Created by Ron on 11/6/15.
//
//

#import "IssueListCell.h"

@interface IssueListCell()

@property (nonatomic, weak) IBOutlet UIImageView *articleImageView;
@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UILabel *contentLabel;

@end

@implementation IssueListCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setViewModel:(IssueListCellViewModel *)viewModel{
    _viewModel = viewModel;
    [self setNeedsLayout];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self.articleImageView sd_setImageWithURL:[NSURL URLWithString:self.viewModel.avatar] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (error) {
            DLog(@"\n%@",error);
        }
    }];
    self.titleLabel.text = self.viewModel.username;
    self.contentLabel.text = self.viewModel.body;
}

@end
