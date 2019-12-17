class GameCharacter{
	int condition;

	Player playerWhite = new Player(keyInputWhite);
	Enemy playerBlack = new Enemy(keyInputBlack);

	GameCharacter(){
		playerWhite.setOriginPosition();
		playerBlack.setOriginPosition();
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