//
//  FavoriteSubjectCell.m
//  jibaojie-mvvm
//
//  Created by Ron on 17/6/15.
//
//

#import "FavoriteSubjectCell.h"

@interface FavoriteSubjectCell()

@property (weak, nonatomic) IBOutlet UIImageView *favImageView;
@property (weak, nonatomic) IBOutlet UILabel *favNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *favPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *favCountLabel;


@end

@implementation FavoriteSubjectCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)setViewModel:(FavoriteSubjectCellViewModel *)viewModel{
    _viewModel = viewModel;
    [self setNeedsLayout];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self.favImageView sd_setImageWithURL:[NSURL URLWithString:self.viewModel.productImageUrl]];
    self.favNameLabel.text = self.viewModel.productName;
    self.favPriceLabel.text = self.viewModel.previewPrice;
    [self.favCountLabel setText:self.viewModel.favTotalCount.stringValue];
}


@end
