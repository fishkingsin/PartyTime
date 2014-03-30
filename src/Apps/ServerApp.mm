//
//  ServerApp.cpp
//  PartyTime
//
//  Created by James Kong on 30/3/14.
//
//

#include "ServerApp.h"
ServerApp::ServerApp (){
}
//--------------------------------------------------------
ServerApp::~ServerApp (){
    tcpServer.close();
}
//--------------------------------------------------------

void ServerApp::setup(){
    bonjourServer.startService( "_osc._tcp.", "osc", 7888 );
    //setup the server to listen on 11999
    
    tcpServer.setup(3000);
    //optionally set the delimiter to something else.  The delimter in the client and the server have to be the same, default being [/TCP]
    tcpServer.setMessageDelimiter("\n");
}
//--------------------------------------------------------
void ServerApp::update(){
    for(int i = 0; i < tcpServer.getLastID(); i++){
		if( !tcpServer.isClientConnected(i) )continue;
        
//		tcpServer.send(i, "hello client - you are connected on port - "+ofToString(tcpServer.getClientPort(i)) );
	}
}
//--------------------------------------------------------
void ServerApp::draw(){
    ofSetHexColor(0xDDDDDD);
	ofDrawBitmapString("tcpServer SERVER Example \n\nconnect on port: "+ofToString(tcpServer.getPort()), 10, 20);
//    
//	ofSetHexColor(0x000000);
//	ofRect(10, 60, ofGetWidth()-24, ofGetHeight() - 65 - 15);
    
	ofSetHexColor(0xDDDDDD);
    
	//for each connected client lets get the data being sent and lets print it to the screen
	for(unsigned int i = 0; i < (unsigned int)tcpServer.getLastID(); i++){
        
		if( !tcpServer.isClientConnected(i) )continue;
        
		//give each client its own color
		ofSetColor(255 - i*30, 255 - i * 20, 100 + i*40);
        
		//calculate where to draw the text
		int xPos = 15;
		int yPos = 80 + (12 * i * 4);
        
		//get the ip and port of the client
		string port = ofToString( tcpServer.getClientPort(i) );
		string ip   = tcpServer.getClientIP(i);
		string info = "client "+ofToString(i)+" -connected from "+ip+" on port: "+port;
        
        
		//if we don't have a string allocated yet
		//lets create one
		if(i >= storeText.size() ){
			storeText.push_back( string() );
		}
        
		//we only want to update the text we have recieved there is data
		string str = tcpServer.receive(i);
        
		if(str.length() > 0){
			storeText[i] = str;
		}
        
		//draw the info text and the received text bellow it
		ofDrawBitmapString(info, xPos, yPos);
		ofDrawBitmapString(storeText[i], 25, yPos + 20);
        
	}
}
//--------------------------------------------------------
void ServerApp::exit(){
    tcpServer.close();
}
//--------------------------------------------------------

void ServerApp::touchDown(ofTouchEventArgs &touch){
    tcpServer.sendToAll("Hello"+ofToString(ofGetTimestampString()));
}
//--------------------------------------------------------
void ServerApp::touchMoved(ofTouchEventArgs &touch){
}
//--------------------------------------------------------
void ServerApp::touchUp(ofTouchEventArgs &touch){
}
//--------------------------------------------------------
void ServerApp::touchDoubleTap(ofTouchEventArgs &touch){
}
//--------------------------------------------------------
void ServerApp::touchCancelled(ofTouchEventArgs &touch){
}
//--------------------------------------------------------

void ServerApp::lostFocus(){
}
//--------------------------------------------------------
void ServerApp::gotFocus(){
}
//--------------------------------------------------------
void ServerApp::gotMemoryWarning(){
}
//--------------------------------------------------------
void ServerApp::deviceOrientationChanged(int newOrientation){
}
//--------------------------------------------------------
