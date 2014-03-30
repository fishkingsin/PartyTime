//
//  ClientApp.h
//  PartyTime
//
//  Created by James Kong on 30/3/14.
//
//

#pragma once

#include "ofMain.h"
#include "ofxiOS.h"
#include "ofxiOSExtras.h"
#include "ofxBonjour.h"
using namespace ofxBonjour;
#include "ofxNetwork.h"
class ClientApp : public ofxiOSApp {
	
public:
    
    ClientApp ();
    ~ClientApp ();
    
	void setup();
	void update();
	void draw();
	void exit();
	
	void touchDown(ofTouchEventArgs &touch);
	void touchMoved(ofTouchEventArgs &touch);
	void touchUp(ofTouchEventArgs &touch);
	void touchDoubleTap(ofTouchEventArgs &touch);
	void touchCancelled(ofTouchEventArgs &touch);
    
	void lostFocus();
	void gotFocus();
	void gotMemoryWarning();
	void deviceOrientationChanged(int newOrientation);
    void discoveredServices( vector<NSNetService*> & services );
    void gotServiceData( Service & service );
    
    Client bonjourClient;
    ofxTCPClient tcpClient;
    
    float counter;
    int connectTime;
    int deltaTime;
    
    bool weConnected;
    string msgRx;
};


