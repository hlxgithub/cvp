//
//  DETALHEATENDIMENTOViewController.m
//  CVP - iOS
//
//  Created by halverny on 3/4/14.
//  Copyright (c) 2014 Clinica Vicente de Paula. All rights reserved.
//

#import "DETALHEATENDIMENTOViewController.h"

@interface DETALHEATENDIMENTOViewController ()
@end

@implementation DETALHEATENDIMENTOViewController

@synthesize user_name, password, codigo_atendimento, codigo_paciente, horario, celular_paciente, nome_paciente, situacao_atendimento, dia, abreviacao_dentista;

- (IBAction)TakePhoto
{
    picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    [picker setSourceType:UIImagePickerControllerSourceTypeCamera];
    [self presentViewController:picker animated:YES completion:NULL];
}
-(IBAction)ChooseExisting
{
    picker2 = [[UIImagePickerController alloc] init];
    picker2.delegate = self;
    [picker2 setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    [self presentViewController:picker2 animated:YES completion:NULL];
}

- (IBAction)LimparHorario{
    
if ( [situacao_atendimento isEqualToString:@"ATENDIDO"] ||  [situacao_atendimento isEqualToString:@"CONFIRMADO"] ||[situacao_atendimento isEqualToString:@"ENVIADO SMS"]||[situacao_atendimento isEqualToString:@"PRESENTE"] )

{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Operação Não Permitida!" message:@"O atendimento selecionado já foi marcado como atendido, presente ou confirmado no sistema gerencial e não pode ser alterado." delegate:self cancelButtonTitle:@"Voltar" otherButtonTitles:nil];
    [alert show];
}

else
{
       codigo_paciente = @"0";
       _txtSeNovoPac.text = @"Paciente sem cadastro";
       _txtNome.enabled = TRUE;
       _txtCelular.enabled = TRUE;
       _txtNome.text = @"";
       _txtCelular.text = @"";
       situacao_atendimento = @"ABERTO";
    
    UIImage *imgvazia = [UIImage imageNamed:@"nophoto-2.png"];
    _imgPaciente.image = imgvazia;
    fotoAlterada = [NSMutableString stringWithFormat:@"SIM"];
}
}

- (IBAction)SalvarAgenda{
   
    if ( [situacao_atendimento isEqualToString:@"ATENDIDO"] ||  [situacao_atendimento isEqualToString:@"CONFIRMADO"] ||[situacao_atendimento isEqualToString:@"ENVIADO SMS"]||[situacao_atendimento isEqualToString:@"PRESENTE"] )
        
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Operação Não Permitida!" message:@"O atendimento selecionado já foi marcado como atendido, presente ou confirmado no sistema gerencial e não pode ser alterado." delegate:self cancelButtonTitle:@"Voltar" otherButtonTitles:nil];
        [alert show];
    }
    
    else
    {
        // VALIDA PREENCHIMENTO DE NOME E CELULAR
    if ( _txtNome.text.length == INT16_C(0) &&  _txtCelular.text.length > INT16_C(0)  )
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Operação Não Permitida!" message:@"Não é possível salvar horário sem o nome do paciente." delegate:self cancelButtonTitle:@"Voltar" otherButtonTitles:nil];
        [alert show];
        return;
    }
    if ( _txtNome.text.length > INT16_C(0) &&  _txtCelular.text.length == INT16_C(0)  )
    {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Operação Não Permitida!" message:@"Não é possível salvar horário sem o fone do paciente." delegate:self cancelButtonTitle:@"Voltar" otherButtonTitles:nil];
            [alert show];
            return;
    }
        
        // VERIFICA EM QUE SITUACAO DEVE FICAR O ATENDIMENTO
        if ( _txtNome.text.length == INT16_C(0) &&  _txtCelular.text.length == INT16_C(0)  )
        {
            situacao_atendimento = @"ABERTO";
            codigo_paciente = @"0";
        }
        else
        {
        situacao_atendimento = @"AGENDADO";
        }
           
        // JOGA DADOS PRO MYSQL VIA PHP
        
        NSMutableString *urlString = [NSMutableString stringWithFormat:@"http://www.halvernyx.com.br/php/salvahorariocvp.php"];
        
        [urlString appendString:[NSString stringWithFormat:@"?%@=%@", @"user_name", user_name]];
        [urlString appendString:[NSString stringWithFormat:@"&%@=%@", @"password", password]];
        [urlString appendString:[NSString stringWithFormat:@"&%@=%@", @"atendimento", codigo_atendimento]];
        [urlString appendString:[NSString stringWithFormat:@"&%@=%@", @"codigo_paciente", codigo_paciente]];
        [urlString appendString:[NSString stringWithFormat:@"&%@=%@", @"nome",  _txtNome.text]];
        [urlString appendString:[NSString stringWithFormat:@"&%@=%@", @"fone", _txtCelular.text]];
        [urlString appendString:[NSString stringWithFormat:@"&%@=%@", @"situacao", situacao_atendimento]];
         
        [urlString appendString:[NSString stringWithFormat:@"&%@=%@",
                                 @"key", @"cronos"]];
        
        [urlString setString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        
        NSURL *url = [NSURL URLWithString:urlString];
        
        NSData *jsonData = [NSData dataWithContentsOfURL:url];
        
        id jsonObjects = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
        NSArray *keys = [jsonObjects allKeys];
        
        NSMutableString *RESPOSTA = [NSMutableString stringWithFormat:@"0"];
        
        // values in foreach loop
        for (NSString *key in keys) {
            NSLog(@"%@ is %@",key, [jsonObjects objectForKey:key]);
            RESPOSTA=[jsonObjects objectForKey:@"RESPOSTA"];
        }
        
        if ( [RESPOSTA isEqualToString:@"0"] )
        {
                    
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Erro Desconhecido" message:@"Não foi possível salvar os dados no servidor remoto. Verifique sua conexão ou se o servidor web encontra-se em ativo!" delegate:self cancelButtonTitle:@"Voltar" otherButtonTitles:nil];
            [alert show];
            return;
        }
        else
        {
            //UITableViewController *masterControler = [self.navigationController.viewControllers objectAtIndex:0];
           //[masterControler.tableView reloadData];
            
           
            
             [self.navigationController popToRootViewControllerAnimated:YES];
            
            
        }
        
        
        
        
        
        
        
    }
}

-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    image = [info objectForKey:UIImagePickerControllerOriginalImage];
//    [imageView setImage:image];
    [_imgPaciente setImage:image];
    [self dismissViewControllerAnimated:YES completion:NULL];
    
    fotoAlterada = [NSMutableString stringWithFormat:@"SIM"];
}

-(void) imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:NULL];
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    fotoAlterada = [NSMutableString stringWithFormat:@"NAO"];
    
    self.title = abreviacao_dentista;
    
    _txtHorario.text = horario;
    _txtNome.text = nome_paciente;
    _txtCelular.text = celular_paciente;
    
    if ( [codigo_paciente isEqual: @"0"] )
    {
        _txtSeNovoPac.text = @"Paciente sem cadastro";
        _txtNome.enabled = TRUE;
        _txtCelular.enabled = TRUE;
    }
    else
    {
        NSMutableString *txt = [NSMutableString stringWithFormat:@"Paciente: "];
        
        [txt appendString:codigo_paciente ];

        _txtSeNovoPac.text = txt;
        _txtNome.enabled = FALSE;
        _txtCelular.enabled = FALSE;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
