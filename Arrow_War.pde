boolean gameStart = false;
PFont tFont;
KeyInput keyInput = new KeyInput();
KeyInput keyInput1 = new KeyInput();
KeyInput keyInput2 = new KeyInput();
GameCharacter gameCharacter = new GameCharacter();
GameBackground gameBackground = new GameBackground();


void setup(){
  size(700, 800);
  background(255);
  smooth();
  frameRate(100);
  tFont = createFont("Lato-Regular.ttf", 96.0, true);
  textFont(tFont, 96.0);
  textAlign(CENTER, CENTER);
  rectMode(CENTER);
  ellipseMode(CENTER);
}

void draw(){
  gameBackground.run();
  gameCharacter.run();
}