//
//  AppDatabase.h
//  twitter
//
//  Created by Anson on 15/7/9.
//
//

#import "MojoDatabase.h"
#import "MojoModel.h"

@interface AppDatabase : MojoDatabase {
}

-(id)initWithMigrations;
-(id)initWithMigrations:(BOOL)loggingEnabled;

@end
