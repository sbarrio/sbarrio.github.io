enchant();

//CONFIG
var SCR_WIDTH = 640;
var SCR_HEIGHT = 480;


var gravity = 9.8;
var upwards_accel = 10;

var LEVEL1_SPEED = 4;
var LEVEL2_SPEED = 6;
var LEVEL3_SPEED = 8;
var blockSpeed;
var blockSpawnTime = 3;

var floorSpeed = 5;

var startX = 250;
var startY = 200;
var READY = 0;
var PLAYING = 1;
var GAME_OVER = 2;

var gameState = READY;

var physicsWorld;


window.onload = function() {

    var game = new Game(SCR_WIDTH, SCR_HEIGHT);
    // Preload resources
    game.preload('res/player.png',
    			 'res/block_120.png',
    			 'res/block_210.png',
    			 'res/block_165.png',
    			 'res/floor.png',
    			 'res/bg1.png',
    		     'res/bg2.png',
    		     'res/flap.wav',
    		     'res/hit.wav',
    		     'res/point.wav');

    //  Game settings
    game.fps = 30;
    game.scale = 1;
    game.onload = function() {
        //key bindings
        //game.keybind(32, 'space');
        //game.keybind(83, 'a');
        
        physicsWorld = new PhysicsWorld(0, gravity);
        // Once Game finishes loading
        game.removeScene(this);
        var scene = new GameScene();
        game.replaceScene(scene);
    }
    // Start
    game.start(); 

	//SCENES

	// GameScene
	var GameScene = Class.create(Scene, {
	    initialize: function() {
			//Scene vars
			var player, blockPool, floor, bg;

			//Scene init
	    	Scene.apply(this);
        	var game = Game.instance;

        	//loads bg
        	bg = new Sprite(640,480);
        	var r = Math.floor(Math.random()*2);
        	if (r==0){
				bg.image = game.assets['res/bg2.png'];
        	}else{
        		bg.image = game.assets['res/bg1.png'];
        	}
        	
        	bg.x = bg.y = 0;

        	//Loads player
        	player = new Player(startX,startY);
        	this.player = player;

        	blockPool = new Group();
        	this.blockPool = blockPool;

			floor = new PhyBoxSprite(1280, 64, enchant.box2d.STATIC_SPRITE, 1.0, 0.5, 0.3, true);
            floor.image = game.assets["res/floor.png"];
            floor.position = { x: 0, y: 448  };
            this.floor = floor;

			//this.addEventListener(Event.A_BUTTON_UP, this.releasedKey);
			this.addEventListener('touchend', this.releasedKey);

		////APPEND TO SCENE

			//adds player to the scene
			this.addChild(bg);

        	this.addChild(player);

        	this.addChild(blockPool);

        	this.addChild(floor);

        	this.spawnBlockTimer = 0;

        	blockSpeed = LEVEL1_SPEED;
	    },
	    onenterframe: function(evt) {

			this.player.contact(function(){
				if (gameState != GAME_OVER){
					game.assets['res/hit.wav'].play();
					gameState = GAME_OVER;	
					blockSpeed = 0;
					//show score and game over
				}
        	});

			//physics simulation on
			if ((gameState == PLAYING) || (gameState == GAME_OVER)){
				physicsWorld.step(game.fps);
			}
			
			if (this.player.y <= 0){
				this.player.applyImpulse(new b2Vec2(0, 10));	
			}
	    	if (gameState == PLAYING){
				//Moves floor
				this.floor.x -= floorSpeed;
				if (this.floor.x <= -640){
					this.floor.x =0;
				}

				//spawns new blocks
				this.spawnBlockTimer += evt.elapsed * 0.001;
				if (this.spawnBlockTimer >= blockSpawnTime) {
		            this.spawnBlockTimer -= blockSpawnTime;

		            var r = Math.floor(Math.random()*3);
		            if (r == 0){
		            	var blockTop = new Block(640,0,100,120);
		            	var blockBottom = new Block(640,270,100,210);
		            }
		            if (r == 1){
		            	var blockTop = new Block(640,0,100,210);
		            	var blockBottom = new Block(640,360,100,120);
		            }
		            if (r == 2){
		            	var blockTop = new Block(640,0,100,165);
		            	var blockBottom = new Block(640,315,100,165);
		            }

		            blockTop.scale(1.0,-1.0);
		            this.blockPool.addChild(blockTop);
		            this.blockPool.addChild(blockBottom);
		        }

		        //blocks update
		        for (var b = this.blockPool.childNodes.length -1; b >= 0; b--){
	        		var cur_block = this.blockPool.childNodes[b];
	        		//out of screen -> remove
	        		if (cur_block.x <= -100){
	        			this.blockPool.removeChild(cur_block);
	        		}
	        	}
				

				//checks blocks passed -> increments score
			}
		},
		releasedKey: function(evt){
			if (gameState == PLAYING){
				this.player.applyImpulse(new b2Vec2(0, -upwards_accel));	
				game.assets['res/flap.wav'].play();
			}

			if (gameState == READY){
				gameState = PLAYING;
				//hides ready text
			}

			if (gameState == GAME_OVER){
				//cleans objects
				for (var b = this.blockPool.childNodes.length -1; b >= 0; b--){
					var cur_block = this.blockPool.childNodes[b];
					this.blockPool.removeChild(cur_block);
					cur_block.destroy();
				}
				this.floor.destroy();
				this.player.destroy();
				game.removeScene(this);
				gameState = READY;
        		var scene = new GameScene();
        		game.replaceScene(scene);
			}
		}
	});


    var Player = Class.create(PhyBoxSprite, {
    	initialize : function(x,y) {
    		PhyBoxSprite.apply(this,[32, 32, enchant.box2d.DYNAMIC_SPRITE, 1.0, 0.5, 0.3, true]);
	        this.image = Game.instance.assets['res/player.png'];
	        this.x = x;
	        this.y = y;
	        this.animationDuration = 0;
    	},
    	onenterframe: function(evt) {
			//animation
			this.animationDuration += evt.elapsed * 0.001;       
	        if (this.animationDuration >= 0.1) {
	            this.frame = (this.frame + 1) % 4;
	            this.animationDuration -= 0.1;
	        }
    	}
    });

    var Block = Class.create(PhyBoxSprite, {
    	initialize : function(x,y,width,height) {
    		PhyBoxSprite.apply(this,[width, height, enchant.box2d.STATIC_SPRITE, 1.0, 0.5, 0.3, true]);
    		if (height == 120){
    			this.image = Game.instance.assets['res/block_120.png'];	
    		}else if (height == 210){
    			this.image = Game.instance.assets['res/block_210.png'];	
    		}else{
    			this.image = Game.instance.assets['res/block_165.png'];	
    		}
	        
	        this.x = x;
	        this.y = y;
    	},
    	onenterframe: function(evt) {
    		this.x-=blockSpeed;
    	}
    });
};

