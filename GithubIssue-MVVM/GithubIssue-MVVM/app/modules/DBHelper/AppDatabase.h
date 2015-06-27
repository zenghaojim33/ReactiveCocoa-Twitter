//
//  AppDatabase.h
//  GithubIssue-MVVM
//
//  Created by Ron on 11/6/15.
//
//

#import "MojoDatabase.h"
#import "MojoModel.h"

@interface AppDatabase : MojoDatabase {
}

-(id)initWithMigrations;
-(id)initWithMigrations:(BOOL)loggingEnabled;

@end
