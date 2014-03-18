//
//  AppDelegate.h
//  CVP - iOS
//
//  Created by halverny on 12/29/13.
//  Copyright (c) 2013 Clinica Vicente de Paula. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    NSMutableString *gdentista;
    NSMutableString *gdata;
    NSMutableString *gdentistavinculado;
    NSString *guser;
    NSString *gpass;
    NSMutableString *gabreviacaodentista;
}

@property (strong, nonatomic) UIWindow *window;

@property (  nonatomic, retain) NSMutableString *gdentista;
@property (  nonatomic, retain) NSMutableString *gdata;

@property (  nonatomic, retain) NSMutableString *gdentistavinculado;
@property (  nonatomic, retain) NSString *guser;
@property (  nonatomic, retain) NSString *gpass;
@property (  nonatomic, retain) NSMutableString *gabreviacaodentista;
@end
