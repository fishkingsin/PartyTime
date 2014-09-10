#include "ofApp.h"
#include "MyGuiView.h"

int n;
MyGuiView * myGuiViewController;
//--------------------------------------------------------------
void ofApp::setup(){
    NSString * name = [[UIDevice currentDevice] name];
    session.setDisplayName([name UTF8String]);
    n = ofGetWidth()*ofGetHeight();
    ofSetLogLevel(OF_LOG_VERBOSE);
    ofAddListener(ofxMultipeerConnectivity::Events().onMessageReceived, this,  &ofApp::gotPeerMessage);
    ofAddListener(ofxMultipeerConnectivity::Events().onStatusChanged, this,  &ofApp::statusChanged);
    ofAddListener(ofxMultipeerConnectivity::Events().onDataReceived, this, &ofApp::gotData);
//    session.startHosting("Host");
//    bHost = true;
    
    bgColor.setSaturation(1);
    bgColor.setBrightness(0.85);
    bgColor.setHue(1);
    bgColor.set(255,0,0);
    myGuiViewController	= [[MyGuiView alloc] initWithNibName:@"MyGuiView" bundle:nil];
	[ofxiOSGetGLParentView() addSubview:myGuiViewController.view];
    

}

//--------------------------------------------------------------
void ofApp::update(){
    
}

//--------------------------------------------------------------
void ofApp::draw(){
    
    
    ofPushStyle();
    
    ofSetColor(bgColor);
    ofRect(0, 0, ofGetWidth() , ofGetHeight());
    ofPopStyle();
    
	ofDrawBitmapString("Double Tap to invite guest", 20,20);
    
}

//--------------------------------------------------------------
void ofApp::exit(){
    
}

//--------------------------------------------------------------
void ofApp::touchDown(ofTouchEventArgs & touch){
    
}

//--------------------------------------------------------------
void ofApp::touchMoved(ofTouchEventArgs & touch){
    //    host.sendMessage("x:"+ofToString(touch.x)+"y:"+ofToString(touch.y));
    float i = ((float)touch.x*touch.y)/(float)n;
    bgColor.setHsb(i*360, 255 , 200);
    unsigned char d[3];
    d[0] = bgColor.r;
    d[1] = bgColor.g;
    d[2] = bgColor.b;
    session.sendData(d,3);
}

//--------------------------------------------------------------
void ofApp::touchUp(ofTouchEventArgs & touch){
    //    host.sendMessage("x:"+ofToString(touch.x)+"y:"+ofToString(touch.y));
}

//--------------------------------------------------------------
void ofApp::touchDoubleTap(ofTouchEventArgs & touch){
//    host.invite("dance-party");
    if( myGuiViewController.view.hidden ){
		myGuiViewController.view.hidden = NO;
	}
}

//--------------------------------------------------------------
void ofApp::touchCancelled(ofTouchEventArgs & touch){
    
}

//--------------------------------------------------------------
void ofApp::lostFocus(){
    
}

//--------------------------------------------------------------
void ofApp::gotFocus(){
    
}

//--------------------------------------------------------------
void ofApp::gotMemoryWarning(){
    
}

//--------------------------------------------------------------
void ofApp::deviceOrientationChanged(int newOrientation){
    
}
void ofApp::gotPeerMessage(string &message)
{
    ofLogVerbose(__PRETTY_FUNCTION__) << message;
}
void ofApp::statusChanged(MCSessionState &state)
{
    switch (state) {
        case MCSessionStateNotConnected:
            [myGuiViewController setStatusString:@"Not Connected"];
            break;
        case MCSessionStateConnected:
            [myGuiViewController setStatusString:@"Connected"];
            break;
        case MCSessionStateConnecting:
            [myGuiViewController setStatusString:@"Connecting"];
            break;
            
        default:
            break;
    }
}
void ofApp::gotData(Data &dataArgs)
{
    if(dataArgs.length ==3)
    {
        unsigned char *tempBuffer = new unsigned char [3];
        memcpy(tempBuffer, dataArgs.data, dataArgs.length);
        bgColor.r = tempBuffer[0];
        bgColor.g = tempBuffer[1];
        bgColor.b = tempBuffer[2];
    }
}