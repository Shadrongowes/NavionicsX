//
//  FirstViewController.h
//  NavionicsX
//
//  Created by Jason Paolasini on 2015-09-24.
//  Copyright © 2015 Jason Paolasini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SecondViewController.h"

@interface FirstViewController : UIViewController <SecondViewControllerDelegate,UITabBarControllerDelegate>
@property (strong, nonatomic) NSArray *maplocations;
@end

