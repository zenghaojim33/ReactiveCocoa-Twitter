//
//  User.h
//  twitter
//
//  Created by Anson on 15/7/9.
//
//

#import <Foundation/Foundation.h>
#import "RestObject.h"

extern NSString *const UserDidLoginNotification;
extern NSString *const UserDidLogoutNotification;

@interface User : RestObject

    // public static class methods
    + (User *)currentUser;
    + (void)setCurrentUser:(User *)currentUser;

    // public instance methods
    @property (nonatomic, strong, readonly) NSString *username;
    @property (nonatomic, strong, readonly) NSString *userhandle;
    @property (nonatomic, strong, readonly) NSString *profileImageURL;

@end