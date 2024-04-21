String[] lines;
String[][] elementInfo;
Float[][] elementCoords;
float SCALE = 35;
float X = 0.6;
float Y = 0.6;
void setup(){
  //size(1000, 640);
  fullScreen();
  pixelDensity(2);
  lines = loadStrings("elements-2.csv");
  elementInfo = new String[lines.length][2];
  elementCoords = new Float[lines.length][2];
  if (lines != null){
    for (int i=0; i<lines.length; i++){
      String[] values = lines[i].split(",");
      elementInfo[i][0] = values[0];
      elementInfo[i][1] = values[1];
      elementCoords[i][0] = Float.parseFloat(values[2]);
      elementCoords[i][1] = Float.parseFloat(values[3]);
    }
  }
}

void draw(){
  background(0);
  pushMatrix();
  
  translate(width*X, height*Y);
;
  //circle(10, 100, 100);
  for (int i=0; i<elementCoords.length; i++){
    textSize(15);
    text(elementInfo[i][1], elementCoords[i][0]*SCALE, elementCoords[i][1]*SCALE);
  }
  popMatrix();
}
