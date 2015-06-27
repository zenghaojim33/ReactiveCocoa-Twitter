//
//  HomeViewModel.h
//  jibaojie-mvvm
//
//  Created by Ron on 17/6/15.
//
//

#import <Foundation/Foundation.h>

@interface HomeViewModel : NSObject

@property (nonatomic, readonly) NSArray *subjects;

- (void)fetchSubjectsOnCompletion:(errorBlock)block;

@end
