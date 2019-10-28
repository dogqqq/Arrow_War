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
	float rotatingRate, rotatingAddRate;
	float rotateScalar = 0.015;
	float accelarationAddRate = 0.3;
	float accelarationBound = 1.0;
	float velocityBound;
	int arrowNum;
	boolean strongArrowAdded = false;
	int weakInjuryTime, strongInjuryTime, time;

	abstract void setOriginPosition();
	abstract void display();
}
class Player extends Character{
	ArrayList<WeakArrow> weakArrowArr = new ArrayList<WeakArrow>();
	WeakArrow weakArrowTmp = new WeakArrow(keyInput1);
	StrongArrow strongArrow = new StrongArrow(keyInput1);
	KeyInput keyInput = new KeyInput();
	Player(KeyInput _keyInput){
		keyInput = _keyInput; 
	}

	void reset(){
		xVelocity = 0;
		yVelocity = 0;
		xAccelaration = 0;
		yAccelaration = 0;
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
	/////////////////////////////////////////////////////////////////

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


abstract class Arrow{
	float xPosition, yPosition;
	float accelaration;
	float speed, finalSpeed;
	float xVelocity, yVelocity;
	float aimAngle;
	float strokeWeightRate;
	float headSize, arrowSize, featherSize;
	KeyInput keyInput = new KeyInput();
	Arrow(KeyInput _keyInput){
		keyInput = _keyInput;
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
	void updateAccelaration(){
		accelaration += 0.5;
	}
	void updateSpeed(){
		if(speed <= finalSpeed){
			speed += accelaration;
		}
		if(speed > finalSpeed){
			speed = finalSpeed;
		}
	}
	void updateVelocity(){
		xVelocity = speed*cos(aimAngle);
		yVelocity = speed*sin(aimAngle);
	}
	void updatePosition(){
		xPosition += xVelocity;
		yPosition +=yVelocity;
	}
	void arrowDisplay(){
		pushMatrix();
		translate(xPosition, yPosition);
		rotate(aimAngle);
		translate(arrowSize, 0);

		pushStyle();
		noFill();
		strokeWeight(1*strokeWeightRate);
		quad(0, 0, -headSize-3, headSize, -5*strokeWeightRate, 0, -headSize-3, -headSize);
		popStyle();

		pushStyle();
		strokeWeight(1.5*strokeWeightRate);
		line(0, 0, -arrowSize, 0);
		popStyle();

		pushStyle();
		translate(-(arrowSize - featherSize*1.25), 0);
		strokeWeight(1*strokeWeightRate);
		line(0, 0, -featherSize, featherSize);
		line(0, 0, -featherSize, -featherSize);

		translate(-featherSize*0.5, 0);
		line(0, 0, -featherSize, featherSize);
		line(0, 0, -featherSize, -featherSize);
		popStyle();
		popMatrix();
	}
	abstract void update();
}
class WeakArrow extends Arrow{
	WeakArrow(KeyInput _keyInput){
		super(_keyInput);
		headSize = 8;
		arrowSize = 50;
		featherSize = 6;
		strokeWeightRate = 1;
		finalSpeed = 6;
	}

	void update(){
		updateAccelaration();
		updateSpeed();
		updateVelocity();
		updatePosition();
	}
	void display(){
		arrowDisplay();
	}
		
}
class StrongArrow extends Arrow{
	float chargeAddTime = 0.15, chargeTime;
	float strongArrowWeaponOpacity;
	boolean arrowControl = true;
	boolean finishCharge = false;
	StrongArrow(KeyInput _keyInput){
		super(_keyInput);
		headSize = 24;
		arrowSize = 150;
		featherSize = 18;
		strokeWeightRate = 2;
		finalSpeed = 50;
	}
	void reset(){
		xPosition = -100;
		yPosition = -100;
		chargeTime = 0;
		strongArrowWeaponOpacity = 0;
		arrowControl = true;
		finishCharge = false;
	}

	boolean finishCharging(){
		if(finishCharge && isCharging()){
			return true;
		}
		return false;
	}
	boolean isCharging(){
		if(isStrongShot() && arrowControl){
			return true;
		}
		return false;
	}
	void updateChargeTime(){
		if(isCharging()){
			chargeTime += chargeAddTime;
			if(chargeTime >= TWO_PI){
				finishCharge = true;
				chargeTime = TWO_PI;
			}
		}
		else{
			chargeTime = 0;
		}
	}
	void chargeCounterDisplay(){
		if(isCharging()){
			pushMatrix();
			pushStyle();
			translate(xPosition, yPosition);
			rotate(aimAngle);
			noFill();
			strokeWeight(5);
			stroke(255, 0, 0);
			arc(0, 0, 80, 80, 0, chargeTime);
			popStyle();
			popMatrix();	
		}
	}
	void strongWeaponDisplay(){
		if(strongArrowWeaponOpacity >= 255){
			strongArrowWeaponOpacity = 255;
		}
		if (isStrongShot() && arrowControl) {
			pushMatrix();
			translate(xPosition, yPosition);
			rotate(aimAngle);
			pushStyle();
			strokeWeight(10);
			stroke(255, 0, 0, strongArrowWeaponOpacity);
			strongArrowWeaponOpacity += 5;
			line(0, 0, 1000, 0);
			popStyle();
			popMatrix();
		}
		if(!keyInput.xPressed){
			strongArrowWeaponOpacity = 0;
		}
	}
	void update(){
		//println("isCharging(): "+isCharging());
		//println("finishCharging(): "+finishCharging());
		updateAccelaration();
		updateVelocity();
		updateSpeed();
		updateChargeTime();

		if(!keyInput.xPressed && finishCharging()){
			arrowControl = false;
		}
		if(!arrowControl && finishCharge){
			updatePosition();
		}
	}
	void display(){
		arrowDisplay();
		chargeCounterDisplay();
		strongWeaponDisplay();
	}
}