//
//  HomeViewModel.m
//  jibaojie-mvvm
//
//  Created by Ron on 17/6/15.
//
//

#import "HomeViewModel.h"
#import "SubjectEntity.h"

@interface HomeViewModel()

@property (nonatomic, readwrite) NSArray *subjects;

@end

@implementation HomeViewModel

#pragma mark -
#pragma mark -------------------- Properties ---------------------
- (NSArray *)subjects{
    if (!_subjects) {
        _subjects = [SubjectEntity cachesListByKey:NSStringFromClass([HomeViewModel class])];
    }
    return _subjects;
}

- (void)fetchSubjectsOnCompletion:(errorBlock)block{
    __weak __typeof(&*self)weakSelf = self;
    [[APIClient sharedClient] GET:API_SUBJECT_LIST parameters:nil
     success:^(AFHTTPRequestOperation *operation, id responseObject) {
         
         NSMutableArray *tempArray = [NSMutableArray array];
         NSArray *subjectOriginDatas = responseObject[@"set"];
         
         if (subjectOriginDatas.count > 0) {
             for (NSDictionary *dic in subjectOriginDatas) {
                 [tempArray addObject:[SubjectEntity createFrom:dic]];
             }
             [SubjectEntity save2CachesByList:tempArray andKey:NSStringFromClass([HomeViewModel class])];
         }
         
         weakSelf.subjects = tempArray;
         
         if (block) {
             block(nil);
         }
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         if (block) {
             block(error);
         }
     }];
}

@end
