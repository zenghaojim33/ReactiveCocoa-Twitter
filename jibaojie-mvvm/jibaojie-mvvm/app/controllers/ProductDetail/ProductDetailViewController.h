//
//  ProductDetailViewController.h
//  jibaojie-mvvm
//
//  Created by Ron on 17/6/15.
//
//

#import <UIKit/UIKit.h>
#import "ProductDetailViewModel.h"

@interface ProductDetailViewController : UIViewController

@property (nonatomic, strong) ProductDetailViewModel *viewModel;

@end
