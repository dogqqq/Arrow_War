class GameCharacter{
	int condition;

	Player playerWhite = new Player(keyInputWhite);
	Enemy playerBlack = new Enemy(keyInputBlack);

	GameCharacter(){
		playerWhite.setOriginPosition();
		playerBlack.setOriginPosition();
	}

	void setPlayerWhiteControl(JSONObject control){
		playerWhite.setMoveDeltaX(json.getFloat(lx));
	    playerWhite.setMoveDeltaY(json.getFloat(ly));
	    //json.getBoolean(l)
	    playerWhite.setStrongShotBtn(json.getBoolean(zl));
	    playerWhite.setAimDeltaX(json.getFloat(rx));
	    playerWhite.setAimDeltaY(json.getFloat(ry));
	    //json.getBoolean(r);
	  	playerWhite.setWeakShotBtn(json.getBoolean(zr));
	}
	void setPlayerBlackControl(JSONObject control){
		playerBlack.setMoveDeltaX(json.getFloat(lx));
	    playerBlack.setMoveDeltaY(json.getFloat(ly));
	    //json.getBoolean(l)
	    playerBlack.setStrongShotBtn(json.getBoolean(zl));
	    playerBlack.setAimDeltaX(json.getFloat(rx));
	    playerBlack.setAimDeltaY(json.getFloat(ry));
	    //json.getBoolean(r);
	  	playerBlack.setWeakShotBtn(json.getBoolean(zr));
	}
	void sendMovement(){
		playerBlackPort.write(playerBlack.sendJson);
		if(playerBlack.sendJson.getBoolean(l) || playerBlack.sendJson.getBoolean(r)){
			playerBlack.sendJson.setBoolean("l", false);
			playerBlack.sendJson.setBoolean("r", false);
		}
		playerWhitePort.write(playerWhite.sendJson);
		if(playerWhite.sendJson.getBoolean(l) || playerWhite.sendJson.getBoolean(r)){
			playerWhite.sendJson.setBoolean("l", false);
			playerWhite.sendJson.setBoolean("r", false);
		}
	}

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