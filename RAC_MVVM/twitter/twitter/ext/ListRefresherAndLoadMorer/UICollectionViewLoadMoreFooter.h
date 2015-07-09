//
//  UICollectionViewLoadMoreFooter.h
//  twitter
//
//  Created by Anson on 15/7/9.
//
//

#import <UIKit/UIKit.h>

@interface UICollectionViewLoadMoreFooter : UICollectionReusableView

@property (nonatomic, assign) BOOL enable;

+ (void)setUpWithCollectionView:(UICollectionView*)collectionView withHeight:(CGFloat)height withAction:(void (^)(void))actionHandler;

- (void)startAnimation;

- (void)stopAnimation;

@end

@interface UICollectionView (UICollectionViewLoadMoreFooter)

- (void)cleanUp;

- (CGFloat)footerHeight;

- (BOOL)enable;

- (void)setEnable:(BOOL)enable;

- (BOOL)isLoading;

- (void)setLoading:(BOOL)loading;

@end
