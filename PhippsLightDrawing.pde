

int roomWidth = 30;
int roomLength = 100;

int lightActualLength = 4;
PImage room;

// Color of the brush to increment through hue.
int col;

boolean sending;
boolean bDrawLights;
LightManager lightManager;


void setup() {
  // 1 pixel = 1 inch (technically)
  size(1200, 360);
  frameRate(30);
  background(0);


  lightManager = new LightManager();
  lightManager.init("127.0.0.1", 12345);
  
  // Set up variables
  room = loadImage("roomimage.png");
  
}


void draw() {
  background(0);
  
  colorMode(HSB);
  ellipseMode(CENTER);
  fill(col%255, 255, 255);
  ellipse(mouseX, mouseY, 200, 200);
  colorMode(RGB);
  col++;
  
  if (sending){
    lightManager.sendMessages();
    lightManager.display();
  }
}

void keyPressed() {
  if (key == 's') {
    sending = !sending;
  }

 
}