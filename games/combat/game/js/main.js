enchant();

//CONFIG
var SCR_WIDTH = 640;
var SCR_HEIGHT = 480;

//Movement Constants
var UP = 0;
var UP_RIGHT = 1;
var RIGHT = 2;
var DOWN_RIGHT =3;
var DOWN = 4;
var DOWN_LEFT = 5;
var LEFT = 6;
var UP_LEFT = 7;

//Player
var moveSpeed = 3;
var playerLife = 5;
var blinkTime = 1.5;


//Enemies
var enemySpeed = 2;
var enemyLife = 5;
var maxEnemies = 25;
var enemySpawnTime = 2;
var enemiesKilled = 0;

//GUNS

//handgun
var handGunFireSpeed = 0.5;
var handGunBulletSpeed = 7;
var handGunName = "Handgun";
var handGunAmmo = 100;
var handGunBurst = 0;

//machineGun
var machineGunFireSpeed = 0.07;
var machineGunBulletSpeed = 7;
var machineGunName = "MG";
var machineGunAmmo = 300;
var machineGunBurst = 0;

//shotGun
var shotGunFireSpeed = 1;
var shotGunBulletSpeed = 7;
var shotGunName = "Shotgun";
var shotGunAmmo = 30;
var shotGunBurst = 0;


