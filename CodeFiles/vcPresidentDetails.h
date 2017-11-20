//
//  vcPresidentDetails.h
//  HW02-Presidents
//
//  Created by PAUL CHRISTIAN on 11/19/17.
//  Copyright © 2017 PAUL CHRISTIAN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "president.h"
#import "tvcPresidents.h"
#import "tvcCellPresidents.h"

@interface vcPresidentDetails : UIViewController
@property(strong, nonatomic)president* potus;
@property(strong, nonatomic)NSString* viewTitle;

@end
