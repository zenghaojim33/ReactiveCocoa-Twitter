//
//  TwitterLoginViewModel.h
//  twitter
//
//  Created by Anson on 15/7/9.
//
//

#import <Foundation/Foundation.h>
#import "TwitterClient.h"

@interface TwitterLoginViewModel : NSObject

@property(nonatomic,strong)TwitterClient * client;


-(RACSignal *)loginSignal;

@end
