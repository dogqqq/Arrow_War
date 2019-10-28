void keyPressed() {
  if (key != CODED) {
    // if (key == 'z' || key == 'Z') {
    //   keyInput.zPressed = true;
    //   return;
    // }
    if (key == 'x' || key == 'X') {
      keyInput.xPressed = true;
      return;
    }
    //player1
    if (key == 'w' || key == 'W') {
      keyInput1.upPressed = true;
      return;
    }
    if (key == 's' || key == 'S') {
      keyInput1.downPressed = true;
      return;
    }
    if (key == 'a' || key == 'A') {
      keyInput1.leftPressed = true;
      return;
    }
    if (key == 'd' || key == 'D') {
      keyInput1.rightPressed = true;
      return;
    }
    if (key == 'q' || key == 'Q') {
      keyInput1.zPressed = true;
      return;
    }
    if (key == 'e' || key == 'E') {
      keyInput1.xPressed = true;
      return;
    }
    //player2
    if (key == 'i' || key == 'I') {
      keyInput2.upPressed = true;
      return;
    }
    if (key == 'j' || key == 'J') {
      keyInput2.leftPressed = true;
      return;
    }
    if (key == 'l' || key == 'L') {
      keyInput2.rightPressed = true;
      return;
    }
    if (key == 'k' || key == 'K') {
      keyInput2.downPressed = true;
      return;
    }
    if (key == 'u' || key == 'U') {
      keyInput2.zPressed = true;
      return;
    }
    if (key == 'o' || key == 'O') {
      keyInput2.xPressed = true;
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
    // if (key == 'z' || key == 'Z') {
    //   keyInput.zPressed = false;
    //   return;
    // }
    if (key == 'x' || key == 'X') {
      keyInput.xPressed = false;
      return;
    }
    //player1
    if (key == 'w' || key == 'W') {
      keyInput1.upPressed = false;
      return;
    }
    if (key == 's' || key == 'S') {
      keyInput1.downPressed = false;
      return;
    }
    if (key == 'a' || key == 'A') {
      keyInput1.leftPressed = false;
      return;
    }
    if (key == 'd' || key == 'D') {
      keyInput1.rightPressed = false;
      return;
    }
    if (key == 'q' || key == 'Q') {
      keyInput1.zPressed = false;
      return;
    }
    if (key == 'e' || key == 'E') {
      keyInput1.xPressed = false;
      return;
    }
    //player2
    if (key == 'i' || key == 'I') {
      keyInput2.upPressed = false;
      return;
    }
    if (key == 'j' || key == 'J') {
      keyInput2.leftPressed = false;
      return;
    }
    if (key == 'l' || key == 'L') {
      keyInput2.rightPressed = false;
      return;
    }
    if (key == 'k' || key == 'K') {
      keyInput2.downPressed = false;
      return;
    }
    if (key == 'u' || key == 'U') {
      keyInput2.zPressed = false;
      return;
    }
    if (key == 'o' || key == 'O') {
      keyInput2.xPressed = false;
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
