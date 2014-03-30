//
//  ServerApp.h
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
class ServerApp : public ofxiOSApp {
	
public:
    
    ServerApp ();
    ~ServerApp ();
    
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
    Server bonjourServer;
    
    ofxTCPServer tcpServer;
    vector <string> storeText;
};


