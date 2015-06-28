//
//  ProductListViewModelSpec.m
//  jibaojie-mvvm
//
//  Created by Ron on 27/6/15.
//
//

#import "ProductListViewModel.h"
#import "ProductEntity.h"

SpecBegin(ProductListViewModel)

describe(@"IssueListCellViewModel", ^{
    
    __block ProductEntity *product;
    __block ProductListViewModel *listViewModel;
    
    beforeAll(^{
        
        product = OCMClassMock([ProductEntity class]);
        OCMStub([product pid]).andReturn(MOCK_PID);
        OCMStub([product categoryId]).andReturn(MOCK_CATEGORYID);
        OCMStub([product name]).andReturn(MOCK_NAME);
        OCMStub([product url]).andReturn(MOCK_URL);
        OCMStub([product originalImage]).andReturn(MOCK_ORIGINL_IMAGE);
        product.collect = MOCK_COLLECT;
        product.collected = @NO;

        listViewModel = [[ProductListViewModel alloc] initWithCacheKey:@"ProductListViewModel" subjectId:MOCK_CATEGORYID];
        
    });
    
    context(@"when fetch products", ^{
    
        
        it(@"should do fetch Product Object", ^{
            waitUntilTimeout(100, ^(DoneCallback done) {
                
                NSLog(@"\n hello %@",listViewModel);
                
                [listViewModel fetchProductsOnCompletion:^(NSError *error) {
                    NSLog(@"\n error: %@",error);
                    expect(listViewModel.products.count).beGreaterThan(0);
                    expect(listViewModel.products.firstObject).beKindOf([ProductEntity class]);
                    expect(error).beNil();
                    done();
                }];
                
            });
        });
        
        
        
        it(@"should fetch next Page Prodcut", ^{
            waitUntilTimeout(100, ^(DoneCallback done) {
                
                __block ProductListViewModel *_listViewModel = [[ProductListViewModel alloc] initWithCacheKey:@"ProductListViewModel" subjectId:MOCK_CATEGORYID];
                
                [_listViewModel fetchProductsOnCompletion:^(NSError *error) {
                    
                     expect(_listViewModel.products.count).equal(RequestPerPageCount.integerValue);
                    
                    [_listViewModel fetchNextPageProductsOnCompletion:^(NSError *error) {
                        expect(_listViewModel.currentPage).equal(2);
                        expect(_listViewModel.products.count).beGreaterThan(RequestPerPageCount.integerValue);
                        expect(_listViewModel.products.firstObject).beKindOf([ProductEntity class]);
                        expect(error).beNil();
                        done();
                    }];
                    
                }];

            });
        });

        
    });

    
});

SpecEnd