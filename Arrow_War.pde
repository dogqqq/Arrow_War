boolean gameStart = false, laugh = false;
int condition;
int time;
PFont tFont;
KeyInput keyInput = new KeyInput();
KeyInput keyInputWhite = new KeyInput();
KeyInput keyInputBlack = new KeyInput();
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
  println("time: ", + time);
  println("second(): " + second());
  if(!gameStart && keyInput.xPressed && (second() - time >= 1 || second() - time >= -59 && second() - time < 0) ){
    time = second();
    condition ++ ;
    if(condition == 4){
      laugh = true;
    }
    else{
      laugh = false;
    }
    if(condition == 5){
      gameCharacter = new GameCharacter();
      condition = 0;
    }
    //delay(200);
  }
  else if(condition == 0 && !gameStart){
    gameCharacter.displayShow();
    welcomeMessage.displayTitle();
  }
  else if(condition == 1 && !gameStart){
    gameCharacter.displayShow();
    welcomeMessage.displayRule();
  }
  else if(condition == 2 && !gameStart){
    condition ++;
    gameStart = true;
  }
  else if((gameCharacter.playerBlack.strongShotState || gameCharacter.playerWhite.strongShotState) && !laugh && !gameStart){
    gameCharacter.display();
    outcomeMessage = new OutcomeMessage(gameCharacter.condition);
    outcomeMessage.display();
  }
  else if(condition == 4 && !gameStart){
    gameCharacter.display();
    outcomeMessage.displayLaugh();
  }
  else if(gameStart){
    gameCharacter.run();
  }

}
