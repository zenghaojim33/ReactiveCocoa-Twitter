//
//  Issue.h
//  GithubIssue-MVVM
//
//  Created by Ron on 11/6/15.
//
//

#import "GGModel.h"

@interface Issue : GGModel

@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *avatar;
@property (nonatomic, strong) NSString *body;
@property (nonatomic, strong) NSString *url;

@end
