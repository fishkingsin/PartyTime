//
//  MyGuiView.m
//  iPhone Empty Example
//
//  Created by theo on 26/01/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MyGuiView.h"
#include "ofxiOSExtras.h"


@implementation MyGuiView

// called automatically after the view is loaded, can be treated like the constructor or setup() of this class
-(void)viewDidLoad {
	myApp = (ofApp*)ofGetAppPtr();
}

//----------------------------------------------------------------
-(IBAction)hide:(id)sender{
	self.view.hidden = YES;
}
//----------------------------------------------------------------
-(IBAction)hostSwitch:(id)sender{
    UISwitch * toggle = sender;

    if([toggle isOn])
    {
        myApp->session.stopAdvertising();
        [self setStatusString:@"Start hosting the party"];
        inviteButton.hidden = NO;
    }
    else{
        myApp->session.startAdvertising("dance-party");
        [self setStatusString:@"start advertising"];
        inviteButton.hidden = YES;
    }
}
-(IBAction)invitePressed:(id)sender
{
    myApp->session.inviteWithServiceName("dance-party");
    
}

-(void)setStatusString:(NSString *)trackStr
{
    [displayText setText:trackStr];
}
@end
