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