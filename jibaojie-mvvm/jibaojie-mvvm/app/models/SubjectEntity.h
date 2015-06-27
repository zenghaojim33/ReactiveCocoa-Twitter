//
//  SubjectEntity.h
//  jibaojie-mvvm
//
//  Created by Ron on 17/6/15.
//
//

#import "GGModel.h"

@interface SubjectEntity : GGModel

@property (nonatomic, strong) NSNumber *sid;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *alias;
@property (nonatomic, strong) NSString *subjectDesription;
@property (nonatomic, strong) NSString *originalImage;
@property (nonatomic, strong) NSString *middleImage;
@property (nonatomic, strong) NSString *smallImage;
@property (nonatomic, strong) NSString *createDate;

@end
