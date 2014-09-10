//
//  MyGuiView.h
//  iPhone Empty Example
//
//  Created by theo on 26/01/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#include "ofApp.h"

@interface MyGuiView : UIViewController {
	ofApp *myApp;		// points to our instance of ofApp

    IBOutlet UIButton *inviteButton;
    IBOutlet UILabel *displayText;
}
-(void)setStatusString:(NSString *)trackStr;
-(IBAction)hide:(id)sender;
-(IBAction)hostSwitch:(id)sender;
-(IBAction)invitePressed:(id)sender;

@end
