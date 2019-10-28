boolean gameStart = false;
int condition = 0;
PFont tFont;
KeyInput keyInput = new KeyInput();
KeyInput keyInput1 = new KeyInput();
KeyInput keyInput2 = new KeyInput();
GameCharacter gameCharacter = new GameCharacter();
GameBackground gameBackground = new GameBackground();
WelcomeMessage welcomeMessage = new WelcomeMessage();
OutcomeMessage outcomeMessage;

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
  if(!gameStart && keyInput.xPressed){
    condition ++ ;
    delay(100);
  }
  if(condition == 0 && !gameStart){
    welcomeMessage.displayTitle();
  }
  if(condition == 1 && !gameStart){
    welcomeMessage.displayRule();
  }
  if(condition == 2 && !gameStart){
    gameStart = true;
  }
  else if(!gameStart){
    gameCharacter.display();
  }
  else if(gameStart){
    gameCharacter.run();
  }

}