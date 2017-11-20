//
//  vcPresidentDetails.m
//  HW02-Presidents
//
//  Created by PAUL CHRISTIAN on 11/19/17.
//  Copyright © 2017 PAUL CHRISTIAN. All rights reserved.
//

#import "vcPresidentDetails.h"

@interface vcPresidentDetails ()
@property (weak, nonatomic) IBOutlet UIImageView *imgImage;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblParty;
@property (weak, nonatomic) IBOutlet UILabel *lblServed;
@property (weak, nonatomic) IBOutlet UITextView *lblTextDetails;
@property (weak, nonatomic) IBOutlet UILabel *lblWhichOne;

@end

@implementation vcPresidentDetails

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = self.potus.name;
    self.imgImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"Files/lg/%@.jpg",self.potus.PresIndex]];
    // Name
    self.lblName.text = self.potus.name;
    self.lblName.font = [UIFont fontWithName:@"Bodoni 72 Smallcaps" size:34];
    [self.lblName setTextColor:[UIColor brownColor]];
    
    // Which One
    self.lblWhichOne.text = [NSString stringWithFormat:@"The %@ President of the United States",[self IndexWithSuffex]];
    self.lblWhichOne.font = [UIFont fontWithName:@"Bodoni 72 Smallcaps" size:18];
    
    // Served
    self.lblServed.text = self.potus.served;
    self.lblServed.font = [UIFont fontWithName:@"Verdana-Italic" size:12];
    
    self.lblParty.text = self.potus.party;
    self.lblParty.font = [UIFont fontWithName:@"Trebuchet-BoldItalic" size:14];

    if ([self.potus.party isEqualToString:@"Democrat"])
        {[self.lblParty setTextColor: [UIColor blueColor]];}
    else if ([self.potus.party isEqualToString:@"Republican"])
        {[self.lblParty setTextColor: [UIColor redColor]];}
    
    
    self.lblTextDetails.text = [NSString stringWithFormat: @"Term Details: %@.\n\nBorned in %@.\nDied in %@.\n%@\n\nBefore becoming president, Occupations include: %@.",self.potus.terms,self.potus.birthplace,self.potus.deathplace,self.potus.lived, self.potus.occupation];
    self.lblTextDetails.font = [UIFont fontWithName:@"STHeitiK-Light" size:14];
    
    
                                NSLog(@"%@",[self IndexWithSuffex]);
    

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier]isEqualToString:@"sguShowDetail"])
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
    // number suffix
-(NSString*)IndexWithSuffex
{
    NSString* sfx = [[NSString alloc]init];
    NSString* IndexWithsfx = [[NSString alloc]init];
    if (![[self.potus.PresIndex substringToIndex:1]  isEqual: @"1"])
    {
        if ([[self.potus.PresIndex substringFromIndex:1]  isEqual: @"1"])
            sfx = @"st";
        else if ([[self.potus.PresIndex substringFromIndex:1]  isEqual: @"2"])
            sfx = @"nd";
        else if ([[self.potus.PresIndex substringFromIndex:1]  isEqual: @"3"])
            sfx = @"rd";
        else
            sfx= @"th";
    }
    else
    {
        sfx = @"th";
    }
    if ([[self.potus.PresIndex substringToIndex:1] isEqual: @"0"])
        IndexWithsfx = [NSString stringWithFormat:@"%@%@",[self.potus.PresIndex substringFromIndex:1],sfx];
    else
        IndexWithsfx = [NSString stringWithFormat:@"%@%@",self.potus.PresIndex,sfx];
    
    return IndexWithsfx;
}
@end
