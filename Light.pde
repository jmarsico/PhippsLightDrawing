class Light {

  PVector loc;
  color[] indColors;
  int indLength;
  int wid;
  ArrayList<Integer>[] colorBuf;
  int maxColorBuffSize = 10;

  Light(PVector location, int w, int indLen) {
    loc = new PVector();
    loc.x = location.x;
    loc.y = location.y;
    indColors = new color[4];
    colorBuf = new ArrayList[4];
    colorBuf[0] = new ArrayList<Integer>();
    colorBuf[1] = new ArrayList<Integer>();
    colorBuf[2] = new ArrayList<Integer>();
    colorBuf[3] = new ArrayList<Integer>();
    indLength = indLen;
    wid = w;
  }

  void getColor(int indLight) {
    loadPixels();
    PImage screenRect = get((int) loc.x + indLength * indLight, (int) loc.y, indLength, wid);
    int r = 0, g = 0, b = 0;
    for (int i = 0; i < screenRect.pixels.length; i++) {
      color c = screenRect.pixels[i];
      r += c>>16&0xFF;
      g += c>>8&0xFF;
      b += c&0xFF;
    }

    r /= screenRect.pixels.length;
    g /= screenRect.pixels.length;
    b /= screenRect.pixels.length;

    colorBuf[indLight].add(color(r, g, b));
    if (colorBuf[indLight].size() > maxColorBuffSize) {
      colorBuf[indLight].remove(0);
    }
    r = 0;
    g = 0;
    b = 0;

    for (int i = 0; i < colorBuf[indLight].size(); i++ ) {
      color c = colorBuf[indLight].get(i);
      r += c>>16&0xFF;
      g += c>>8&0xFF;
      b += c&0xFF;
    }

    r /= colorBuf[indLight].size();
    g /= colorBuf[indLight].size();
    b /= colorBuf[indLight].size();
    indColors[indLight] =  color(r, g, b);
  }

  void display() {
    noStroke();

    for (int i = 0; i < indColors.length; i++) {
      getColor(i);
      displayLight(i);
    }
  }

  void displayLight(int indLight) {
    fill(indColors[indLight]);
    rect((int) loc.x + indLength * indLight, (int) loc.y, indLength, wid);
    
    noFill();
    stroke(255);
    rect((int) loc.x + indLength * indLight, (int) loc.y, indLength, wid);
  }
}