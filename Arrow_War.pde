boolean gameStart = false;
PFont tFont;
KeyInput keyInput = new KeyInput();
GameCharacter gameCharacter = new GameCharacter();
GameBackground gameBackground = new GameBackground();
WeakArrow weakArrow = new WeakArrow();
StrongArrow strongArrow = new StrongArrow();
// TitleMessage titleMessage = new TitleMessage();
// RuleMessage ruleMessage = new RuleMessage();
// LoseMessage loseMessage = new LoseMessage();
// VictoryMessage victoryMessage = new VictoryMessage();

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
  //weakArrow.display();
  //strongArrow.display();
  //victoryMessage.display();
  // loseMessage.display();
  // if(key == 'x'){
  //   loseMessage.displayLaugh(loseMessage);
  // }
  //ruleMessage.display();
  //titleMessage.display();
  //text("HI", width/2, height/2);
}

void keyPressed() {
  if (key != CODED) {
    if (key == 'z' || key == 'Z') {
      keyInput.zPressed = true;
      return;
    }
    if (key == 'x' || key == 'X') {
      keyInput.xPressed = true;
      return;
    }
    return;
  }
  if(key == CODED){
    if(keyCode == UP){
      keyInput.upPressed = true;
      return;
    }
    if (keyCode == DOWN) {
      keyInput.downPressed = true;
      return;    
    }
    if (keyCode == RIGHT) {
      keyInput.rightPressed = true;
      return;
    }
    if (keyCode == LEFT) {
      keyInput.leftPressed = true;
      return; 
    }
  }
}
void keyReleased() {
  if (key != CODED) {
    if (key == 'z' || key == 'Z') {
      keyInput.zPressed = false;
      return;
    }
    if (key == 'x' || key == 'X') {
      keyInput.xPressed = false;
      return;
    }
    return;
  }
  if(key == CODED){
    if(keyCode == UP){
      keyInput.upPressed = false;
      return;
    }
    if (keyCode == DOWN) {
      keyInput.downPressed = false;
      return;    
    }
    if (keyCode == RIGHT) {
      keyInput.rightPressed = false;
      return;
    }
    if (keyCode == LEFT) {
      keyInput.leftPressed = false;
      return; 
    }
  }
}
class KeyInput {
  boolean upPressed = false;
  boolean downPressed = false;
  boolean leftPressed = false;
  boolean rightPressed = false;
  boolean zPressed = false;
  boolean xPressed = false;
}