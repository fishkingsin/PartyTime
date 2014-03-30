//
//  ClientApp.cpp
//  PartyTime
//
//  Created by James Kong on 30/3/14.
//
//

#include "ClientApp.h"
ClientApp::ClientApp (){
}
//--------------------------------------------------------
ClientApp::~ClientApp (){
    tcpClient.close();
}
//--------------------------------------------------------

void ClientApp::setup(){
    connectTime = 99999999;
    ofAddListener(ofxBonjour::Events().onServicesDiscovered, this, &ClientApp::discoveredServices);
    ofAddListener(ofxBonjour::Events().onServiceDiscovered, this, &ClientApp::gotServiceData );
    bonjourClient.discover("_osc._tcp.");
    weConnected = false;
}
//--------------------------------------------------------
void ClientApp::update(){
    //we are connected - lets send our text and check what we get back
	if(weConnected){
     
        if(tcpClient.send("Hello"+ofToString(ofGetTimestampString()))){
            
			//if data has been sent lets update our text
			string str = tcpClient.receive();
			if( str.length() > 0 ){
				msgRx = str;
			}
		}else if(!tcpClient.isConnected()){
			weConnected = false;
		}

        
	}
    else{
        deltaTime = ofGetElapsedTimeMillis() - connectTime;
        
		if( deltaTime > 5000 ){
			bonjourClient.discover("_osc._tcp.");
            
			connectTime = ofGetElapsedTimeMillis();
		}
    }
}
//--------------------------------------------------------
void ClientApp::draw(){
    
    ofSetColor(20, 20, 20);
	ofDrawBitmapString("openFrameworks TCP Send Example", 15, 30);
    
	
    
	ofDrawBitmapString("from server: \n"+msgRx, 15, 270);
}
//--------------------------------------------------------
void ClientApp::exit(){
    tcpClient.close();
}
//--------------------------------------------------------

void ClientApp::touchDown(ofTouchEventArgs &touch){
     tcpClient.send("Hello"+ofToString(ofGetTimestampString()));
}
//--------------------------------------------------------
void ClientApp::touchMoved(ofTouchEventArgs &touch){
}
//--------------------------------------------------------
void ClientApp::touchUp(ofTouchEventArgs &touch){
}
//--------------------------------------------------------
void ClientApp::touchDoubleTap(ofTouchEventArgs &touch){
}
//--------------------------------------------------------
void ClientApp::touchCancelled(ofTouchEventArgs &touch){
}
//--------------------------------------------------------

void ClientApp::lostFocus(){
}
//--------------------------------------------------------
void ClientApp::gotFocus(){
}
//--------------------------------------------------------
void ClientApp::gotMemoryWarning(){
}
//--------------------------------------------------------
void ClientApp::deviceOrientationChanged(int newOrientation){
}

//--------------------------------------------------------------
void ClientApp::discoveredServices( vector<NSNetService*> & services ){
    for (int i=0; i<services.size(); i++){
        cout<< [services[i].description cStringUsingEncoding:NSUTF8StringEncoding] << endl;
    }
}

//--------------------------------------------------------------
void ClientApp::gotServiceData( Service & service ){
    ofLogVerbose("gotServiceData")<< "Server address : "<<service.ipAddress << "\nPort :" << service.port << endl;
    if(!weConnected)
    {
        weConnected = tcpClient.setup(service.ipAddress, 3000);
        if(weConnected)
        {
            ofLogVerbose(__PRETTY_FUNCTION__) << "connected " << service.ipAddress;
        }
        else{
            ofLogVerbose(__PRETTY_FUNCTION__) << "cannot connect " << service.ipAddress;
        }
        //optionally set the delimiter to something else.  The delimter in the client and the server have to be the same
        tcpClient.setMessageDelimiter("\n");
        
        connectTime = 0;
        deltaTime = 0;
    }
    
}

