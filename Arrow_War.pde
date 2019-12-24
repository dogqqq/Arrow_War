import processing.serial.*;

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

int lf = 10;
Serial playerWhitePort, playerBlackPort;
String playerWhiteString = null, playerBlackString = null;
JSONObject json;
StringBuilder strTrue = new StringBuilder("true");
StringBuilder strFalse = new StringBuilder("false");
StringBuilder str1 = new StringBuilder("{\"l\":");
StringBuilder str2 = new StringBuilder(",\"r\":");
StringBuilder str3 = new StringBuilder("}");

void setup(){
  size(700, 800);
  background(255);
  smooth();
  frameRate(100);
  tFont = createFont("Lato-Regular.ttf", 96.0, true);
  textFont(tFont, 96.0);

  playerWhitePort = new Serial(this, "COM7", 38400);  //unchecked port
  playerBlackPort = new Serial(this, "COM8", 38400);  //unchecked port
  playerWhitePort.clear();
  playerBlackPort.clear();

  textAlign(CENTER, CENTER);
  rectMode(CENTER);
  ellipseMode(CENTER);
}

void draw(){
  gameBackground.run();

  if( playerWhitePort.available() > 0) {
    playerWhiteString = playerWhitePort.readStringUntil(lf);
    if (playerWhiteString != null) {
      try{
        json = parseJSONObject(playerWhiteString);
        //println("White: "+json);
        gameCharacter.setPlayerWhiteControl(json);
      }catch (RuntimeException e) {
        
      }
    }
  }
  if( playerBlackPort.available() > 0) {
    playerBlackString = playerBlackPort.readStringUntil(lf);
    if (playerBlackString != null) {
      try{
        json = parseJSONObject(playerBlackString);
        //println("Black: "+json);
        gameCharacter.setPlayerBlackControl(json);
      }catch(RuntimeException e){

      }
    }
  }
  //gameCharacter.sendMovement();

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
    delay(1000);
  }
  // else if(condition == 4 && !gameStart){
  //   gameCharacter.display();
  //   outcomeMessage.displayLaugh();
  // }
  else if(gameStart){
    gameCharacter.run();
  }

}
