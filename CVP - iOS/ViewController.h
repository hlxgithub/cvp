//
//  ViewController.h
//  CVP - iOS
//
//  Created by halverny on 12/29/13.
//  Copyright (c) 2013 Clinica Vicente de Paula. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

AppDelegate *appDel;

@interface ViewController : UIViewController {
    
    IBOutlet UITextField *userNameField;
    IBOutlet UITextField *passwordField;

}


@property (nonatomic, strong) NSMutableArray * json;
@property (nonatomic, strong) NSMutableArray * usuariosArray;

-(IBAction)enterCredentials;
-(IBAction)LimpaComponentesLogin;

@end
