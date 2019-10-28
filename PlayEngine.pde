class GameCharacter{
	// Player player = new Player();
	// Enemy enemy = new Enemy();
	Player player1 = new Player(keyInput1);
	Enemy player2 = new Enemy(keyInput2);

	GameCharacter(){
		// player.setOriginPosition();
		// enemy.setOriginPosition();
		player1.setOriginPosition();
		player2.setOriginPosition();
	}

	void updatePlayer1(){
		player1.update();
		player1.addWeakShot(player2);
		player1.addStrongShot(player2);
		player1.checkInjury(player2);
	}
	// void updatePlayer(){
	// 	player.update();
	// 	player.addWeakShot(enemy);
	// 	player.addStrongShot(enemy);
	// }
	void updatePlayer2(){
		player2.update();
		player2.addWeakShot(player1);
		player2.addStrongShot(player1);
		player2.checkInjury(player1);
	}
	// void updateEnemy(){
	// 	enemy.updateRotatingRate();
	// 	enemy.checkInjury(player);
	// }
	// void run(){
	// 	if(gameStart){
	// 		updatePlayer();
	// 		player.display();
	// 		updateEnemy();
	// 		enemy.display();
	// 	}
	// 	else{
	// 		player.display();
	// 		enemy.display();
	// 	}
	// }
	void run(){
		if(player2.strongShotState){
			gameStart = false;
			player1.display();
		}
		else if(player1.strongShotState){
			gameStart = false;
			player2.display();
		}
		else{
			updatePlayer1();
			player1.display();
			player1.weakWeaponDisplay(player2);
			updatePlayer2();
			player2.display();
			player2.weakWeaponDisplay(player1);
		}
		
	}
	// void run(){
	// 	updatePlayer();
	// 	player.display();
	// 	player.weakWeaponDisplay(enemy);
	// 	updateEnemy();
	// 	enemy.display();
	// }
}
// class Game{
// 	GameCharacter gamecharacter = new GameCharacter();

// 	void run(){
// 		if
// 		gameCharacter.run();
// 	}
// }