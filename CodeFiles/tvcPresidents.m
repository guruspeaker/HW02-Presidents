//
//  tvcPresidents.m
//  HW02-Presidents
//
//  Created by PAUL CHRISTIAN on 11/19/17.
//  Copyright © 2017 PAUL CHRISTIAN. All rights reserved.
//

#import "tvcPresidents.h"
#import "tvcCellPresidents.h"
#import "vcPresidentDetails.h"
#import "president.h"

@interface tvcPresidents ()<UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic)NSDictionary* PresidentDictionary;
@property (strong, nonatomic)NSArray* PresidentIndex;
@property (strong, nonatomic)NSArray* PresidentName;
@property (strong, nonatomic)NSMutableArray* filteredPresidentIndex;
@property (nonatomic)BOOL isFiltered;
@end

@implementation tvcPresidents

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"US Presidents";
    _isFiltered = NO;
    NSString* path = [[NSBundle mainBundle]pathForResource:@"Presidents" ofType:@"plist"];
    _PresidentDictionary = [NSDictionary dictionaryWithContentsOfFile:path];
    _PresidentIndex = [[_PresidentDictionary allKeys]sortedArrayUsingSelector:@selector(compare:)];
    NSMutableArray *hereComesTheChief = [[NSMutableArray alloc]init];
    for (int i=0;i<[_PresidentIndex count];i++)
    {
        NSLog(@"%d: %@",i,_PresidentDictionary[_PresidentIndex[i]][@"Name"]);
        [hereComesTheChief insertObject:_PresidentDictionary[_PresidentIndex[i]][@"Name"] atIndex:i];
    }
    _PresidentName = hereComesTheChief;
    _searchBar.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
    if (_isFiltered)
        {return [_filteredPresidentIndex count];}
    else
        {return [_PresidentIndex count];}
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString* cellIdentifier = @"PresInfoCellID";
    tvcCellPresidents *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    NSString *item = [[NSString alloc]init];
    if(_isFiltered)
    {
        item = [NSString stringWithFormat:@"%@",_filteredPresidentIndex[indexPath.row]];
    }
    else
    {
        item = [NSString stringWithFormat:@"%@",_PresidentIndex[indexPath.row]];
    }
    NSLog(@"item is: %@",item);
    cell.lblName.text = _PresidentDictionary[item][@"Name"];
    cell.lblName.font = [UIFont fontWithName:@"Bodoni 72 Smallcaps" size:24];
    [cell.lblName setTextColor:[UIColor brownColor]];
    
    cell.lblParty.text = _PresidentDictionary[item][@"party"];
    cell.lblParty.font = [UIFont fontWithName:@"EuphemiaUCAS-Italic" size:14];
    NSString* PresImgPathSM = [NSString stringWithFormat:@"Files/sm/%@.jpg",item];
    cell.imgPic.image = [UIImage imageNamed:PresImgPathSM];
    cell.lblTerm.text = _PresidentDictionary[item][@"served"];
    cell.lblTerm.font = [UIFont fontWithName:@"Georgia-Italic" size:12];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    //cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    //cell.accessoryType = UITableViewCellAccessoryCheckmark;
    //cell.accessoryType = UITableViewCellAccessoryDetailButton;
    
    // Configure the cell...
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier]isEqualToString:@"segPresidentDetail"])
    {
        
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        
        vcPresidentDetails *detailVC = [segue destinationViewController];
        NSLog(@"Sender lblName = %@",[sender lblName].text);
        NSString* keyIndex = _PresidentIndex[[_PresidentName indexOfObject:[sender lblName].text]];
        NSLog(@"keyIndex = %@",keyIndex);
        president *inauguratedPresident = [[president alloc] init];
        inauguratedPresident.PresIndex = keyIndex;
        inauguratedPresident.name = _PresidentDictionary[keyIndex][@"Name"];
        inauguratedPresident.lived = _PresidentDictionary[keyIndex][@"lived"];
        inauguratedPresident.birthplace = _PresidentDictionary[keyIndex][@"birthplace"];
        inauguratedPresident.deathplace = _PresidentDictionary[keyIndex][@"deathplace"];
        inauguratedPresident.served = _PresidentDictionary[keyIndex][@"served"];
        inauguratedPresident.terms = _PresidentDictionary[keyIndex][@"terms"];
        inauguratedPresident.party = _PresidentDictionary[keyIndex][@"party"];
        inauguratedPresident.occupation = _PresidentDictionary[keyIndex][@"occupation"];
        NSLog(@"inauguratedPresident = %@",inauguratedPresident);
        detailVC.potus = inauguratedPresident;
        
    }
    
}


#pragma mark - Search Bar Delegate
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    NSLog(@"Search Text: %@ - Length: %lu",searchText,(unsigned long)searchText.length);
    if(searchText.length == 0)
    {
        _isFiltered = NO;
        
    }
    else
    {
        _isFiltered = YES;
        self.filteredPresidentIndex = [[NSMutableArray alloc] init];
        for (NSString* presName in _PresidentName)
        {
            NSLog(@"Search Text: %@, President Name: %@",searchText,presName);
            NSRange nameRange = [presName rangeOfString:searchText options:NSCaseInsensitiveSearch];
            if (nameRange.location !=NSNotFound)
            {
                [self.filteredPresidentIndex addObject:_PresidentIndex[[_PresidentName indexOfObject:presName]]];
                NSLog(@"Filtered: %@",_filteredPresidentIndex);
                
            }
        }
        
        
        
        
        
    }
    [self.tableView reloadData];
    
}

@end
