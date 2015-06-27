//
//  APIAddress.h
//  GithubIssue-MVVM
//
//  Created by Ron on 11/6/15.
//
//

//#define STAGING @"我是正式api和测试api的开关宏定义，把我注释掉就是正式环境"

#ifndef STAGING
#define API_HOST @"https://api.github.com/"
#else
#define API_HOST @""
#endif


#define ISSUE_URL @"repos/vmg/redcarpet/issues"