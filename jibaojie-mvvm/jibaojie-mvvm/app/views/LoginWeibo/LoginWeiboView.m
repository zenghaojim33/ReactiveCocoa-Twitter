//
//  LoginWeiboView.m
//  jibaojie-mvvm
//
//  Created by Ron on 21/6/15.
//
//

#import "LoginWeiboView.h"

@interface LoginWeiboView()



@end

@implementation LoginWeiboView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (IBAction)onClickLogin:(id)sender {
    if (self.loginBlock) {
        self.loginBlock();  
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
