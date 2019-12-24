class GameCharacter{
	int condition;

	Player playerWhite = new Player(keyInputWhite);
	Enemy playerBlack = new Enemy(keyInputBlack);

	GameCharacter(){
		playerWhite.setOriginPosition();
		playerBlack.setOriginPosition();
	}

	void setPlayerWhiteControl(JSONObject control){
		playerWhite.setMoveDeltaX(control.getFloat("lx"));
	    playerWhite.setMoveDeltaY(control.getFloat("ly"));
	    //control.getBoolean(l)
	    playerWhite.setStrongShotBtn(control.getBoolean("zl"));
	    if(control.getBoolean("zl")){
			keyInputWhite.xPressed = true;
		}
	    else{
	    	keyInputWhite.xPressed = false;
	    }
	    playerWhite.setAimDeltaX(control.getFloat("rx"));
	    playerWhite.setAimDeltaY(control.getFloat("ry"));
	    //control.getBoolean(r);
	  	playerWhite.setWeakShotBtn(control.getBoolean("zr"));
	  	if(control.getBoolean("zr")){
	  		keyInputWhite.zPressed = true;
	  	}
	  	else{
	  		keyInputWhite.zPressed = false;
	  	}
	}
	void setPlayerBlackControl(JSONObject control){
		playerBlack.setMoveDeltaX(control.getFloat("lx"));
	    playerBlack.setMoveDeltaY(control.getFloat("ly"));
	    //control.getBoolean(l)
	    //playerBlack.setStrongShotBtn(control.getBoolean("zl"));
	    if(control.getBoolean("zl")){
			keyInputBlack.xPressed = true;
		}
	    else{
	    	keyInputBlack.xPressed = false;
	    }
	    playerBlack.setAimDeltaX(control.getFloat("rx"));
	    playerBlack.setAimDeltaY(control.getFloat("ry"));
	    //control.getBoolean(r);
	  	//playerBlack.setWeakShotBtn(control.getBoolean("zr"));
	  	if(control.getBoolean("zr")){
	  		keyInputBlack.zPressed = true;
	  	}
	  	else{
	  		keyInputBlack.zPressed = false;
	  	}
	}
	// void sendMovement(){
	// 	playerBlackPort.write(playerBlack.sendString);
	// 	if(playerBlack.sendString.getBoolean(l) || playerBlack.sendString.getBoolean(r)){
	// 		playerBlack.sendString.setBoolean("l", false);
	// 		playerBlack.sendString.setBoolean("r", false);
	// 	}
	// 	playerWhitePort.write(playerWhite.sendString);
	// 	if(playerWhite.sendString.getBoolean(l) || playerWhite.sendString.getBoolean(r)){
	// 		playerWhite.sendString.setBoolean("l", false);
	// 		playerWhite.sendString.setBoolean("r", false);
	// 	}
	// }

	void setStartPosition(){
		playerWhite.setOriginPosition();
		playerBlack.setOriginPosition();
	}
	void updatePlayerWhite(){
		playerWhite.update();
		playerWhite.addWeakShot(playerBlack);
		playerWhite.addStrongShot(playerBlack);
		playerWhite.checkInjury(playerBlack);
	}
	void updatePlayerBlack(){
		playerBlack.update();
		playerBlack.addWeakShot(playerWhite);
		playerBlack.addStrongShot(playerWhite);
		playerBlack.checkInjury(playerWhite);
	}
	void displayShow(){
		playerWhite.updateRotatingRate();
		playerWhite.display();
		playerBlack.updateRotatingRate();
		playerBlack.display();
	}
	void display(){
		if(playerBlack.strongShotState){
			condition = 5;
			gameStart = false;
			playerWhite.updateRotatingRate();
			playerWhite.display();
		}
		else if(playerWhite.strongShotState){
			condition = 6;
			gameStart = false;
			playerBlack.updateRotatingRate();
			playerBlack.display();
		}
	}
	void run(){
		if(playerBlack.strongShotState || playerWhite.strongShotState){
			gameStart = false;
		}
		else{
			updatePlayerWhite();
			playerWhite.display();
			playerWhite.weakWeaponDisplay(playerBlack);
			updatePlayerBlack();
			playerBlack.display();
			playerBlack.weakWeaponDisplay(playerWhite);
		}
		
	}
}