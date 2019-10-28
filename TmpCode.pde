// abstract class Character extends Information{
	// ArrayList<WeakArrow> weakArrowArr = new ArrayList<WeakArrow>();
	// WeakArrow weakArrowTmp = new WeakArrow();
	// StrongArrow strongArrow = new StrongArrow();
	// KeyInput keyInput = new KeyInput();
	// Character(KeyInput _keyInput){
	// 	keyInput = _keyInput; 
	// }

	// float rotatingRate, rotatingAddRate;
	// float rotateScalar = 0.015;
	// float accelarationAddRate = 0.3;
	// float accelarationBound = 1.0;
	// float velocityBound;
	// int arrowNum;
	// boolean strongArrowAdded = false;
	// int weakInjuryTime, strongInjuryTime, time;

	// void updateAccelaration(){
	// 	if (keyInput.upPressed && yAccelaration >= -accelarationBound) {
	// 		yAccelaration -= accelarationAddRate;
	// 	}
	// 	if (keyInput.downPressed && yAccelaration <= accelarationBound) {
	// 		yAccelaration += accelarationAddRate;
	// 	}
	// 	if(keyInput.rightPressed && xAccelaration <= accelarationBound){
	// 		xAccelaration += accelarationAddRate;
	// 	}
	// 	if(keyInput.leftPressed && xAccelaration >= -accelarationBound){
	// 		xAccelaration -= accelarationAddRate;				
	// 	}
	// 	if(noDirectionPressed()){
	// 		xAccelaration = 0;
	// 		yAccelaration = 0;
	// 	}
	// }
	// void updateVelocity(StrongArrow strongArrow){
	// 	if(isWeakShot()){
	// 		velocityBound = 2;
	// 	}
	// 	else if(isStrongShot() && strongArrow.arrowControl){
	// 		velocityBound = 0.5;
	// 	}
	// 	else{
	// 		velocityBound = 5;
	// 	}
	// 	if(xVelocity >= -velocityBound && xVelocity <= velocityBound){
	// 		xVelocity += xAccelaration;
	// 	}
	// 	if(yVelocity >= -velocityBound && yVelocity <= velocityBound){
	// 		yVelocity += yAccelaration;
	// 	}
	// 	xVelocity = xVelocity > velocityBound ? velocityBound : xVelocity;
	// 	xVelocity = xVelocity < -velocityBound ? -velocityBound : xVelocity;
	// 	yVelocity = yVelocity < -velocityBound ? -velocityBound : yVelocity;
	// 	yVelocity = yVelocity > velocityBound ? velocityBound : yVelocity;
	// 	if(noDirectionPressed()){
	// 		xVelocity /= 1.15;
	// 		yVelocity /= 1.15;
	// 	}
	// }
	// void updatePosition(){
	// 	if (xPosition >= 0 && xPosition <= width){
	// 		xPosition += xVelocity;
	// 	}
	// 	if (yPosition >= 0 && yPosition <= height){
	// 		yPosition += yVelocity;
	// 	}
	// 	xPosition = xPosition < 0 ? 0 : xPosition;
	// 	xPosition = xPosition > width ? width : xPosition;
	// 	yPosition = yPosition < 0 ? 0 : yPosition;
	// 	yPosition = yPosition > height ? height : yPosition;

	// }

	// void updateRotatingRate(){
	// 	if(!noDirectionPressed()){
	// 		if(isWeakShot()){
	// 			if(rotatingAddRate <= PI/60){
	// 				rotatingAddRate += PI/1500;
	// 			}
	// 			rotatingAddRate = rotatingAddRate > PI/60 ? PI/60 : rotatingAddRate;
	// 		}
	// 		else if (isStrongShot()) {
	// 			if(rotatingAddRate <= PI/120){
	// 				rotatingAddRate += PI/1500;
	// 			}
	// 			rotatingAddRate = rotatingAddRate > PI/120 ? PI/120 : rotatingAddRate;
	// 		}
	// 		else{
	// 			if(rotatingAddRate <= PI/25){
	// 				rotatingAddRate += PI/1500;
	// 			}
	// 		}	
	// 	}
	// 	rotatingRate += rotatingAddRate;
	// 	rotatingRate = rotatingRate >= PI ? 0 : rotatingRate;
	// 	rotatingRate += rotateScalar;
	// 	if(noDirectionPressed()){
	// 		rotatingAddRate /= 1.5;
	// 	}
	// }
	
	// void checkInjury(Character enemy){
	// 	println("strongShotState: "+strongShotState);
	// 	println("time: "+time);
	// 	time = second();
	// 	if(!weakShotState){
	// 		for (WeakArrow arrow : enemy.weakArrowArr) {
	// 			if(arrow.xPosition + arrow.arrowSize*cos(arrow.aimAngle) >= xPosition - 35 &&
	// 				arrow.xPosition + arrow.arrowSize*cos(arrow.aimAngle) <= xPosition + 35 &&
	// 				arrow.yPosition + arrow.arrowSize*sin(arrow.aimAngle) >= yPosition - 35 &&
	// 				arrow.yPosition + arrow.arrowSize*sin(arrow.aimAngle) <= yPosition + 35){
	// 				weakShotState = true;
	// 				weakInjuryTime = second();
	// 				break;
	// 			}
	// 		}
	// 	}
	// 	if(time - weakInjuryTime == 1 || time - weakInjuryTime == -59){		//59, 00
	// 		weakShotState = false;
	// 	}
	// 	if(!strongShotState){
	// 		if(enemy.strongArrow.xPosition + enemy.strongArrow.arrowSize*cos(enemy.strongArrow.aimAngle) >= xPosition - 35 &&
	// 			enemy.strongArrow.xPosition + enemy.strongArrow.arrowSize*cos(enemy.strongArrow.aimAngle) <= xPosition + 35 &&
	// 			enemy.strongArrow.yPosition + enemy.strongArrow.arrowSize*sin(enemy.strongArrow.aimAngle) >= xPosition - 35	&&
	// 			enemy.strongArrow.yPosition + enemy.strongArrow.arrowSize*sin(enemy.strongArrow.aimAngle) <= xPosition + 35){
	// 			strongShotState = true;
	// 		}
	// 	}
	// }

	// boolean noDirectionPressed(){
	// 	if(!keyInput.upPressed && !keyInput.rightPressed && !keyInput.downPressed && !keyInput.leftPressed)
	// 		return true;
	// 	return false;
	// }
	// boolean isWeakShot(){
	// 	if (keyInput.zPressed && !keyInput.xPressed) {
	// 		return true;
	// 	}
	// 	return false;
	// }
	// boolean isStrongShot(){
	// 	if(keyInput.xPressed && !keyInput.zPressed){
	// 		return true;
	// 	}
	// 	return false;
	// }
	// void update(){
	// 	updateAccelaration();
	// 	updateVelocity(strongArrow);
	// 	updatePosition();
	// 	updateRotatingRate();
	// }
// 	abstract void setOriginPosition();
// 	abstract void display();
// }