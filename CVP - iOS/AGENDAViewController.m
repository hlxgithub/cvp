//
//  AGENDAViewController.m
//  CVP - iOS
//
//  Created by halverny on 3/4/14.
//  Copyright (c) 2014 Clinica Vicente de Paula. All rights reserved.
//

#import "AGENDAViewController.h"
#import "DETALHEATENDIMENTOViewController.h"

@interface AGENDAViewController ()

@end

@implementation AGENDAViewController
@synthesize horasList, nomepacientesList,
celularpacientesList, codigopacientesList,
codigoatendimentosList, situacoesatendimentosList;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

//- (void)viewDidAppear:(BOOL)animated {
//    [super viewWillAppear:animated];
   // [self.tableView reloadData];
//}

- (void)viewDidLoad
{
    [super viewDidLoad];

 //   [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refresh:) name:@"RefreshMasterNotification" object:nil];

    NSMutableString *urlString = [NSMutableString stringWithFormat:@"http://www.halvernyx.com.br/php/retornaagenda.php"];

[urlString appendString:[NSString stringWithFormat:@"?%@=%@", @"user_name", appDel.guser ]];
    
[urlString appendString:[NSString stringWithFormat:@"&%@=%@", @"password", appDel.gpass]];
    
[urlString appendString:[NSString stringWithFormat:@"&%@=%@", @"medico", appDel.gdentista ]];
    
[urlString appendString:[NSString stringWithFormat:@"&%@=%@", @"dia", appDel.gdata]];
    
[urlString appendString:[NSString stringWithFormat:@"&%@=%@", @"key", @"cronos"]];
   
[urlString setString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];

NSURL *url = [NSURL URLWithString:urlString];

NSData *jsonData = [NSData dataWithContentsOfURL:url];

NSDictionary *jsonObjects = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
    
horasList = [[NSMutableArray alloc]initWithObjects:nil];
codigopacientesList = [[NSMutableArray alloc]initWithObjects:nil];
nomepacientesList  = [[NSMutableArray alloc]initWithObjects:nil];
codigoatendimentosList = [[NSMutableArray alloc]initWithObjects:nil];
celularpacientesList  = [[NSMutableArray alloc]initWithObjects:nil];
situacoesatendimentosList  = [[NSMutableArray alloc]initWithObjects:nil];
    
    for (NSDictionary *ate in jsonObjects){
        
        NSString *hora = [ate objectForKey:@"HORA"];
        NSString *pac = [ate objectForKey:@"NOME"];
        NSString *cpac = [ate objectForKey:@"CODIGO_PACIENTE"];
        NSString *cate = [ate objectForKey:@"ATENDIMENTO"];
        NSString *fone = [ate objectForKey:@"FONE"];
        NSString *sit = [ate objectForKey:@"SITUACAO"];

        
    //    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Senha Inválida" message:@"Erro nas credenciais de acesso!" delegate:self cancelButtonTitle:teste otherButtonTitles:nil];
     //   [alert show];
        
        [nomepacientesList addObject:pac];
        [horasList addObject:hora];
        [codigopacientesList addObject:cpac];
        [codigoatendimentosList addObject:cate];
        [celularpacientesList addObject:fone];
        [situacoesatendimentosList addObject:sit];
    }

 //_atendimentosArray =[NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
    
     
 //   NSMutableArray *ke =[jsonObjects objectForKey:@"MEDICO"];
 //   _atendimentosArray = [jsonObjects objectForKey:@"MEDICO"];
/*

NSMutableString *CD = [NSMutableString stringWithFormat:@"0"];
NSMutableString *NOMEDENTISTA = [NSMutableString stringWithFormat:@""];
NSMutableString *ABREVIACAO = [NSMutableString stringWithFormat:@""];

    
// values in foreach loop
for (NSString *key in keys) {
    NSLog(@"%@ is %@",key, [jsonObjects objectForKey:key]);
}

if ( [CD isEqualToString:@"0"] )
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Senha Inválida" message:@"Erro nas credenciais de acesso!" delegate:self cancelButtonTitle:@"Voltar" otherButtonTitles:nil];
    [alert show];
}
else
{
    
}
*/
    
    NSString *titulo = @"";
  NSString *d =[appDel.gdata substringWithRange:NSMakeRange(8, 2)];
  NSString *m =[appDel.gdata substringWithRange:NSMakeRange(5, 2)];
  NSString *y =[appDel.gdata substringWithRange:NSMakeRange(0, 4)];
    titulo = [titulo stringByAppendingString:d];
    titulo = [titulo stringByAppendingString:@"/"];
    titulo = [titulo stringByAppendingString:m];
    titulo = [titulo stringByAppendingString:@"/"];
    titulo = [titulo stringByAppendingString:y];
    
    self.title =titulo;
    
   }


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return horasList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if(cell == nil){
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text=[horasList objectAtIndex:indexPath.row];
    cell.detailTextLabel.text= [nomepacientesList objectAtIndex:indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


- (void) prepareForSegue:(UIStoryboardSegue *)segue
    sender:(id)sender
{
    DETALHEATENDIMENTOViewController * DVC = [[DETALHEATENDIMENTOViewController alloc]init];
    
    DVC = [segue destinationViewController];
    
    NSIndexPath * path = [self.tableView indexPathForSelectedRow];
    NSString * horario = [horasList objectAtIndex:path.row];
    NSString * nomepac = [nomepacientesList objectAtIndex:path.row];
    NSString * codigopac = [codigopacientesList objectAtIndex:path.row];
    NSString * celpac = [celularpacientesList objectAtIndex:path.row];
    NSString * codigoatend = [codigoatendimentosList objectAtIndex:path.row];
    NSString * sitatend = [situacoesatendimentosList objectAtIndex:path.row];
    
    DVC.situacao_atendimento = sitatend;
    DVC.horario = horario;
    DVC.nome_paciente = nomepac;
    DVC.codigo_paciente = codigopac;
    DVC.codigo_atendimento=codigoatend;
    DVC.celular_paciente=celpac;
    DVC.user_name = appDel.guser;
    DVC.password = appDel.gpass;
    DVC.dia = appDel.gdata;
    DVC.abreviacao_dentista = appDel.gabreviacaodentista;
}
/*
#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.

     DETALHEATENDIMENTOViewController * DVC = [[DETALHEATENDIMENTOViewController alloc] init];
    
    DVC.characterName = [characterList objectAtIndex:indexPath.row];
    DVC.characterNumber = [indexPath row];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:DVC animated:YES];
}
 */

@end
