
class Enemy extends Character{
	ArrayList<WeakArrow> weakArrowArr = new ArrayList<WeakArrow>();
	WeakArrow weakArrowTmp = new WeakArrow(keyInput2);
	StrongArrow strongArrow = new StrongArrow(keyInput2);
	KeyInput keyInput = new KeyInput();
	Enemy(KeyInput _keyInput){
		keyInput = _keyInput; 
	}
	void reset(){
		xAccelaration = 0;
		yAccelaration = 0;
		xVelocity = 0;
		yVelocity = 0;
		rotatingAddRate = 0;
	}

	void updateAccelaration(){
		if (keyInput.upPressed && yAccelaration >= -accelarationBound) {
			yAccelaration -= accelarationAddRate;
		}
		if (keyInput.downPressed && yAccelaration <= accelarationBound) {
			yAccelaration += accelarationAddRate;
		}
		if(keyInput.rightPressed && xAccelaration <= accelarationBound){
			xAccelaration += accelarationAddRate;
		}
		if(keyInput.leftPressed && xAccelaration >= -accelarationBound){
			xAccelaration -= accelarationAddRate;				
		}
		if(noDirectionPressed()){
			xAccelaration = 0;
			yAccelaration = 0;
		}
	}
	void updateVelocity(StrongArrow strongArrow){
		if(isWeakShot()){
			velocityBound = 2;
		}
		else if(isStrongShot() && strongArrow.arrowControl){
			velocityBound = 0.5;
		}
		else{
			velocityBound = 5;
		}
		if(xVelocity >= -velocityBound && xVelocity <= velocityBound){
			xVelocity += xAccelaration;
		}
		if(yVelocity >= -velocityBound && yVelocity <= velocityBound){
			yVelocity += yAccelaration;
		}
		xVelocity = xVelocity > velocityBound ? velocityBound : xVelocity;
		xVelocity = xVelocity < -velocityBound ? -velocityBound : xVelocity;
		yVelocity = yVelocity < -velocityBound ? -velocityBound : yVelocity;
		yVelocity = yVelocity > velocityBound ? velocityBound : yVelocity;
		if(noDirectionPressed()){
			xVelocity /= 1.15;
			yVelocity /= 1.15;
		}
	}
	void updatePosition(){
		if (xPosition >= 0 && xPosition <= width){
			xPosition += xVelocity;
		}
		if (yPosition >= 0 && yPosition <= height){
			yPosition += yVelocity;
		}
		xPosition = xPosition < 0 ? 0 : xPosition;
		xPosition = xPosition > width ? width : xPosition;
		yPosition = yPosition < 0 ? 0 : yPosition;
		yPosition = yPosition > height ? height : yPosition;

	}

	void updateRotatingRate(){
		if(!noDirectionPressed()){
			if(isWeakShot()){
				if(rotatingAddRate <= PI/60){
					rotatingAddRate += PI/1500;
				}
				rotatingAddRate = rotatingAddRate > PI/60 ? PI/60 : rotatingAddRate;
			}
			else if (isStrongShot()) {
				if(rotatingAddRate <= PI/120){
					rotatingAddRate += PI/1500;
				}
				rotatingAddRate = rotatingAddRate > PI/120 ? PI/120 : rotatingAddRate;
			}
			else{
				if(rotatingAddRate <= PI/25){
					rotatingAddRate += PI/1500;
				}
			}	
		}
		rotatingRate += rotatingAddRate;
		rotatingRate = rotatingRate >= PI ? 0 : rotatingRate;
		rotatingRate += rotateScalar;
		if(noDirectionPressed()){
			rotatingAddRate /= 1.5;
		}
	}
	
	void checkInjury(Player enemy){
		println("EstrongShotState: "+strongShotState);
		println("enemy.strongArrow.xPosition: "+enemy.strongArrow.xPosition);
		println("enemy.strongArrow.yPosition: "+enemy.strongArrow.yPosition);
		println("time: "+time);
		time = second();
		if(!weakShotState){
			for (WeakArrow arrow : enemy.weakArrowArr) {
				if(arrow.xPosition + arrow.arrowSize*cos(arrow.aimAngle) >= xPosition - 35 &&
					arrow.xPosition + arrow.arrowSize*cos(arrow.aimAngle) <= xPosition + 35 &&
					arrow.yPosition + arrow.arrowSize*sin(arrow.aimAngle) >= yPosition - 35 &&
					arrow.yPosition + arrow.arrowSize*sin(arrow.aimAngle) <= yPosition + 35){
					weakShotState = true;
					weakInjuryTime = second();
					break;
				}
			}
		}
		if(time - weakInjuryTime == 1 || time - weakInjuryTime == -59){		//59, 00
			weakShotState = false;
		}
		if(enemy.strongArrow.xPosition + enemy.strongArrow.arrowSize*cos(enemy.strongArrow.aimAngle) >= xPosition - 40 &&
			enemy.strongArrow.xPosition + enemy.strongArrow.arrowSize*cos(enemy.strongArrow.aimAngle) <= xPosition + 40 &&
			enemy.strongArrow.yPosition + enemy.strongArrow.arrowSize*sin(enemy.strongArrow.aimAngle) >= yPosition - 40	&&
			enemy.strongArrow.yPosition + enemy.strongArrow.arrowSize*sin(enemy.strongArrow.aimAngle) <= yPosition + 40 &&
			!enemy.strongArrow.arrowControl){
			strongShotState = true;
		}
	}

