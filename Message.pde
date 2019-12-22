class MessageChart{
	void display(){
		pushStyle();
		fill(255, 175);
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
		textSize(20);
		textAlign(CENTER);
		//text("(auto aiming)", width/2, height*3/14);
		text("Right Player Black", width/2, height*3.8/14);
		text("Left Player White", width/2, height*5.2/14);
		textAlign(LEFT);
		// text("Press U: Weak shoot. (slow down enemy)", width/5, height*4.6/14);
		// text("Press O: Strong shoot. (need charging)", width/5, height*5.4/14);
		// text("Press I, K, J, L to control.", width/5, height*6.2/14);
		text("Press ZR: Weak shoot. (slow down enemy)", width/5, height*6.6/14);
		text("Press ZL: Strong shoot. (need charging)", width/5, height*7.4/14);
		text("Left joystick to control.", width/5, height*8.2/14);
		text("Right joystick to adjust strong shoot aiming.", width/5, height*9.0/14);
		// textAlign(CENTER);
		// text("Left Player White", width/2, height*7.4/14);
		// textAlign(LEFT);
		// text("Press Q: Weak shoot. (slow down enemy)", width/5, height*8.2/14);
		// text("Press E: Strong shoot. (need charging)", width/5, height*9/14);
		// text("Press W, S, A, D to control.", width/5, height*9.8/14);
		textSize(24);
		textAlign(CENTER);
		text("Press X to start the game. ", width/2, height*11/14);
		popStyle();	
	}
}

class LoseMessage{
	float place = -500;

	LoseMessage(int condition){
		if(condition == 6){
			place = width/4;
		}
		else{
			place = width*3/4;
		}
	}
	
	void display(){
		pushStyle();
		fill(0);
		textSize(120/2);
		text("Lose", place, height*4/9);
		textSize(25);
		text("Press X to start a new game", width/2, height*5.25/9);
		popStyle();
	}
	void displayLaugh(LoseMessage other){
		other.display();
		pushStyle();
		fill(0);
		textSize(20);
		text("laugh you wwwwwwwww", place, height*4.8/9);
		popStyle();
	}
}

class VictoryMessage{
	float place;

	VictoryMessage(int condition){
		if(condition == 5){
			place = width/4;
		}
		else{
			place = width*3/4;
		}
	}

	void display(){
		pushStyle();
		fill(0);
		textSize(120/2);
		text("Victory", place, height*4/9);
		textSize(25/2);
		popStyle();
	}
}

class WelcomeMessage{
	TitleMessage titleMessage = new TitleMessage();
	RuleMessage ruleMessage = new RuleMessage();

	void displayTitle(){
		titleMessage.display();
	}
	void displayRule(){
		ruleMessage.display();
	}
}

class OutcomeMessage{
	int condition;
	LoseMessage loseMessage;
	VictoryMessage victoryMessage;
	boolean xPressed = false;

	OutcomeMessage(int _condition){
		condition = _condition;
		loseMessage = new LoseMessage(condition);
		victoryMessage = new VictoryMessage(condition);
	}

	void display(){
		loseMessage.display();
		victoryMessage.display();
	}
	void displayLaugh(){
		loseMessage.displayLaugh(loseMessage);
		victoryMessage.display();
	}
}
