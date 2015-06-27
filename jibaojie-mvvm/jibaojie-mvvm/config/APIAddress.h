//
//  APIAddress.h
//  jibaojie-mvvm
//
//  Created by Ron on 16/6/15.
//
//

//#define STAGING @"我是正式api和测试api的开关宏定义，把我注释掉就是正式环境"

#ifndef STAGING
#define API_HOST @"http://jibaojie.cngump.com/api/v1"
#else
#define API_HOST @"http://jibaojie.dev.icanc.net/api/v1"
#endif

#define API_SUBJECT_LIST @"set"

#define API_COLLECTION_LIST @"collection"

#define API_LOGIN_LIST @"login"

