abstract class BackgroundLine {
	float position;
	float velocity, accelaration;
	color lineColor;
	float maxAccelerationMagnitude = 0.015;

	BackgroundLine(){
		lineColor = color(228, 228, 237);
		setAccelaration();
	}
	void setAccelaration(){
		accelaration = random(0, maxAccelerationMagnitude);
	}
	abstract void update();
	abstract void display();
}

class HorizontalLine extends BackgroundLine{
	HorizontalLine(){
		position = random(0, height)*5;
	}
	void update(){
		if(velocity >= 0 && velocity <= 1){
			velocity = 1.5; 
		}
		if (velocity >= -1 && velocity <= 0) {
			velocity = -1.5;
		}
		if(position >= height || position <= 0){
			velocity *= -0.95;
			setAccelaration();
			accelaration *= -1;
		}
		position += velocity;
		velocity += accelaration;
	}
	void display(){
	    stroke(lineColor);
		line(0, position, width, position);
	}
}

class VerticalLine extends BackgroundLine{
	VerticalLine(){
		position = random(0, width)*5;
	}
	void update(){
		if(velocity >= 0 && velocity <= 1){
			velocity = 1.5; 
		}
		if (velocity >= -1 && velocity <= 0) {
			velocity = -1.5;
		}
		if(position >= width || position <= 0){
			velocity *= -0.95;
			setAccelaration();
			accelaration *= -1;
		}
		position += velocity;
		velocity += accelaration;
	}
	void display(){
	    stroke(lineColor);
		line(position, 0, position, height);
	}
}

final class GameBackground{
	ArrayList<BackgroundLine> lineArray = new ArrayList<BackgroundLine>();

	GameBackground() {
	    for (int i = 0; i < 8; i++) {
	     	lineArray.add(new HorizontalLine());
	    }
	    for (int i = 0; i < 8; i++) {
	    	lineArray.add(new VerticalLine());
	    }
  	}
  	void run(){
  		background(255);
	    update();
	    pushStyle();
	  	display();
	  	popStyle();
  	}
  	void update() {
	    for (BackgroundLine line : lineArray) {
		    line.update();
		}
	}
	void display(){
		for (BackgroundLine line : lineArray) {
			line.display();
		}
	}
}