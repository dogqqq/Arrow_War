class MessageChart{
	void display(){
		pushStyle();
		fill(255, 150);
		rect(width/2, height/2, 2*width/3, 2*height/3);
		popStyle();
	}
}
class TitleMessage{
	MessageChart messageChart = new MessageChart();

	void display(){
		messageChart.display();
		pushStyle();
		fill(0);
		textSize(35);
		text("-Arrow War-", width/2, height*3/7);
		text("-407262512/407262330-", width/2, height*3.75/7);
		textSize(20);
		text("Press X to next page.", width/2, height*4.5/7);
		popStyle();
	}
}
class RuleMessage{
	MessageChart messageChart = new MessageChart();

	void display(){
		messageChart.display();
		pushStyle();
		fill(0);
		textSize(25);
		textAlign(LEFT);
		text("(auto aiming)", width/5, height*3/10);
		text("Press Z: Weak shoot.",width/5, height*4/10 );
		text("Press X: Strong shoot.",width/5, height*5/10 );
		text("Press Up, Down, Left, Right to control.",width/5, height*6/10);
		textSize(24);
		textAlign(CENTER);
		text("Press X to start game.",width/2, height*7/10 );
		popStyle();	
	}
}
class LoseMessage{
	void display(){
		pushStyle();
		fill(0);
		textSize(120);
		text("Lose", width/2, height*4/9);
		textSize(25);
		text("Press X to start a new game", width/2, height*5.25/9);
		popStyle();
	}
	void displayLaugh(LoseMessage other){
		other.display();
		pushStyle();
		fill(0);
		textSize(20);
		text("laugh you wwwwwwwww", width/2, height*4.92/9);
		popStyle();
	}
}
class VictoryMessage{
	void display(){
		pushStyle();
		fill(0);
		textSize(120);
		text("Victory", width/2, height*4/9);
		textSize(25);
		text("Press X to start a new game", width/2, height*5.25/9);
		popStyle();
	}
}