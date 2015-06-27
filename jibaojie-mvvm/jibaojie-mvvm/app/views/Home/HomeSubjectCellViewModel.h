//
//  HomeSubjectCellViewModel.h
//  jibaojie-mvvm
//
//  Created by Ron on 17/6/15.
//
//

#import <Foundation/Foundation.h>
#import "SubjectEntity.h"

@interface HomeSubjectCellViewModel : NSObject

@property (nonatomic, readonly) NSString *subjectName;
@property (nonatomic, readonly) NSString *imageUrl;

- (instancetype)initWithSubjectObject:(SubjectEntity *)subject;

@end
