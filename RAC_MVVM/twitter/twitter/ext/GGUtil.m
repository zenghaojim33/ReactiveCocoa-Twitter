//
//  GGUtil.m
//  VisibleTools
//
//  Created by gump on 11-5-13.
//  Copyright 2011年 f4 . All rights reserved.
//

#import "GGUtil.h"
#import <objc/runtime.h>
@import MessageUI;
@import SystemConfiguration;
@import Darwin;

static NSDateFormatter *g_dayDateFormatter;

@implementation GGUtil

+ (void)load
{
    g_dayDateFormatter = [[NSDateFormatter alloc] init];
}

+ (BOOL)addSkipBackupAttributeToItemAtURL:(NSURL *)URL
{
    assert([[NSFileManager defaultManager] fileExistsAtPath: [URL path]]);
    NSError *error = nil;
    BOOL success = [URL setResourceValue:@YES
                                  forKey:NSURLIsExcludedFromBackupKey error: &error];
    if(!success){
        DLog(@"Error excluding %@ from backup %@", [URL lastPathComponent], error);
    }
    return success;
}

#pragma mark -
#pragma mark Image
+ (UIImage *)makeAShotWithView:(UIView*)aView
{
    const CGFloat *designValues = CGColorGetComponents(aView.backgroundColor.CGColor);
    UIGraphicsBeginImageContextWithOptions(aView.bounds.size, designValues[3] == 1, [UIScreen mainScreen].scale);
    if ([aView respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)]) {
        [aView drawViewHierarchyInRect:aView.bounds afterScreenUpdates:YES];
    } else {
        [aView.layer renderInContext:UIGraphicsGetCurrentContext()];
    }
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


+(CGSize)getScaleRect:(CGSize)originSize targetSize:(CGSize)maxSize{
    CGFloat width=originSize.width;
    CGFloat height=originSize.height;
    
    CGFloat wSize=width/maxSize.width;
    CGFloat hSize=height/maxSize.height;
    
    CGFloat currSize= wSize > hSize ? wSize : hSize;
    
    CGFloat finelWidth=width/currSize;
    CGFloat finelHeight=height/currSize;
    
    return CGSizeMake(finelWidth, finelHeight);
}

#pragma mark -
#pragma mark Color
+ (UIColor *)randomColor
{
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  // 0.5 to 1.0,away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //0.5 to 1.0,away from black
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}


#pragma mark -
#pragma mark System Check
+ (BOOL)canSendSMS{
    BOOL canSMS=NO;
    Class messageClass = (NSClassFromString(@"MFMessageComposeViewController"));    
    if (messageClass != nil) {
        if ([messageClass canSendText]) {
            canSMS=YES;
        } else {
            [GGUtil showAlert:NSLocalizedString(@"Device can not use SMS.",@"") 
                      title:NSLocalizedString(@"Warning",@"")];
        }
    }
    return canSMS;

}

+ (BOOL)checkNetworkConnection
{
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    SCNetworkReachabilityFlags flags;
    
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
    
    if (!didRetrieveFlags) {
        return NO;
    }
    
    BOOL isReachable = flags & kSCNetworkFlagsReachable;
    BOOL needsConnection = flags & kSCNetworkFlagsConnectionRequired;
    return (isReachable && !needsConnection) ? YES : NO;
}


#pragma mark -
#pragma mark Alert
+ (void) showAlert: (NSString *) theMessage title:(NSString *) theTitle{
    UIAlertView *av = [[UIAlertView alloc] initWithTitle:STRING_OR_EMPTY(theTitle) message:STRING_OR_EMPTY(theMessage) delegate:nil cancelButtonTitle:NSLocalizedString(@"okay", @"") otherButtonTitles: nil];
        [av show];
}

#pragma mark -
#pragma mark String
+ (BOOL)stringIsEmpty:(NSString *) aString {
    
    if ((NSNull *) aString == [NSNull null]) {
        return YES;
    }
    
    if (aString == nil) {
        return YES;
    } else if ([aString length] == 0) {
        return YES;
    } else {
        aString = [aString stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
        if ([aString length] == 0) {
            return YES;
        }
    }
    
    return NO; 
}

+ (BOOL)stringIsEmpty:(NSString *) aString shouldCleanWhiteSpace:(BOOL)cleanWhileSpace {
    
    if ((NSNull *) aString == [NSNull null]) {
        return YES;
    }
    
    if (aString == nil) {
        return YES;
    } else if ([aString length] == 0) {
        return YES;
    } 
    
    if (cleanWhileSpace) {
        aString = [aString stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
        if ([aString length] == 0) {
            return YES;
        }
    }
    
    return NO; 
}



#pragma mark -
#pragma mark Text

+ (NSString *)limitString:(NSString *)string withLength:(unsigned short)length{
    NSString* returnString=string;
    if([string length]>length) {
        returnString=[NSString stringWithFormat:@"%@...",[string substringToIndex:length-3]];
    }
    return returnString;
}



+(BOOL)isValidateEmail:(NSString *)email {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

+(BOOL)isValidateMobile:(NSString *)mobile
{
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}

+ (BOOL)isValidZipcode:(NSString*)value
{
    const char *cvalue = [value UTF8String];
    NSInteger len = strlen(cvalue);
    if (len != 6) {
        return NO;
    }
    for (int i = 0; i < len; i++)
    {
        if (!(cvalue[i] >= '0' && cvalue[i] <= '9'))
        {
            return NO;
        }
    }
    return YES;
}


#pragma mark -
#pragma mark Memory
+ (void)simulateMemoryWarning
{
#if TARGET_IPHONE_SIMULATOR
#ifdef DEBUG
    CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), 
                                         (CFStringRef)@"UISimulatedMemoryWarningNotification", NULL, NULL, true);
#endif
#endif
}





@end
