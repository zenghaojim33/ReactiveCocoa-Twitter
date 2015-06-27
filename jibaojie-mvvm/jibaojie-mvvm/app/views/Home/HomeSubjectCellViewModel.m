//
//  HomeSubjectCellViewModel.m
//  jibaojie-mvvm
//
//  Created by Ron on 17/6/15.
//
//

#import "HomeSubjectCellViewModel.h"

@interface HomeSubjectCellViewModel()

@property (nonatomic, strong) SubjectEntity *subject;

@end

@implementation HomeSubjectCellViewModel

- (instancetype)initWithSubjectObject:(SubjectEntity *)subject{
    self = [super init];
    if (self) {
        self.subject = subject;
    }
    return self;
}

- (NSString *)subjectName{
    return self.subject.name;
}

- (NSString *)imageUrl{
    return self.subject.originalImage;
}

@end
