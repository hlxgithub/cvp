//
//  atendimento.h
//  CVP - iOS
//
//  Created by halverny on 12/29/13.
//  Copyright (c) 2013 Clinica Vicente de Paula. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface atendimento : NSObject

@property (nonatomic, strong) NSString *dataAtendimento;
@property (nonatomic, strong) NSString *horaAtendimento;
@property (nonatomic, strong) NSString *nomePaciente;
@property (nonatomic, strong) NSString *fonePaciente;
@property (nonatomic, strong) NSString *tipoAgendamento;
@property (nonatomic, strong) NSString *situacaoAtendimento;


// Methods

@end