	boolean noDirectionPressed(){
		if(!keyInput.upPressed && !keyInput.rightPressed && !keyInput.downPressed && !keyInput.leftPressed)
			return true;
		return false;
	}
	boolean isWeakShot(){
		if (keyInput.zPressed && !keyInput.xPressed) {
			return true;
		}
		return false;
	}
	boolean isStrongShot(){
		if(keyInput.xPressed && !keyInput.zPressed){
			return true;
		}
		return false;
	}
	void update(){
		if(weakShotState){
			reset();
		}
		updateAccelaration();
		updateVelocity(strongArrow);
		updatePosition();
		updateRotatingRate();
	}
	///////////////////////////////////////////////

	void setOriginPosition(){
		xPosition = 700/2;
		yPosition = 800*1/6;
	}
	// void updateRotatingRate(){
	// 	rotatingRate += rotatingAddRate;
	// 	if(rotatingRate >= PI){
	// 		rotatingRate = 0;
	// 	}
	// 	rotatingRate += rotateScalar;
	// }
	void display(){
		if(weakShotState){
			injuryDisplay();
			for (WeakArrow arrow : weakArrowArr) {
				arrow.update();
				arrow.display();
			}
			strongArrow.update();
			if(strongArrowAdded){
				strongArrow.display();
			}
		}
		else{
			pushMatrix();
			translate(xPosition, yPosition);
			pushMatrix();
			rotate(rotatingRate);
			pushStyle();
			fill(0);
			rect(0, 0, 35, 35);	
			popStyle();
			popMatrix();
			popMatrix();
			for (WeakArrow arrow : weakArrowArr) {
				arrow.update();
				arrow.display();
			}
			strongArrow.update();
			if(strongArrowAdded){
				strongArrow.display();
			}
		}	
	}
	void injuryDisplay(){
		pushMatrix();
		translate(xPosition, yPosition);
		pushMatrix();
		rotate(rotatingRate);
		pushStyle();
		fill(0);
		rect(0, 0, 35, 35);	
		stroke(255, 0, 0);
		noFill();
		arc(0, 0, 75, 75, 0, TWO_PI);
		popStyle();
		popMatrix();
		popMatrix();
	}
	/////////////////////////////////////////////////////
	void updateWeakArrow(){
		if (arrowNum == 10){
			weakArrowArr.remove(0);
		}
	}
	void addWeakShot(Character enemy){
		updateWeakArrow();
		arrowNum = weakArrowArr.size();
		if(arrowNum != 0){
			weakArrowTmp = weakArrowArr.get(arrowNum - 1);
			if (isWeakShot() && dist(weakArrowTmp.xPosition, weakArrowTmp.yPosition, xPosition, yPosition) >= 125 && !weakShotState){
				weakArrowArr.add(new WeakArrow(keyInput));
				weakArrowTmp = weakArrowArr.get(arrowNum);
				weakArrowTmp.xPosition = xPosition;
				weakArrowTmp.yPosition = yPosition;
				weakArrowTmp.aimAngle = getAngle(enemy);
			}
		}
		else{
			if (isWeakShot() && !weakShotState){
				weakArrowArr.add(new WeakArrow(keyInput));
				weakArrowTmp = weakArrowArr.get(arrowNum);
				weakArrowTmp.xPosition = xPosition;
				weakArrowTmp.yPosition = yPosition;
				weakArrowTmp.aimAngle = getAngle(enemy);
			}
		}
	}
	void updateStrongArrow(){
		if((strongArrow.xPosition < -1000 || strongArrow.xPosition > width + 1000) || 
			(strongArrow.yPosition < -1000 || strongArrow.yPosition > height + 1000) ||
			 (!keyInput.xPressed && !strongArrow.finishCharge) || weakShotState) { 
			strongArrowAdded = false;
			strongArrow.reset();
		}
		if((strongArrow.xPosition < -1000 || strongArrow.xPosition > width + 1000) || 
			(strongArrow.yPosition < -1000 || strongArrow.yPosition > height + 1000) || 
			(strongArrow.xPosition == xPosition && strongArrow.yPosition == yPosition) &&
			 isStrongShot() || !strongArrow.finishCharge) {
			strongArrow.arrowControl = true;
		}
		else{
			strongArrow.arrowControl = false;
		}
	}
	void addStrongShot(Character enemy){
		//println("arrowControl: "+strongArrow.arrowControl);
		if(isStrongShot() &&  strongArrow.arrowControl){
			if(!strongArrowAdded){
				strongArrow.aimAngle = getAngle(enemy);
			}
			strongArrow.xPosition = xPosition;
			strongArrow.yPosition = yPosition;
			strongArrowAdded = true;
		}
		if(strongArrowAdded){
			updateStrongArrow();
		}
	}
	void weakWeaponDisplay(Character enemy){
		if(isWeakShot()){
			pushMatrix();
			translate(xPosition, yPosition);
			rotate(getAngle(enemy));
			pushStyle();
			strokeWeight(1.5);
			line(0, 0, 50, 0);
			rotate(-PI/4);
			noFill();
			arc(0, 0, 80, 80, 0, HALF_PI);
			popStyle();
			popMatrix();
		}
	}

}