//
//  HomeSubjectCell.m
//  jibaojie-mvvm
//
//  Created by Ron on 17/6/15.
//
//

#import "HomeSubjectCell.h"

@interface HomeSubjectCell()

@property (nonatomic, weak) IBOutlet UIImageView *subjectImageView;
@property (nonatomic, weak) IBOutlet UILabel *subjectTitleLabel;

@end

@implementation HomeSubjectCell

- (void)awakeFromNib
{

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setViewModel:(HomeSubjectCellViewModel *)viewModel{
    _viewModel = viewModel;
    [self setNeedsLayout];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self.subjectImageView sd_setImageWithURL:[NSURL URLWithString:self.viewModel.imageUrl] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (error) {
            DLog(@"\n%@",error);
        }
    }];
    self.subjectTitleLabel.text = self.viewModel.subjectName;
}


@end
