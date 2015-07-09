//
//  TwitterLoginViewModel.h
//  twitter
//
//  Created by Anson on 15/7/9.
//
//

#import <Foundation/Foundation.h>
#import "TwitterHelper.h"

@interface TwitterLoginViewModel : NSObject

@property(nonatomic,strong)twitterHelper * helper;
@property(nonatomic,strong)RACCommand * loginCommand;


-(void)loginTwitter;

@end