window.onload = function() {

    var game = new Game(SCR_WIDTH, SCR_HEIGHT);
    // Preload resources
    game.preload('res/ludum_dude.png',
    			 'res/enemy.png',
				 'res/bullet.png',
				 'res/ludumTile.png',
				 'res/life.png',
				 'res/guns.png',
				 'res/explosion.wav',
			  	 'res/gun.wav',
				 'res/hitEnemy.wav',
				 'res/hitPlayer.wav',
				 'res/hitWall.wav');

    //  Game settings
    game.fps = 30;
    game.scale = 1;
    game.onload = function() {
        //key bindings
        game.keybind(65, 'b');
        game.keybind(83, 'a');
        game.keybind(32, 'space');

        // Once Game finishes loading
        var scene = new GameScene();
        game.removeScene(this);
        game.replaceScene(scene);
    }
    // Start
    game.start(); 



    //SCENES
    // TitleScene
	var TitleScene = Class.create(Scene, {
	    initialize: function() {
	    	//scene vars
	    	var titleLabel,startLabel, aLabel, sLabel, arrowLabel;
	    	//scene init
	    	Scene.apply(this);
        	var game = Game.instance;

        	titleLabel = new Label("ALIENS!");
        	titleLabel.x = 170;
        	titleLabel.y = 100;
        	titleLabel.color = '#21663A';
        	titleLabel.font = '40px strong';
       		titleLabel.textAlign = 'center';
        	this.titleLabel = titleLabel;

        	aLabel = new Label("A - fire");
        	aLabel.x = 160;
        	aLabel.y = 220;
        	aLabel.color = '#21663A';
        	aLabel.font = '16px strong Calibri, Candara, Segoe, Optima, Arial, sans-serif';
        	aLabel.textAlign = 'center';
        	this.aLabel = aLabel;

        	sLabel = new Label("S - change weapon");
        	sLabel.x = 160;
        	sLabel.y = 240;
        	sLabel.color = '#21663A';
        	sLabel.font = '16px strong Calibri, Candara, Segoe, Optima, Arial, sans-serif';
        	sLabel.textAlign = 'center';
        	this.sLabel = sLabel;

			arrowLabel = new Label("◄ ► ▼ ▲ - movement");
        	arrowLabel.x = 160;
        	arrowLabel.y = 260;
        	arrowLabel.color = '#21663A';
        	arrowLabel.font = '16px strong Calibri, Candara, Segoe, Optima, Arial, sans-serif';
        	arrowLabel.textAlign = 'center';
        	this.arrowLabel = arrowLabel;

        	startLabel = new Label("Press SPACE to play!");
        	startLabel.x = 170;
        	startLabel.y = 340;
        	startLabel.color = '#21663A';
        	startLabel.font = '16px strong Calibri, Candara, Segoe, Optima, Arial, sans-serif';
        	startLabel.textAlign = 'center';
        	this.startLabel = startLabel;

			this.backgroundColor = '#000000';
        	
        	this.addChild(titleLabel);
        	this.addChild(startLabel);
        	this.addChild(aLabel);
        	this.addChild(sLabel);
        	this.addChild(arrowLabel);
	    },
	    onenterframe: function(evt) {
	    	if (game.input.space){
	    		var level = new Level(level2,level2Obj,level2Collision);
                game.removeScene(this);
				game.replaceScene(new GameScene(level));
	    	}
	    }
	});


	// GameScene
	var GameScene = Class.create(Scene, {
	    initialize: function(level) {
			//Scene vars
			var player,gunHud,enemyHud,bulletPool,ammoLabel,lifeLabel,enemyLabel,enemyPool,playerGuns,handGun,machineGun,shotGun;

			//Scene init
	    	Scene.apply(this);
        	var game = Game.instance;

        	//CREATE SCENE VARS
        	ammoLabel = new Label("");
        	ammoLabel.x = 55;
        	ammoLabel.y = 10;
        	ammoLabel.color = '#E7FFC7';
        	ammoLabel.font = '13px strong Calibri, Candara, Segoe, Optima, Arial, sans-serif';
        	ammoLabel.textAlign = 'center';
        	this.ammoLabel = ammoLabel;

        	lifeLabel = new Label("");
        	lifeLabel.x = 150;
        	lifeLabel.y = 10;
        	lifeLabel.color = '#E7FFC7';
        	lifeLabel.backgroundColor = 'black';
        	lifeLabel.font = '13x strong Calibri, Candara, Segoe, Optima, Arial, sans-serif';
        	lifeLabel.textAlign = 'center';
        	this.lifeLabel = lifeLabel;

        	enemyLabel = new Label("");
        	enemyLabel.x = 250;
        	enemyLabel.y = 10;
        	enemyLabel.color = '#E7FFC7';
        	enemyLabel.backgroundColor = 'black';
        	enemyLabel.font = '13x strong Calibri, Candara, Segoe, Optima, Arial, sans-serif';
        	enemyLabel.textAlign = 'center';
        	this.enemyLabel = enemyLabel;

        	bulletPool = new Group();
        	this.bulletPool = bulletPool;

        	enemyPool = new Group();
        	this.enemyPool = enemyPool;

        	this.backgroundColor = 'black';

        	enemiesKilled = 0;

        	handGun = new Gun(handGunName,handGunFireSpeed,handGunBulletSpeed,handGunBurst,handGunAmmo);
        	machineGun = new Gun(machineGunName,machineGunFireSpeed,machineGunBulletSpeed,machineGunBurst,machineGunAmmo);
        	shotGun = new Gun(shotGunName,shotGunFireSpeed,shotGunBulletSpeed,shotGunBurst,shotGunAmmo);

        	//gun change HUD
        	gunHud = new Sprite(32, 32);
	        gunHud.image = game.assets['res/guns.png'];
	        gunHud.x =160;
	        gunHud.y = 0;
	        this.gunHud = gunHud;

	        //Life HUD
	        lifeHud = new Sprite(32, 32);
	        lifeHud.image = game.assets['res/life.png'];
	        lifeHud.x =260;
	        lifeHud.y = 0;
	        this.lifeHud = lifeHud;

	        //Enemy HUD
	       	enemyHud = new Sprite(32, 32);
	        enemyHud.image = game.assets['res/enemy.png'];
	        enemyHud.x =360;
	        enemyHud.y = 0;
	        this.enemyHud = lifeHud;

        	//Loads player
        	player = new Player(32,64,handGun,playerLife);
        	this.player = player;

        	//stores other guns in array for later use
        	playerGuns = [];
        	playerGuns[handGun.name] = "";
        	playerGuns[machineGun.name] = machineGun;
        	playerGuns[shotGun.name] = shotGun;
        	this.playerGuns = playerGuns;

        	//Loads map
        	var map = new Map(32, 32);
			map.image = game.assets['res/ludumTile.png'];
			this.level = level;
			map.loadData(level.tile,level.obj);
			map.collisionData = level.collision;
			this.map = map;

        	//APPEND TO SCENE
        	//adds map to scene
        	this.addChild(map);

        	//bullet Pool
        	this.addChild(bulletPool);

        	//enemy pool
        	this.addChild(enemyPool);

			//adds player to the scene
        	this.addChild(player);

        	//adds hud
        	this.addChild(ammoLabel);
        	this.addChild(lifeLabel);
        	this.addChild(enemyLabel);
        	this.addChild(gunHud);
        	this.addChild(lifeHud);
        	this.addChild(enemyHud);

        	this.spawnEnemyTimer = 0;

        	var lastTimeShot = this.player.gun.fireSpeed;
			this.lastTimeShot = lastTimeShot;


			this.addEventListener(Event.A_BUTTON_UP, this.releasedKey);

	    },
	    releasedKey: function(){
	    		//Cambia de arma
	    		var oldGun = this.player.getPlayerGun();
	    		if (oldGun.name == handGunName){
	    			var newGun = this.playerGuns[shotGunName];	
	    			this.gunHud.frame =  1;
	    		}
				if (oldGun.name == shotGunName){
	    			var newGun = this.playerGuns[machineGunName];	
	    			this.gunHud.frame =  2;
	    		}
	    		if (oldGun.name == machineGunName){
	    			var newGun = this.playerGuns[handGunName];	
	    			this.gunHud.frame =  0;
	    		}
	    		
	    		this.playerGuns[oldGun.name] = oldGun;
	    		this.player.setPlayerGun(newGun);
	    },
	    onenterframe: function(evt) {
	    	
	        var up = false;
	        var right = false;
	        var down = false;
	        var left = false;
	        //reset player movement
			this.player.moving = false;
			this.player.moveSpeed = 0;

			//Check input
			if(game.input.left && !game.input.right){
	            this.player.moveSpeed = moveSpeed;
	            left = true;
	            this.player.moving = true;
	        }
	        else if(game.input.right && !game.input.left){
	            this.player.moveSpeed = moveSpeed;
	            right = true;
	         	this.player.moving = true;
	        }
	        if(game.input.up && !game.input.down){
	            this.player.moveSpeed = moveSpeed;
	            up = true;
	            this.player.moving = true;
	        }
	        else if(game.input.down && !game.input.up){
	            this.player.moveSpeed = moveSpeed;
	            down = true;
	            this.player.moving = true;
	        }

	        //obtain direction
	       	if (left){
	        	this.player.direction = LEFT;
	        }else if (right){
	        	this.player.direction = RIGHT;
	        }

	        if (up){
	        	this.player.direction = UP;
	        	if (right){
	        		this.player.direction = UP_RIGHT;
	        	}
	        	else if(left){
	        		this.player.direction = UP_LEFT;	
	        	}
	        }
	       	if (down){
	        	this.player.direction = DOWN;
	        	if (right){
	        		this.player.direction = DOWN_RIGHT;
	        	}
	        	else if(left){
	        		this.player.direction = DOWN_LEFT;	
	        	}
	        }
			//sets direction
			this.player.setSpriteDirection(this.player.direction);

			//shooting input
	    	this.lastTimeShot += evt.elapsed * 0.001;
	    	if (game.input.b & this.lastTimeShot >= this.player.gun.fireSpeed & this.player.gun.ammo >0){
	    		var point = this.player.getGunPointPosition(0,0);

	    		//shotgun fires 5 bullets at once
	    		if (this.player.gun.name == "Shotgun"){
	    			
	    				var bullet = new Bullet(point.x,point.y,this.player.gun.bulletSpeed,this.player.direction);
	            		this.bulletPool.addChild(bullet);

	            		bullet = new Bullet(point.x+5,point.y+5,this.player.gun.bulletSpeed,this.player.direction);
	            		this.bulletPool.addChild(bullet);
						
						bullet = new Bullet(point.x+5,point.y-5,this.player.gun.bulletSpeed,this.player.direction);
	            		this.bulletPool.addChild(bullet);

	            		bullet = new Bullet(point.x-5,point.y-5,this.player.gun.bulletSpeed,this.player.direction);
	            		this.bulletPool.addChild(bullet);

	            		bullet = new Bullet(point.x-5,point.y+5,this.player.gun.bulletSpeed,this.player.direction);
	            		this.bulletPool.addChild(bullet);
	    		}else{
	    			var bullet = new Bullet(point.x,point.y,this.player.gun.bulletSpeed,this.player.direction);
	            	this.bulletPool.addChild(bullet);
	    		}

				this.lastTimeShot = 0;
	            if (this.player.gun.name != handGunName){
	            	this.player.gun.ammo--;	
	            }
	            

	            //game.assets['res/gun.wav'].play();
	    	}

	    	//Check collisions
	    	//bullets
    	    for (var b = this.bulletPool.childNodes.length -1; b >= 0; b-- ){
            	var bullet = this.bulletPool.childNodes[b];

            	//with enemies
            	for (var e = this.enemyPool.childNodes.length -1; e >= 0; e--){
            		var enemy = this.enemyPool.childNodes[e];
            		if (enemy.within(bullet,enemy.width/2)){
            			this.bulletPool.removeChild(bullet);
            			//game.assets['res/hitEnemy.wav'].play();
            			enemy.life--;
            			if (enemy.isEnemyDead()){
            				this.enemyPool.removeChild(enemy);
            				//game.assets['res/explosion.wav'].play();
            				enemiesKilled++;
            			}
            			break;
            		}
            	}

            	//with walls
            	if (this.map.hitTest(bullet.x,bullet.y)){
            		this.bulletPool.removeChild(bullet);
            		//game.assets['res/hitWall.wav'].play();
            	}else if ((bullet.x > SCR_WIDTH) || (bullet.x < 0) || (bullet.y > SCR_HEIGHT) || (bullet.y < 0)){
            		this.bulletPool.removeChild(bullet);
            	}
            }

            //player with tiles
            var dir = this.player.direction;
            if ((dir == RIGHT) & (this.map.hitTest(this.player.x+32,this.player.y + 16))){
            		this.player.moveSpeed = 0;
            }
            if ((dir == LEFT) & (this.map.hitTest(this.player.x,this.player.y + 16))){
            		this.player.moveSpeed = 0;
            }
			if ((dir == UP) & (this.map.hitTest(this.player.x + 16,this.player.y))){
            		this.player.moveSpeed = 0;
            }
            if ((dir == DOWN) & (this.map.hitTest(this.player.x+16,this.player.y + 32))){
            		this.player.moveSpeed = 0;
            }
            if ((dir == UP_RIGHT) & (this.map.hitTest(this.player.x+32,this.player.y))){
            		this.player.direction  = RIGHT;
            		this.player.moveSpeed = 0;
            }
            if ((dir == UP_LEFT) & (this.map.hitTest(this.player.x,this.player.y))){
            		this.player.direction  = LEFT;
            		this.player.moveSpeed = 0;
            }
            if ((dir == DOWN_LEFT) & (this.map.hitTest(this.player.x,this.player.y + 32))){
					this.player.direction  = LEFT;
					this.player.moveSpeed = 0;
            }
            if ((dir == DOWN_RIGHT) & (this.map.hitTest(this.player.x+32,this.player.y+32))){
          			this.player.direction = RIGHT;
          			this.player.moveSpeed = 0;
            }

            //Enemy collisions and navigation
           	for (var e = this.enemyPool.childNodes.length -1; e >= 0; e--){
        		var enemy = this.enemyPool.childNodes[e];
        		
				//check out of map
				if ((enemy.x > SCR_WIDTH) || (enemy.x < 0) || (enemy.y > SCR_HEIGHT) || (enemy.y < 0)){
            		this.enemyPool.removeChild(enemy);
            		break;
            	}

        		//with player -> decreases life
        		if (enemy.within(this.player,enemy.width/2) && !this.player.blinking){
        			this.player.moveSpeed = -16;
        			this.player.life--;
        			//game.assets['res/hitPlayer.wav'].play();
        			this.player.blinking = true;
        			if (this.player.isPlayerDead()){
        				var scene = new GameOverScene();
        				game.removeScene(this);
        				game.replaceScene(scene);
        			}
        		}

        		//with tiles
				var dir = enemy.direction;
				if ((dir == RIGHT) & (this.map.hitTest(enemy.x+32,enemy.y + 16))){
						enemy.moveSpeed = 0;
				}
				if ((dir == LEFT) & (this.map.hitTest(enemy.x,enemy.y + 16))){
						enemy.moveSpeed = 0;
				}
				if ((dir == UP) & (this.map.hitTest(enemy.x + 16,enemy.y))){
						enemy.moveSpeed = 0;
				}
				if ((dir == DOWN) & (this.map.hitTest(enemy.x+16,enemy.y + 32))){
						enemy.moveSpeed = 0;
				}
				if ((dir == UP_RIGHT) & (this.map.hitTest(enemy.x+32,enemy.y))){
						enemy.moveSpeed = 0;
				}
				if ((dir == UP_LEFT) & (this.map.hitTest(enemy.x,enemy.y))){
						enemy.moveSpeed = 0;
				}
				if ((dir == DOWN_LEFT) & (this.map.hitTest(enemy.x,enemy.y + 32))){
						enemy.moveSpeed = 0;
				}
				if ((dir == DOWN_RIGHT) & (this.map.hitTest(enemy.x+32,enemy.y+32))){
						enemy.moveSpeed = 0;
				}

        		//Decides direction of movement
        		//random change of direction
	        		var r = Math.floor(Math.random()*200);
		        	switch(r){
		        		// case 1: enemy.direction = UP_RIGHT;
		        		// 		break;
		        		// case 2: enemy.direction = UP_LEFT;
		        		// 		break;
		        		case 3: enemy.direction = LEFT;
		        				break;
		        		case 4: enemy.direction = RIGHT;
		        				break;
		        		case 5: enemy.direction = DOWN;
		        				break;
		        		case 6: enemy.direction = UP;
		        				break;
		        		// case 7: enemy.direction = DOWN_RIGHT;
		        		// 		break;
		        		// case 8: enemy.direction = DOWN_LEFT;
		        		// 		break;
		        		default: break; //no change of dir
		        	}

        		if (enemy.moveSpeed == 0){
        			var r = Math.floor(Math.random()*2);

        			//chooses new direction of movement
        			if (dir == LEFT){
        					if(r % 2 == 0){
        						enemy.direction = UP;	        				
        					}
        					else{
        						enemy.direction = DOWN;	        					
        					}
        				}

        			if (dir == UP){
        				if(r % 2 == 0){
        					enemy.direction = RIGHT;
        				}else{
        					enemy.direction = LEFT;
        				}
        			}

        			if (dir == RIGHT){
        				if(r % 2 == 0){
        					enemy.direction = DOWN;	
        				}else{
        					enemy.direction = UP;
        				}
        			}

        			if (dir == DOWN){
        				if(r % 2 == 0){
							enemy.direction = LEFT;
						}else{
							enemy.direction = RIGHT;
						}
        			}



        			//stores last direction for future reference
        			enemy.lastDirection = dir;
        			//sets up new speed
        			enemy.moveSpeed = enemySpeed;
        		}
        	}

        	//Spawns new enemies
        	this.spawnEnemyTimer += evt.elapsed * 0.001;
	        if ((this.spawnEnemyTimer >= enemySpawnTime) && (this.enemyPool.childNodes.length <= maxEnemies)) {
	            this.spawnEnemyTimer -= enemySpawnTime;
	            var r = Math.floor(Math.random()*4);
	            var initDir = RIGHT;
	            if (r == 1) initDir = RIGHT;
	            if (r == 2) initDir = UP;
	            if (r == 3) initDir = DOWN;
	            if (r == 4) initDir = LEFT;

	            var spawnPoint = Math.floor(Math.random()*2);
	            if (spawnPoint == 1){
	            	var enemy = new Enemy(224,128,enemyLife,enemySpeed,initDir);	
	            }else{
	            	var enemy = new Enemy(512,384,enemyLife,enemySpeed,initDir);
	            }
	            
        		this.enemyPool.addChild(enemy);
	        }

        	//updates HUD
        	if (this.player.gun.name == handGunName){
        		this.ammoLabel.text= "∞";	
        	}
        	else{
        		this.ammoLabel.text= this.player.gun.ammo;	
        	}
        	
        	this.lifeLabel.text= this.player.life;
        	this.enemyLabel.text = enemiesKilled;
	    }
	});

	// GameOverScene
	var GameOverScene = Class.create(Scene, {
	    initialize: function(score) {
	        
	        var game = Game.instance;
	        var gameOverLabel, buttonLabel, scoreLabel;
	        Scene.apply(this);
	        this.backgroundColor = 'black';
	        // Game Over label
	        gameOverLabel = new Label("GAME OVER");
	        gameOverLabel.x = 170;
	        gameOverLabel.y = 128;
	        gameOverLabel.color = 'white';
	        gameOverLabel.font = '32px strong Calibri, Candara, Segoe, Optima, Arial, sans-serif';
	        gameOverLabel.textAlign = 'center';

	        //buttonLabel
	        buttonLabel = new Label("Press SPACE to try again!");
	        buttonLabel.x = 165;
	        buttonLabel.y = 250;
	        buttonLabel.color = 'white';
	        buttonLabel.font = '16px strong Calibri, Candara, Segoe, Optima, Arial, sans-serif';
	        buttonLabel.textAlign = 'center';

	       	//scoreLabel
	        scoreLabel = new Label("Score: " + enemiesKilled );
	        scoreLabel.x = 165;
	        scoreLabel.y = 200;
	        scoreLabel.color = 'white';
	        scoreLabel.font = '16px strong Calibri, Candara, Segoe, Optima, Arial, sans-serif';
	        scoreLabel.textAlign = 'center';


	        // Add labels
	        this.addChild(gameOverLabel);
	        this.addChild(buttonLabel);
	        this.addChild(scoreLabel);
	    },
	    onenterframe: function (evt) {
	        if(game.input.space){
	            //reset values
                game.removeScene(this);
	            game.replaceScene(new TitleScene());
	        }
	    }
	});

    //CLASSES
	var Level = Class.create({
		initialize: function(tile,obj,collision){
			this.tile = tile;
			this.obj = obj;
			this.collision = collision;
		}

	});

    var Player = Class.create(Sprite, {
    	initialize : function(x,y,gun,life) {
    		Sprite.apply(this,[32, 32]);
	        this.image = Game.instance.assets['res/ludum_dude.png'];
	        this.x = x;
	        this.y = y;
	        this.moveSpeed = 0;
	        this.gun = gun;
	        this.life = life;
	        //animate
	        this.animationDuration = 0;

	        this.direction = LEFT;
	        this.moving = false;
	        this.blinking = false;
	        this.blinkTime = 0;

    	},
    	onenterframe: function(evt) {
			//moves
			if (this.moving){
				switch(this.direction){
					case UP: this.y -= this.moveSpeed;
							  break;
					case RIGHT : this.x += this.moveSpeed;
    						break;
					case UP_RIGHT : this.x += this.moveSpeed;
									this.y -= this.moveSpeed;
									break;
					case UP_LEFT :  this.x -= this.moveSpeed;
								    this.y -= this.moveSpeed;
								    break;
					case LEFT : this.x -= this.moveSpeed;
								break;
					case DOWN_LEFT : this.x -= this.moveSpeed;
									 this.y += this.moveSpeed;
									 break;
					case DOWN : this.y += this.moveSpeed;
								break;
					case DOWN_RIGHT : this.x += this.moveSpeed;
									 this.y += this.moveSpeed;
								break;
					default: break;
				}
			}

			//animation
			if (this.moving){
				this.animationDuration += evt.elapsed * 0.001;       
		        if (this.animationDuration >= 0.08) {
		            this.frame = (this.frame + 1) % 4;
		            this.animationDuration -= 0.08;
		        }
			}else{
				this.animationDuration = 0;
			}

			//invincibility for a brief time after being hit
			if (this.blinking){
				this.opacity = 0.5;
				this.blinkTime += evt.elapsed * 0.001;
				if (this.blinkTime >= blinkTime){
					this.blinking = false;
					this.blinkTime = 0;
					this.opacity = 1;
				}
			}

	        // Collisions with screen border
	        if (this.x > SCR_WIDTH - this.width){
	            this.x = SCR_WIDTH -this.width;
	        }
	        if (this.x <  0){
	            this.x =  0;
	        }
	        if (this.y > SCR_HEIGHT - this.height){
	            this.y = SCR_HEIGHT -this.height;
	        }
	        if (this.y < 0){
	            this.y = 0;
	        }

    	},
    	setSpriteDirection: function(direction) {
    		this.rotation = 0;
    		switch (direction){
    			case RIGHT : this.rotate(180);
    						break;
				case UP_RIGHT : this.rotate(135);
							break;
				case UP : this.rotate(90);
							break;
				case UP_LEFT : this.rotate(45);
							break;
				case LEFT : this.rotate(0);
							break;
				case DOWN_LEFT : this.rotate(315);
							break;
				case DOWN : this.rotate(270);
							break;
				case DOWN_RIGHT : this.rotate(225);
							break;
				default: this.rotate(0);
    		}
    	},
    	getGunPointPosition: function(x,y) {
    		var point = new Point(0,0);
    		point.x = this.x;
    		point.y = this.y;
    		if (this.direction == LEFT){
    			point.y = this.y + 14;
    			point.x = this.x;
    		}
    		if (this.direction == RIGHT){
				point.y = this.y + 14;
				point.x = this.x + 32
			}
    		if (this.direction == UP){
    			point.x = this.x + 14;
    			point.y = this.y;
    		}
    		if (this.direction == DOWN) {
    			point.x = this.x + 14;
    			point.y = this.y + 32;
    		}
    		if (this.direction == UP_RIGHT){
    			point.x = this.x + 28;
    			point.y = this.y;
    		}
    		if (this.direction == UP_LEFT){
    			point.x = this.x + 2;
    			point.y = this.y;
    		}
    		if (this.direction == DOWN_LEFT){
    			point.x = this.x - 2;
    			point.y = this.y + 30;
    		}
    		if (this.direction == DOWN_RIGHT){
    			point.x = this.x + 30;
    			point.y = this.y + 30;
    		}

    		return point;
    	},
    	isPlayerDead: function(){
    		if (this.life <=0){
    			return true;
    		}
    		return false;
    	},
    	setPlayerGun: function(gun){
    		if (this != null){
    			this.gun = gun;	
    		}
    	},
    	getPlayerGun: function() {
    		if (this.gun!=null){
    			return this.gun;	
    		}
    	}

    });

	var Bullet = Class.create(Sprite, {
		initialize : function(x,y,bulletSpeed,direction) {
			Sprite.apply(this,[5, 5]);
	        this.image = Game.instance.assets['res/bullet.png'];
			this.x = x;
			this.y = y;
			this.bulletSpeed = bulletSpeed;
			this.direction = direction;
		},
		onenterframe : function(evt) {
    		switch (this.direction){
    			case RIGHT : this.x +=this.bulletSpeed;
    						break;
				case UP_RIGHT : this.x +=this.bulletSpeed;
								this.y -=this.bulletSpeed;
								break;
				case UP : this.y -=this.bulletSpeed;
								break;
				case UP_LEFT : this.y -= this.bulletSpeed;
							   this.x -= this.bulletSpeed;
							break;
				case LEFT : this.x -= this.bulletSpeed;
							break;
				case DOWN_LEFT : this.x -= this.bulletSpeed;
								 this.y += this.bulletSpeed;
							break;
				case DOWN : this.y += this.bulletSpeed;
							break;
				case DOWN_RIGHT : this.x += this.bulletSpeed;
								  this.y += this.bulletSpeed;
							break;
				default: break;
    		}
		}
	});

	var Enemy = Class.create(Sprite, {
		initialize: function(x,y,life,moveSpeed,initDir){
    		Sprite.apply(this,[32, 32]);
	        this.image = Game.instance.assets['res/enemy.png'];
	        this.x = x;
	        this.y = y;
	        this.life = life;
	        this.moveSpeed = moveSpeed;
	        this.direction = initDir;

	        //store last known direction before current one
	        this.lastDirection = RIGHT;

	        //animate
	        this.animationDuration = 0;
		},
		onenterframe: function(evt){
				//animation
				this.animationDuration += evt.elapsed * 0.001;       
		        if (this.animationDuration >= 0.3) {
		            this.frame = (this.frame + 1) % 2;
		            this.animationDuration -= 0.3;
		        }

		        //move in the direction set
		         this.setSpriteDirection(this.direction);
		         switch (this.direction){
	    			case RIGHT : this.x +=this.moveSpeed;
	    						break;
					case UP_RIGHT : this.x +=this.moveSpeed;
									this.y -=this.moveSpeed;
									break;
					case UP : this.y -=this.moveSpeed;
									break;
					case UP_LEFT : this.y -= this.moveSpeed;
								   this.x -= this.moveSpeed;
								break;
					case LEFT : this.x -= this.moveSpeed;
								break;
					case DOWN_LEFT : this.x -= this.moveSpeed;
									 this.y += this.moveSpeed;
								break;
					case DOWN : this.y += this.moveSpeed;
								break;
					case DOWN_RIGHT : this.x += this.moveSpeed;
									  this.y += this.moveSpeed;
								break;
					default: break;
	    		}
		},
		setSpriteDirection: function(direction) {
    		this.rotation = 0;
    		switch (direction){
    			case RIGHT : this.rotate(180);
    						break;
				case UP_RIGHT : this.rotate(135);
							break;
				case UP : this.rotate(90);
							break;
				case UP_LEFT : this.rotate(45);
							break;
				case LEFT : this.rotate(0);
							break;
				case DOWN_LEFT : this.rotate(315);
							break;
				case DOWN : this.rotate(270);
							break;
				case DOWN_RIGHT : this.rotate(225);
							break;
				default: this.rotate(0);
    		}
    	},
		isEnemyDead: function(){
			if (this.life <= 0){
				return true;
			}
			return false;
		}
	});

	var Gun = Class.create({
		initialize : function(name,fireSpeed,bulletSpeed,burst,ammo){
			this.name = name;
			this.fireSpeed = fireSpeed;
			this.bulletSpeed = bulletSpeed;
			this.burst = burst;
			this.ammo = ammo;
		}
	});

	var Point = Class.create({
		initialize: function(x,y){
			this.x = x;
			this.y = y;
		}
	});

};