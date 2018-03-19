StringList names = new StringList();
PFont font;
Star[] star = new Star[150];
// The font must be located in the sketch's 
// "data" directory to load successfully

boolean roll = true;
boolean ending = false;
boolean previous = false;
boolean spin = true;
int randomNumber = 0;
String name = "";

void setup() {
  //fullScreen();
  size(1027, 768);
  loadNames();
  font = createFont("SourceCodePro-Bold-140.vlw", 140);
  textFont(font);
  textAlign(CENTER, CENTER);
  background(0);
  for (int i = 0; i < 150; i++) {
    float x = random(width);
    float y = random(height);
    float rot = 0;
    float scale = 15.0;
    float spd = 1;
    float initphase = radians(random(360));
    star[i]= new Star(x, y, scale, rot, spd);
  }
}

void draw() {
  
    background(0);
    //if (spin) {
      for (int i = 0; i < 150; i++) {
        star[i].update();
      }
    //}
    if (roll) {
    randomNumber = int(random(names.size()));
    fill(255);
    name = names.get(randomNumber);
    text(name, width/2, height/2);
    delay(10);
  }
  else{
    text(name, width/2, height/2);
  } 
}

void keyPressed() {
  if (key == ' ') {
    println("STOP");
    roll = false;
    spin = true;
    if (names.size()-1 >0) {
      names.remove(randomNumber);
      previous = true;
    } else {
      background(0);
      text("That's all folks!", width/2, height/2);
      roll = false;
      ending = true;
    }
  }
  if (key == ENTER || key == RETURN) {
    println("START");
    roll = true;
    spin = false;
    if (ending == true ) {
      exit();
    }
  }
}

void loadNames() {
  String[] lines = loadStrings("names.txt");
  for (int i = 0; i < lines.length; i++) {
    names.append(lines[i]);
  }
}

class Star { 

  float xpos, ypos, scale, rot, speed, brightness, angle, initphase; 
  boolean dir;
  int counter = 0;
  Star (float x, float y, float b, float r, float v) {  
    xpos = x;
    ypos = y; 
    scale = random(b);
    rot = r; 
    speed = v;
    brightness = random(255);
    initphase = radians(random(360));
  } 

  void update() { 

    counter=counter+5;
    angle = radians(counter%360);

    if (brightness >= 255) {
      dir = true;
    }
    if (brightness <= 0) {
      dir = false;
    }
    if (!dir) {
      brightness = brightness+5;
    }
    if (dir) {
      brightness = brightness-5;
    }
    fill(brightness);
    //triangle(xpos+(0*scale), ypos+(1*scale), xpos+(0.866*scale), ypos-(0.5*scale), xpos-(0.866*scale), ypos-(0.5*scale));
    triangle(xpos+(sin(angle+initphase)*scale), ypos+(cos(angle+initphase)*scale), xpos+(sin(angle+initphase+radians(120))*scale), ypos+(cos(angle+initphase+radians(120))*scale), xpos+(sin(angle+initphase+radians(240))*scale), ypos+(cos(angle+initphase+radians(240))*scale));
  }
} 