//
//  ViewController.m
//  CVP - iOS
//
//  Created by halverny on 12/29/13.
//  Copyright (c) 2013 Clinica Vicente de Paula. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

@end

@implementation ViewController
@synthesize json, usuariosArray;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    appDel = [[UIApplication sharedApplication]delegate];
}

-(IBAction)LimpaComponentesLogin
{
    userNameField.text = @"";
    passwordField.text = @"";
 //   [self performSegueWithIdentifier:@"SelecionaData" sender:self];
}

-(IBAction)enterCredentials
{
    
    NSMutableString *urlString = [NSMutableString stringWithFormat:@"http://www.halvernyx.com.br/php/logincvp.php"];
    
     [urlString appendString:[NSString stringWithFormat:@"?%@=%@", @"user_name", userNameField.text]];
     [urlString appendString:[NSString stringWithFormat:@"&%@=%@", @"password", passwordField.text]];
    [urlString appendString:[NSString stringWithFormat:@"&%@=%@",
         @"key", @"cronos"]];
    [urlString setString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSData *jsonData = [NSData dataWithContentsOfURL:url];
    
    id jsonObjects = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    NSArray *keys = [jsonObjects allKeys];
    
    NSMutableString *CODIGO = [NSMutableString stringWithFormat:@"0"];
    NSMutableString *LOGIN = [NSMutableString stringWithFormat:@""];
    NSMutableString *ABREVIACAO = [NSMutableString stringWithFormat:@""];
    NSMutableString *DENTISTA_VINCULADO = [NSMutableString stringWithFormat:@""];
    
    // values in foreach loop
    for (NSString *key in keys) {
        NSLog(@"%@ is %@",key, [jsonObjects objectForKey:key]);
        CODIGO=[jsonObjects objectForKey:@"CODIGO"];
        LOGIN=[jsonObjects objectForKey:@"LOGIN"];
        ABREVIACAO=[jsonObjects objectForKey:@"ABREVIACAO"];
        DENTISTA_VINCULADO=[jsonObjects objectForKey:@"DENTISTA_VINCULADO"];
    }
    
    if ( [CODIGO isEqualToString:@"0"] )
    {
       UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Senha Inválida" message:@"Erro nas credenciais de acesso!" delegate:self cancelButtonTitle:@"Voltar" otherButtonTitles:nil];
        [alert show];
    }
    else
    {
        if ( [DENTISTA_VINCULADO isEqualToString:@"0"] || [DENTISTA_VINCULADO isEqualToString:@"-1"] )
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"EM CONSTRUCAO" message:@"ENTRAR AQUI NA TELA DE SELECAO DO DENTISTA" delegate:self cancelButtonTitle:@"Voltar" otherButtonTitles:nil];
            [alert show];
        }
        else
        {
            //UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"EM CONSTRUCAO" message:@"ABRIR JANELA DE AGENDA DO MEDICO" delegate:self cancelButtonTitle:@"Voltar" otherButtonTitles:nil];
            //[alert show];
            appDel.gdentista =  DENTISTA_VINCULADO ;
            appDel.gdata = [NSMutableString stringWithFormat:@"2014-01-10"];
            appDel.guser = LOGIN;
            appDel.gpass = passwordField.text;
            appDel.gabreviacaodentista= ABREVIACAO;
            
           [self performSegueWithIdentifier:@"LoginMedicoVinculadoSegue" sender:self];
                        
        }
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue
                  sender:(id)sender
{

}


@end
