//
//  DETALHEATENDIMENTOViewController.h
//  CVP - iOS
//
//  Created by halverny on 3/4/14.
//  Copyright (c) 2014 Clinica Vicente de Paula. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DETALHEATENDIMENTOViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate> {
    
    UIImagePickerController *picker;
    UIImagePickerController *picker2;
    UIImage *image;
    
    NSMutableString *fotoAlterada;
}

- (IBAction)TakePhoto;
- (IBAction)ChooseExisting;
- (IBAction)LimparHorario;
- (IBAction)SalvarAgenda;

@property (weak, nonatomic) IBOutlet UILabel *txtSeNovoPac;

@property (weak, nonatomic) IBOutlet UILabel *txtHorario;

@property (weak, nonatomic) IBOutlet UITextField *txtCelular;

@property (weak, nonatomic) IBOutlet UITextField *txtNome;

@property (strong, nonatomic) NSString * horario;

@property (strong, nonatomic) NSString * nome_paciente;

@property (strong, nonatomic) NSString * codigo_paciente;

@property (strong, nonatomic) NSString * codigo_atendimento;

@property (strong, nonatomic) NSString * celular_paciente;

@property (strong, nonatomic) NSString * situacao_atendimento;

@property (strong, nonatomic) NSString * user_name;

@property (strong, nonatomic) NSString * password;

@property (strong, nonatomic) NSString * dia;

@property (strong, nonatomic) NSString * abreviacao_dentista;

@property (weak, nonatomic) IBOutlet UIImageView *imgPaciente;

@end
