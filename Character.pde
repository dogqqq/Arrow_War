abstract class Information{
	float xPosition, yPosition;
	float xVelocity, yVelocity;
	float xAccelaration, yAccelaration;
	boolean weakShotState = false, strongShotState = false;

	float getAngle(Information other) {
	    return atan2(other.yPosition - this.yPosition, other.xPosition - this.xPosition);
	}
	float getXPosition(){
		return xPosition;
	}
	float getYPosition(){
		return yPosition;
	}
}

abstract class Character extends Information{

	float moveDeltaX, moveDeltaY, aimDeltaX, aimDeltaY;
	boolean strongShotBtn = false, weakShotBtn = false;

	float rotatingRate, rotatingAddRate;
	float rotateScalar = 0.015;
	float accelarationAddRate = 0.3;
	float accelarationBound = 1.0;
	float xVelocityBound, yVelocityBound;
	int arrowNum;
	boolean strongArrowAdded = false;
	int weakInjuryTime, strongInjuryTime, time;
	ArrayList<WeakArrow> weakArrowArr = new ArrayList<WeakArrow>();
	WeakArrow weakArrowTmp;
	StrongArrow strongArrow;
	KeyInput keyInput = new KeyInput();

	Character(KeyInput _keyInput){
		keyInput = _keyInput; 
		weakArrowTmp = new WeakArrow(keyInput);
		strongArrow = new StrongArrow(keyInput);
	}

	void setMoveDeltaX(float _moveDeltaX){
		moveDeltaX = _moveDeltaX;
	}
	void setMoveDeltaY(float _moveDeltaY){
		moveDeltaY = _moveDeltaY;
	}
	void setAimDeltaX(float _aimDeltaX){
		aimDeltaX = _aimDeltaX;
	}
	void setAimDeltaX(float _aimDeltaY){
		aimDeltaY = _aimDeltaY;
	}
	void setStrongShotBtn(boolean _strongShotBtn){
		strongShotBtn = _strongShotBtn;
	}
	void setWeakShotBtn(boolean _weakShotBtn){
		weakShotBtn = _weakShotBtn;
	}

	void reset(){
		xVelocity = 0;
		yVelocity = 0;
		xAccelaration = 0;
		yAccelaration = 0;
		rotatingAddRate = 0;
	}
	void updateAccelaration(){
		if (moveDeltaY < 0 && yAccelaration >= -accelarationBound) {
			yAccelaration -= accelarationAddRate;
		}
		if (moveDeltaY > 0 && yAccelaration <= accelarationBound) {
			yAccelaration += accelarationAddRate;
		}
		if(moveDeltaX > 0 && xAccelaration <= accelarationBound){
			xAccelaration += accelarationAddRate;
		}
		if(moveDeltaX < 0 && xAccelaration >= -accelarationBound){
			xAccelaration -= accelarationAddRate;				
		}
		if(noDirectionPressed()){
			xAccelaration = 0;
			yAccelaration = 0;
		}
	}
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
	void updateVelocity(StrongArrow strongArrow){
		if(isWeakShot()){
			xVelocityBound = 2*abs(moveDeltaX);
			yVelocityBound = 2*abs(moveDeltaY);
		}
		else if(isStrongShot() && strongArrow.arrowControl){
			xVelocityBound = 0.5*abs(moveDeltaX);
			yVelocityBound = 0.5*abs(moveDeltaY);
		}
		else{
			xVelocityBound = 5*abs(moveDeltaX);
			yVelocityBound = 5*abs(moveDeltaY);
		}
		if(xVelocity >= -xVelocityBound && xVelocity <= xVelocityBound){
			xVelocity += xAccelaration;
		}
		if(yVelocity >= -yVelocityBound && yVelocity <= yVelocityBound){
			yVelocity += yAccelaration;
		}
		xVelocity = xVelocity > xVelocityBound ? xVelocityBound : xVelocity;
		xVelocity = xVelocity < -xVelocityBound ? -xVelocityBound : xVelocity;
		yVelocity = yVelocity < -yVelocityBound ? -yVelocityBound : yVelocity;
		yVelocity = yVelocity > yVelocityBound ? yVelocityBound : yVelocity;
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
	boolean noDirectionPressed(){
		if(moveDeltaY == 0 && moveDeltaX == 0)
			return true;
		return false;
	}
	// boolean noDirectionPressed(){
	// 	if(!keyInput.upPressed && !keyInput.rightPressed && !keyInput.downPressed && !keyInput.leftPressed)
	// 		return true;
	// 	return false;
	// }
	boolean isWeakShot(){
		if(weakShotBtn && !strongShotBtn){
			return true;
		}
		return false;

	}
	// boolean isWeakShot(){
	// 	if (keyInput.zPressed && !keyInput.xPressed) {
	// 		return true;
	// 	}
	// 	return false;
	// }
	boolean isStrongShot()){
		if(strongShotBtn && ! weakShotBtn){
			return true;
		}	
		return false;
	}
	// boolean isStrongShot(){
	// 	if(keyInput.xPressed && !keyInput.zPressed){
	// 		return true;
	// 	}
	// 	return false;
	// }
	void update(){
		if(weakShotState){
			reset();
		}
		updateAccelaration();
		updateVelocity(strongArrow);
		updatePosition();
		updateRotatingRate();
	}

	abstract void setOriginPosition();
	abstract void display();
}
class Player extends Character{

	Player(KeyInput _keyInput){
		super(_keyInput);
	}

	void setOriginPosition(){
		//xPosition = width/2;
		//yPosition = height*5/6;
		xPosition = 700/2;
		yPosition = 800*5/6;
	}
	void setArrow(){
		for (WeakArrow arrow : weakArrowArr) {
				arrow.update();
				arrow.display();
			}
			strongArrow.update();
			if(strongArrowAdded){
				strongArrow.display();
			}
	}
	void display(){
		if(weakShotState){
			injuryDisplay();
			setArrow();
		}
		pushMatrix();
		translate(xPosition, yPosition);
		rotate(rotatingRate);
		pushStyle();
		strokeWeight(1.5);
		rect(0, 0, 35, 35);	
		popStyle();
		popMatrix();
		setArrow();
	}
	void injuryDisplay(){
		pushMatrix();
		translate(xPosition, yPosition);
		pushMatrix();
		rotate(rotatingRate);
		pushStyle();
		fill(255);
		rect(0, 0, 35, 35);	
		stroke(255, 0, 0);
		noFill();
		arc(0, 0, 75, 75, 0, TWO_PI);
		popStyle();
		popMatrix();
		popMatrix();
	}
	void checkInjury(Enemy enemy){
		println("PstrongShotState: "+strongShotState);
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
			 (!keyInput.xPressed && !strongArrow.finishCharge) || weakShotState) { // || weakShotState
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


class Enemy extends Character{

	Enemy(KeyInput _keyInput){
		super(_keyInput);
	}

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