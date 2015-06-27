//
//  ProductListCell.h
//  jibaojie-mvvm
//
//  Created by Ron on 18/6/15.
//
//

#import <UIKit/UIKit.h>
#import "ProductListCellViewModel.h"

@interface ProductListCell : UITableViewCell

@property (nonatomic, strong) ProductListCellViewModel *viewModel;

@end
