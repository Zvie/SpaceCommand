package {	import flash.display.*;	import flash.events.*;	import flash.utils.Timer;	import flash.text.TextField;		public class SpaceCommand extends MovieClip {		private var player:Player;		private var alienships:Array;		private var projectiles:Array;		public var leftArrow, rightArrow:Boolean;		private var nextShip:Timer;		private var shotsLeft:int;		private var shotsHit:int;		
		
				public function startSpaceCommand() {			// init score			shotsLeft = 40;			shotsHit = 0;			
		
			
				
			        showProjLeft.text = String(shotsLeft);				
			
						// create Player			player = new Player();			player.gotoAndStop("P_MS");
			addChild(player);						// create object arrays			alienships = new Array();			projectiles = new Array();						// listen for keyboard			stage.addEventListener(KeyboardEvent.KEY_DOWN,keyDownFunction);			stage.addEventListener(KeyboardEvent.KEY_UP,keyUpFunction);						// look for collisions			addEventListener(Event.ENTER_FRAME,checkForHits);			// start Aliens Flying			setNextAlien();		}				public function setNextAlien() {			nextShip = new Timer(1000+Math.random()*1000,1);			nextShip.addEventListener(TimerEvent.TIMER_COMPLETE,newAlien);			nextShip.start();		}				public function newAlien(event:TimerEvent) {			// random side, speed and altitude			if (Math.random() > .5) {				var side:String = "left";			} else {				side = "right";			}			var altitude:Number = Math.random()*50+20;			var speed:Number = Math.random()*150+150;						// create plane			var a:alienShip = new alienShip(side,speed,altitude);			addChild(a);			alienships.push(a);						// set time for next Alien			setNextAlien();		}				// check for collisions		public function checkForHits(event:Event) {			for(var projectileNum:int=projectiles.length-1;projectileNum>=0;projectileNum--){ 				for (var alienshipNum:int=alienships.length-1;alienshipNum>=0;alienshipNum--) {					if (projectiles[projectileNum].hitTestObject(alienships[alienshipNum])) {						alienships[alienshipNum].AlienHit();						projectiles[projectileNum].deleteprojectile();						shotsHit = shotsHit + 100;						showGameScore();
						showScorenum.text = String(shotsHit);						break;					}				}			}						if ((shotsLeft == 0) && (projectiles.length == 0)) {				endGame();			}		}				// key pressed		public function keyDownFunction(event:KeyboardEvent) {			if (event.keyCode == 37) {				leftArrow = true;
				player.gotoAndStop("P_ML");			} else if (event.keyCode == 39) {				rightArrow = true;
				player.gotoAndStop("P_MR");			} else if (event.keyCode == 32) {				fireProjectile();
				player.gotoAndStop("P_SS");			}		}				// key lifted		public function keyUpFunction(event:KeyboardEvent) {			if (event.keyCode == 37) {				leftArrow = false;
				player.gotoAndStop("P_MS");			} else if (event.keyCode == 39) {				rightArrow = false;
				player.gotoAndStop("P_MS");			} else if (event.keyCode == 32) {
				player.gotoAndStop("P_MS");
			}		}		// new projectile created		public function fireProjectile() {			if (shotsLeft <= 0) return;			var b:Projectile = new Projectile(player.x,player.y - 35, -300);			addChild(b);			projectiles.push(b);			shotsLeft = shotsLeft - 1;
			showProjLeft.text = String(shotsLeft);			showGameScore();		}				public function showGameScore() {
			
			
			
						showScore.text = String("Score:");			showShots.text = String("Shots Left:");

		
					}				// take a Alien Ship from the array		public function removeAlien(alien:alienShip) {			for(var i in alienships) {				if (alienships[i] == alien) {					alienships.splice(i,1);					break;				}			}		}				// take a projectile from the array		public function removeprojectile(bullet:Projectile) {			for(var i in projectiles) {				if (projectiles[i] == bullet) {					projectiles.splice(i,1);					break;				}			}		}				// game is over, clear movie clips		public function endGame() {			// remove Alien Ships			for(var i:int=alienships.length-1;i>=0;i--) {				alienships[i].deleteAlien();			}			alienships = null;						player.deletePlayer();			player = null;						stage.removeEventListener(KeyboardEvent.KEY_DOWN,keyDownFunction);			stage.removeEventListener(KeyboardEvent.KEY_UP,keyUpFunction);			removeEventListener(Event.ENTER_FRAME,checkForHits);						nextShip.stop();			nextShip = null;						gotoAndStop("gameover");		}	}}