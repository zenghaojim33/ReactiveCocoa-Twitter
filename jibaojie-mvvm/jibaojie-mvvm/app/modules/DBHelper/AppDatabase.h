//
//  AppDatabase.h
//  jibaojie-mvvm
//
//  Created by Ron on 16/6/15.
//
//

#import "MojoDatabase.h"
#import "MojoModel.h"

@interface AppDatabase : MojoDatabase {
}

-(id)initWithMigrations;
-(id)initWithMigrations:(BOOL)loggingEnabled;

@end
