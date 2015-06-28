//
//  ProductEntitySpec.m
//  jibaojie-mvvm
//
//  Created by Ron on 27/6/15.
//
//

#import "ProductEntity.h"

SpecBegin(ProductEntity)

describe(@"ProductEntity", ^{
    
    __block ProductEntity *product;
    __block JBJAccount *account;
    
    beforeAll(^{
        
        product = OCMClassMock([ProductEntity class]);
        OCMStub([product pid]).andReturn(MOCK_PID);
        OCMStub([product categoryId]).andReturn(MOCK_CATEGORYID);
        OCMStub([product name]).andReturn(MOCK_NAME);
        OCMStub([product url]).andReturn(MOCK_URL);
        OCMStub([product originalImage]).andReturn(MOCK_ORIGINL_IMAGE);
        
        account = OCMClassMock([JBJAccount class]);
        OCMStub([account token]).andReturn(@"2.00eEODoCbwjy8D7853bd6ce9mJ6USE");
        OCMStub([JBJAccount currentAccount]).andReturn(account);
        
    });
    
    context(@"when product is unfavorite", ^{
       
        before(^{
            product.collect = MOCK_COLLECT;
            product.collected = @NO;
        });
        
        it(@"should be favorite success", ^{
            [product requestFavoriteToggle:^{
                expect(product.collect.integerValue).equal(MOCK_COLLECT.integerValue + 1);
                expect(product.collected.boolValue).equal(YES);
            }];
        });
        
    });
    
    context(@"when product is favorited", ^{
        
        before(^{
            product.collect = MOCK_COLLECT;
            product.collected = @YES;
        });
        
        it(@"should be unfavorite success", ^{
            [product requestFavoriteToggle:^{
                expect(product.collect.integerValue).equal(MOCK_COLLECT.integerValue - 1);
                expect(product.collected.boolValue).equal(NO);
            }];
        });
        
    });
    
});

SpecEnd

