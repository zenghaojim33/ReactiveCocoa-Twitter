//
//  UICollectionViewLoadMoreFooter.m
//  twitter
//
//  Created by Anson on 15/7/9.
//
//

#import "UICollectionViewLoadMoreFooter.h"
#import <objc/runtime.h>

@interface UICollectionViewLoadMoreObserver : NSObject

@property (nonatomic, weak) UICollectionView *collectionView;

@end


@implementation UICollectionView (UICollectionViewLoadMoreFooter)

- (UICollectionViewLoadMoreObserver*)loadMoreObserver{
    return objc_getAssociatedObject(self, @selector(loadMoreObserver));
}

- (void)setLoadMoreObserver:(UICollectionViewLoadMoreObserver*)loadMoreObserver{
    objc_setAssociatedObject(self, @selector(loadMoreObserver), loadMoreObserver, OBJC_ASSOCIATION_RETAIN);
}

- (voidBlock)loadmoreAction{
    return objc_getAssociatedObject(self, @selector(loadmoreAction));
}

- (void)setLoadmoreAction:(voidBlock)loadmoreAction{
    objc_setAssociatedObject(self, @selector(loadmoreAction), loadmoreAction, OBJC_ASSOCIATION_COPY);
}

- (BOOL)enable{
    return [objc_getAssociatedObject(self, @selector(enable)) boolValue];
}

- (void)setEnable:(BOOL)enable{
    objc_setAssociatedObject(self, @selector(enable), @(enable), OBJC_ASSOCIATION_RETAIN);
    
    if (!enable) {
        if (self.isObserving) {
            [self removeObserver:self.loadMoreObserver forKeyPath:@"contentOffset"];
            [self setObserving:NO];
        }
        
        [self setLoading:NO];
    }
    else {
        if (!self.isObserving) {
            [self addObserver:self.loadMoreObserver forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
            [self setObserving:YES];
        }
    }
    
}

- (BOOL)isLoading{
    return [objc_getAssociatedObject(self, @selector(isLoading)) boolValue];
}

- (void)setLoading:(BOOL)loading{
    objc_setAssociatedObject(self, @selector(isLoading), @(loading), OBJC_ASSOCIATION_RETAIN);
}

- (BOOL)isObserving{
    return [objc_getAssociatedObject(self, @selector(isObserving)) boolValue];
}

- (void)setObserving:(BOOL)observing{
    objc_setAssociatedObject(self, @selector(isObserving), @(observing), OBJC_ASSOCIATION_RETAIN);
}

- (CGFloat)footerHeight{
    return [objc_getAssociatedObject(self, @selector(footerHeight)) floatValue];
}

- (void)setFooterHeight:(CGFloat)footerHeight{
    objc_setAssociatedObject(self, @selector(footerHeight), @(footerHeight), OBJC_ASSOCIATION_RETAIN);
}

- (void)cleanUp{
    [self setEnable:NO];
}

@end

@interface UICollectionViewLoadMoreFooter()

@property (nonatomic, strong) UIActivityIndicatorView *loadMoreIndicatorView;

@end

@implementation UICollectionViewLoadMoreFooter

+ (void)setUpWithCollectionView:(UICollectionView*)collectionView withHeight:(CGFloat)height withAction:(void (^)(void))actionHandler{

    UINib *footNib = [UINib nibWithNibName:NSStringFromClass([UICollectionViewLoadMoreFooter class]) bundle:[NSBundle mainBundle]];
    
    [collectionView registerNib:footNib forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:NSStringFromClass([UICollectionViewLoadMoreFooter class])];

    UICollectionViewLoadMoreObserver *observer = [UICollectionViewLoadMoreObserver new];
    observer.collectionView = collectionView;
    [collectionView setLoadMoreObserver:observer];
    collectionView.footerHeight = height;
    collectionView.loadmoreAction = actionHandler;
    collectionView.enable = YES;
    
}

- (void)startAnimation{
    [self.loadMoreIndicatorView startAnimating];
}

- (void)stopAnimation{
    [self.loadMoreIndicatorView stopAnimating];
}

- (UIActivityIndicatorView*)loadMoreIndicatorView{
    if (!_loadMoreIndicatorView) {
        _loadMoreIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _loadMoreIndicatorView.hidesWhenStopped = YES;
        [self addSubview:_loadMoreIndicatorView];
        _loadMoreIndicatorView.translatesAutoresizingMaskIntoConstraints = NO;
        NSLayoutConstraint *centerxConstraint = [NSLayoutConstraint constraintWithItem:_loadMoreIndicatorView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0.0f];
        NSLayoutConstraint *centeryConstraint = [NSLayoutConstraint constraintWithItem:_loadMoreIndicatorView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0f constant:0.0f];
        [self addConstraints:@[centerxConstraint,centeryConstraint]];
    }
    return _loadMoreIndicatorView;
}

@end


@implementation UICollectionViewLoadMoreObserver

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if([keyPath isEqualToString:@"contentOffset"])
    {
        CGPoint newContentOffset = [[change valueForKey:NSKeyValueChangeNewKey] CGPointValue];
        if (newContentOffset.y == 0 || self.collectionView.contentSize.height < self.collectionView.frame.size.height) {
            return;
        }
        
        if (newContentOffset.y >= (MAX(self.collectionView.contentSize.height , self.collectionView.frame.size.height) - self.collectionView.frame.size.height)) {
            
            if (!self.collectionView.isLoading && self.collectionView.loadmoreAction) {
                [self startLoadMore];
            }
            
        }
    }
}

- (void)startLoadMore{
    if (!self.collectionView.isLoading) {
        if (self.collectionView.loadmoreAction) {
            self.collectionView.loadmoreAction();
        }
        self.collectionView.loading = YES;
        [self.collectionView reloadData];
    }
}


@end


