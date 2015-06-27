//
//  ProductListCell.m
//  jibaojie-mvvm
//
//  Created by Ron on 18/6/15.
//
//

#import "ProductListCell.h"

@interface ProductListCell()

@property (weak, nonatomic) IBOutlet UIImageView *productImageView;
@property (weak, nonatomic) IBOutlet UILabel *productNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *productPriceLabel;
@property (weak, nonatomic) IBOutlet UIButton *productFavButton;


@end

@implementation ProductListCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setViewModel:(ProductListCellViewModel *)viewModel{
    _viewModel = viewModel;
    [self setNeedsLayout];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self.productImageView sd_setImageWithURL:[NSURL URLWithString:self.viewModel.productImageUrl]];
    self.productNameLabel.text = self.viewModel.productName;
    self.productPriceLabel.text = self.viewModel.previewPrice;
    [self.productFavButton setTitle:self.viewModel.favTotalCount.stringValue forState:UIControlStateNormal];
}

@end
