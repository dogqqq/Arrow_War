void keyPressed() {
  if (key != CODED) {
    if (key == 'x' || key == 'X') {
      keyInput.xPressed = true;
      return;
    }
    //playerWhite
    if (key == 'w' || key == 'W') {
      keyInputWhite.upPressed = true;
      return;
    }
    if (key == 's' || key == 'S') {
      keyInputWhite.downPressed = true;
      return;
    }
    if (key == 'a' || key == 'A') {
      keyInputWhite.leftPressed = true;
      return;
    }
    if (key == 'd' || key == 'D') {
      keyInputWhite.rightPressed = true;
      return;
    }
    if (key == 'q' || key == 'Q') {
      keyInputWhite.zPressed = true;
      return;
    }
    if (key == 'e' || key == 'E') {
      keyInputWhite.xPressed = true;
      return;
    }
    //playerBlack
    if (key == 'i' || key == 'I') {
      keyInputBlack.upPressed = true;
      return;
    }
    if (key == 'j' || key == 'J') {
      keyInputBlack.leftPressed = true;
      return;
    }
    if (key == 'l' || key == 'L') {
      keyInputBlack.rightPressed = true;
      return;
    }
    if (key == 'k' || key == 'K') {
      keyInputBlack.downPressed = true;
      return;
    }
    if (key == 'u' || key == 'U') {
      keyInputBlack.zPressed = true;
      return;
    }
    if (key == 'o' || key == 'O') {
      keyInputBlack.xPressed = true;
      return;
    }
    return;
  }
  // if(key == CODED){
  //   if(keyCode == UP){
  //     keyInput.upPressed = true;
  //     return;
  //   }
  //   if (keyCode == DOWN) {
  //     keyInput.downPressed = true;
  //     return;    
  //   }
  //   if (keyCode == RIGHT) {
  //     keyInput.rightPressed = true;
  //     return;
  //   }
  //   if (keyCode == LEFT) {
  //     keyInput.leftPressed = true;
  //     return; 
  //   }
  // }
}
void keyReleased() {
  if (key != CODED) {
    if (key == 'x' || key == 'X') {
      keyInput.xPressed = false;
      return;
    }
    //playerWhite
    if (key == 'w' || key == 'W') {
      keyInputWhite.upPressed = false;
      return;
    }
    if (key == 's' || key == 'S') {
      keyInputWhite.downPressed = false;
      return;
    }
    if (key == 'a' || key == 'A') {
      keyInputWhite.leftPressed = false;
      return;
    }
    if (key == 'd' || key == 'D') {
      keyInputWhite.rightPressed = false;
      return;
    }
    if (key == 'q' || key == 'Q') {
      keyInputWhite.zPressed = false;
      return;
    }
    if (key == 'e' || key == 'E') {
      keyInputWhite.xPressed = false;
      return;
    }
    //playerBlack
    if (key == 'i' || key == 'I') {
      keyInputBlack.upPressed = false;
      return;
    }
    if (key == 'j' || key == 'J') {
      keyInputBlack.leftPressed = false;
      return;
    }
    if (key == 'l' || key == 'L') {
      keyInputBlack.rightPressed = false;
      return;
    }
    if (key == 'k' || key == 'K') {
      keyInputBlack.downPressed = false;
      return;
    }
    if (key == 'u' || key == 'U') {
      keyInputBlack.zPressed = false;
      return;
    }
    if (key == 'o' || key == 'O') {
      keyInputBlack.xPressed = false;
      return;
    }
    return;
  }
  // if(key == CODED){
  //   if(keyCode == UP){
  //     keyInput.upPressed = false;
  //     return;
  //   }
  //   if (keyCode == DOWN) {
  //     keyInput.downPressed = false;
  //     return;    
  //   }
  //   if (keyCode == RIGHT) {
  //     keyInput.rightPressed = false;
  //     return;
  //   }
  //   if (keyCode == LEFT) {
  //     keyInput.leftPressed = false;
  //     return; 
  //   }
  // }
}
class KeyInput {
  boolean upPressed = false;
  boolean downPressed = false;
  boolean leftPressed = false;
  boolean rightPressed = false;
  boolean zPressed = false;
  boolean xPressed = false;
}
