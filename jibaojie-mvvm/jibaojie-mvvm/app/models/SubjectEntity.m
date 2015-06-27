//
//  SubjectEntity.m
//  jibaojie-mvvm
//
//  Created by Ron on 17/6/15.
//
//

#import "SubjectEntity.h"

@implementation SubjectEntity

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
   return @{
      
            @"sid" : @"id",
            @"name" :  @"name",
            @"alias" :  @"alias",
            @"subjectDesription" :  @"description",
            @"originalImage" :  @"original_image",
            @"middleImage" : @"middle_image",
            @"smallImage" : @"small_image",
            @"createDate" :  @"created_at"
            
      };
}

@end
