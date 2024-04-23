String[] lines;
String[][] elementInfo;
Float[][] elementCoords;
float SCALE = 35;
float X = 0.6;
float Y = 0.6;
HashMap<String, Color> typeColor = new HashMap<String, Color>();
PFont font;
void setup(){
  //size(1000, 640);
  font = createFont("TimesNewRomanPS-BoldMT", 32);
  println(PFont.list());
  fullScreen();
  pixelDensity(2);
  
  
  typeColor.put("Alkali Metal", new Color(255, 0, 255));
  typeColor.put("Alkaline Earth Metal", new Color(255, 0, 0));
  typeColor.put("Metal", new Color(255, 125, 0));
  typeColor.put("Transition Metal", new Color(255, 255, 0));
  typeColor.put("Metalloid", new Color(0, 0, 255));
  typeColor.put("Nonmetal", new Color(125, 0, 255));
  typeColor.put("Halogen", new Color(0, 255, 0));
  typeColor.put("Noble Gas", new Color(0, 255, 255));
  
  
  lines = loadStrings("elements-2.csv");
  elementInfo = new String[lines.length][3];
  elementCoords = new Float[lines.length][2];
  if (lines != null){
    for (int i=0; i<lines.length; i++){
      String[] values = lines[i].split(",");
      elementInfo[i][0] = values[0];
      elementInfo[i][1] = values[1];
      elementCoords[i][0] = Float.parseFloat(values[2]);
      elementCoords[i][1] = Float.parseFloat(values[3]);
      elementInfo[i][2] = values[4];
    }
  }
}

void draw(){
  background(0);
  pushMatrix();
  
  translate(width*X, height*Y);
;
  //circle(10, 100, 100);
  textFont(font);
  for (int i=0; i<elementCoords.length; i++){
    fill(typeColor.getOrDefault(elementInfo[i][2], new Color(255, 255, 255)).getColor());
    textSize(15);
    text(elementInfo[i][1], elementCoords[i][0]*SCALE, elementCoords[i][1]*SCALE);
  }
  popMatrix();
}
