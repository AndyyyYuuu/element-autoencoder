String[] lines;
String[][] elementInfo;
Float[][] elementCoords;
float SCALE = 30;
float X = 0.2;
float Y = 0.6;
float r = 0;
HashMap<String, Color> typeColor = new HashMap<String, Color>();
PFont font;

int SYMBOLS = 0; 
int SPHERES = 1;

int mode = SYMBOLS; 
void setup(){
  //size(1000, 640);
  size(800,800,P3D);
  font = createFont("CourierNewPS-BoldMT", 32);
  println(PFont.list());
  //fullScreen();
  pixelDensity(2);
  
  
  typeColor.put("Alkali Metal", new Color(255, 0, 255));
  typeColor.put("Alkaline Earth Metal", new Color(255, 0, 0));
  typeColor.put("Metal", new Color(255, 125, 0));
  typeColor.put("Transition Metal", new Color(255, 255, 0));
  typeColor.put("Metalloid", new Color(0, 0, 255));
  typeColor.put("Nonmetal", new Color(125, 0, 255));
  typeColor.put("Halogen", new Color(0, 255, 0));
  typeColor.put("Noble Gas", new Color(0, 255, 255));
  
  
  lines = loadStrings("elements-3.csv");
  elementInfo = new String[lines.length][3];
  elementCoords = new Float[lines.length][3];
  if (lines != null){
    for (int i=0; i<lines.length; i++){
      String[] values = lines[i].split(",");
      elementInfo[i][0] = values[0];
      elementInfo[i][1] = values[1];
      elementInfo[i][2] = values[2];
      elementCoords[i][0] = Float.parseFloat(values[3]);
      elementCoords[i][1] = Float.parseFloat(values[4]);
      elementCoords[i][2] = Float.parseFloat(values[5]);
    }
  }
}

void draw(){
  background(0);
  pushMatrix();
  r += 0.01;
  translate(width/2, height/2, 0);
  r = 0.95*r + 0.05*(((float)mouseX/width*TWO_PI)%TWO_PI);
  rotateY(r);
  translate(-width/2, -height/2, 0);
  translate(width*X, height*Y, -100);
  
  
  textFont(font);
  for (int i=0; i<elementCoords.length; i++){
    color c = typeColor.getOrDefault(elementInfo[i][2], new Color(255, 255, 255)).getColor();
    fill(c);
    
    pushMatrix();
    translate(elementCoords[i][0]*SCALE, elementCoords[i][1]*SCALE, elementCoords[i][2]*SCALE);
    if (mode == SYMBOLS){
      rotateY(-r);
      textSize(12);
      text(elementInfo[i][1], 0, 0, 0);
    }else if (mode == SPHERES){
      stroke(c);
      sphere(2);
      
    }
    popMatrix();
  }
  popMatrix();
}
