

import netP5.*;
import oscP5.*;

class LightManager{

  OscP5 osc;
  NetAddress myLoc;
  ArrayList<Light> lights;
  int numFixturesOnSide;
  
  int maxColorBufSize = 100;
  
  
  //-----------------------------------------------------
  void init(String destIP, int destPort){
    numFixturesOnSide = 6;
    int widthScale = width/(numFixturesOnSide*2);
    lights = new ArrayList<Light>();
    maxColorBufSize = 50;
    col = 0;
    osc = new OscP5(this, 4000);
    myLoc = new NetAddress(destIP, destPort);
    sending = false;
  
    // Create lights
    for (int i = 0; i < numFixturesOnSide; i++) {
      Light l = new Light(new PVector((widthScale*i*2)-1, 30), 10, 48); 
      lights.add(l);
    }
  
    for (int i = 0; i < numFixturesOnSide; i++) {
      Light l = new Light(new PVector((widthScale*i*2)-1, height - 30), 10, 48); 
      lights.add(l);
    }
  }
  
  //-----------------------------------------------------
  void sendMessages() {
    /* in the following different ways of creating osc messages are shown by example */
    OscMessage colorMessage = new OscMessage("/lights");
    // Message structure light1r - light1g - light1b - light2r - light2g - light2b
    for (int i = 0; i < lights.size(); i++) {
      
      Light l = lights.get(i);
      int r = 0, g = 0, b = 0;
      for (int j = 0; j < l.indColors.length; j++) {
        color c = l.indColors[j];
        colorMessage.add((int) c>>16&0xFF);
        colorMessage.add((int) c>>8&0xFF);
        colorMessage.add((int) c&0xFF);
      }
    }
    /* send the message */
    osc.send(colorMessage, myLoc);
  }
  
  //-----------------------------------------------------
  void display(){
    for (int i = 0; i < lights.size(); i++) {
      Light l = lights.get(i);
      l.display();
    }
  }
  
  //-----------------------------------------------------
  void changeBufferSize(int bufSize) {
    for(int i = 0; i < lights.size(); i++){
      Light l = lights.get(i);
      l.maxColorBuffSize = bufSize;
    }
  }

}