//
//  AGENDAViewController.h
//  CVP - iOS
//
//  Created by halverny on 3/4/14.
//  Copyright (c) 2014 Clinica Vicente de Paula. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

AppDelegate *appDel;

@interface AGENDAViewController : UITableViewController

@property(nonatomic, strong) NSMutableArray * horasList;
@property(nonatomic, strong) NSMutableArray * nomepacientesList;
@property(nonatomic, strong) NSMutableArray * codigoatendimentosList;
@property(nonatomic, strong) NSMutableArray * codigopacientesList;
@property(nonatomic, strong) NSMutableArray * celularpacientesList;
@property(nonatomic, strong) NSMutableArray * situacoesatendimentosList;@property (nonatomic, strong) NSMutableArray * json;
@property (strong, nonatomic) NSDictionary * atendimentosArray;

@property (strong, nonatomic) NSString * user_name;
@property (strong, nonatomic) NSString * password;
@property (strong, nonatomic) NSString * medico;
@property (strong, nonatomic) NSString * dia;



@end

