enchant();

//CONFIG
var SCR_WIDTH = 800;
var SCR_HEIGHT = 600;

var PLAYER_WIDTH = 80;
var PLAYER_HEIGHT = 150;


//Player
var playerSpeed = 3.5;
var playerSpriteSpeed = 0.08;

//Game progress vars
var hasBox = false;
var hasRock = false;
var hasSeenSwitch = false;
var buttonScene3Pressed = false;
var scene3DoorOpen = false;
//----------------------


//font style
var itemTextColor = '#FFFFFF';
var itemFont = '14px strong Arial, sans-serif';
var bannerFont = '25px strong Arial, sans-serif';
var dialogColor = '#FFFFFF';
var dialogFont = '14px strong Arial, sans-serif';

window.onload = function() {

    var game = new Game(SCR_WIDTH, SCR_HEIGHT);
    // Preload resources
    game.preload('res/player/player.png',
    			 'res/obj/rock.png',
    			 'res/obj/switch.png',
    			 'res/obj/switch_pushed.png',
    			 'res/obj/switch_pushed_with_rock.png',
    			 'res/obj/scene3_door.png',
//    			 'res/snd/falling.wav',
//    			 'res/snd/door.wav',
//				 'res/snd/button.wav',
    			 'res/scene_bg/scene_bg1.png',
    			 'res/scene_bg/scene_bg2.png',
    			 'res/scene_bg/scene_bg3.png',
    			 'res/scene_bg/scene_bg4.png',
    			 'res/scene_bg/scene_bg5.png',
    			 'res/scene_bg/scene_bg6.png',
    			 'res/scene_bg/scene_bg7.png',
    			 'res/scene_bg/scene_bg8.png'
    			 );

    //  Game settings
    game.fps = 30;
    game.scale = 1;
    game.onload = function() {
        // Once Game finishes loading
        var scene = new Scene1(100,400);
        game.pushScene(scene);
    }
    // Start
    game.start(); 

	//SCENES

	var currentScene;

//SCENE 1
	var Scene1 = Class.create(Scene, {
	    initialize: function(startX,startY) {
			//Scene vars
			var player;

			var labelPlayer;

			var labelBox;

			var dialogPlayer;

			labelBox = new Label("Shipwreck");
			labelBox.x = 110;
			labelBox.y = 300;
        	labelBox.color = itemTextColor;
       		labelBox.font = itemFont;
        	this.labelBox = labelBox;
        	this.labelBox.visible = false;
        	this.labelBox.width = 80;
        	this.labelBox._boundHeight = 50;
        	this.labelBox.touchEnabled = true;
        	this.labelBox.addEventListener(enchant.Event.TOUCH_END, this.getBox);

			dialogPlayer = new Label("");
			dialogPlayer.x = 0;
			dialogPlayer.y = 0;
        	dialogPlayer.color = dialogColor;
       		dialogPlayer.font = dialogFont;
        	this.dialogPlayer = dialogPlayer;

			//Scene init
	    	Scene.apply(this);
        	var game = Game.instance;

        	//Loads player
        	//getting startPosition
        	this.horizonY = 300;

        	player = new Player(startX,startY);
        	this.player = player;

        	//loads scene bg
        	bg = new Sprite(800,600);
			bg.image = game.assets['res/scene_bg/scene_bg1.png'];
        	bg.x = bg.y = 0;


		////APPEND TO SCENE

			//adds scene background
			this.addChild(bg);

			//adds player to the scene
        	this.addChild(player);

        	//adds dialog
        	this.addChild(labelBox);
        	this.addChild(dialogPlayer);
        //listens to click and sets up touch positions
	        this.tx = 0;
	        this.ty = 0;
	        this.addEventListener('touchend', this.releasedKey);

	        currentScene = this;
	    },
	    onenterframe: function(evt) { 

	    	if ((this.player.x >= this.tx-playerSpeed) && (this.player.x < this.tx + playerSpeed)
	    	 && (this.player.y >= this.ty-playerSpeed) && (this.player.y < this.ty + playerSpeed)){
	    		this.player.moving = false;
	    	}

	    	if (!hasBox){
	    		if (this.labelBox.intersect(this.player)){
		    		this.labelBox.visible = true;
		    	}else{
		    		this.labelBox.visible = false;
		    	}
	    	}


	    	if (this.player.moving){
	    		if (this.player.x < this.tx){
	    			this.player.x += playerSpeed;
	    			if (!this.player.facingRight){
	    				this.player.faceRight(true);
	    			}
	    		}
	    		if (this.player.x > this.tx){
	    			this.player.x -= playerSpeed;
	    			if (this.player.facingRight){
	    				this.player.faceRight(false);
	    			}
	    		}
	    	 	if (this.player.y < this.ty){
	    			this.player.y += playerSpeed;
	    		}
	    		if (this.player.y > this.ty){
	    			this.player.y -= playerSpeed;
	    		}
	    	}

	    	if (this.player.x > SCR_WIDTH - 100){
	    		this.goToScene2();
	    	}
		},
		goToScene2: function(){
			var scene = new Scene2(100,400);
			game.replaceScene(scene);
		},
		getBox: function() {
			if (this.visible){
				hasBox = true;	
				this.visible = false;
				currentScene.showDialog("Not going anywhere with this one.");
			}
		},
		showDialog: function(text){
			this.dialogPlayer.x = this.player.x;
			this.dialogPlayer.y = this.player.y - 50;
			this.dialogPlayer.text = text;
			this.dialogPlayer.tl.show().delay(60).fadeOut(10).hide();
		},
		releasedKey: function(evt) {
			//clicked, player moves
			this.player.moving = true;			
			var targetY = evt.y - Math.floor(PLAYER_HEIGHT);
			var targetX = evt.x - Math.floor(PLAYER_WIDTH);
			if (targetY < this.horizonY){
				this.ty = this.horizonY;
			}else{
				this.ty = targetY;
			}

			if (targetX <0){
				targetX = 0;
			}

			this.tx = targetX;
		}
	});

//SCENE 2
	var Scene2 = Class.create(Scene, {
	    initialize: function(startX, startY) {
			//Scene vars
			var player;

			//Scene init
	    	Scene.apply(this);
        	var game = Game.instance;

        	var dialogPlayer;
        	dialogPlayer = new Label("");
			dialogPlayer.x = 0;
			dialogPlayer.y = 0;
        	dialogPlayer.color = dialogColor;
       		dialogPlayer.font = dialogFont;
        	this.dialogPlayer = dialogPlayer;


    		var labelView;
        	labelView = new Label("View");
			labelView.x = 510;
			labelView.y = 360;
        	labelView.color = itemTextColor;
       		labelView.font = itemFont;
        	this.labelView = labelView;
        	this.labelView.visible = false;
        	this.labelView.width = 60;
        	this.labelView._boundHeight = 50;
        	this.labelView.touchEnabled = true;
        	this.labelView.addEventListener(enchant.Event.TOUCH_END, this.showView);

        	//Loads player
        	//getting startPosition
        	this.horizonY = 350;

        	player = new Player(startX,startY);
        	this.player = player;

        	//loads scene bg
        	bg = new Sprite(800,600);
			bg.image = game.assets['res/scene_bg/scene_bg2.png'];
        	bg.x = bg.y = 0;

		////APPEND TO SCENE

			//adds scene background
			this.addChild(bg);

			if (!hasRock){
				var rock;
	        	rock = new Sprite(60,60);
	        	rock.image = game.assets['res/obj/rock.png'];
	        	rock.x = 200;
	        	rock.y = 500;
	        	this.rock = rock;
	        	this.addChild(rock);
	        }

			//adds player to the scene
        	this.addChild(player);

        	if(!hasRock){
	        	var labelRock;
	        	labelRock = new Label("Rock");
				labelRock.x = 210;
				labelRock.y = 500;
	        	labelRock.color = itemTextColor;
	       		labelRock.font = itemFont;
	        	this.labelRock = labelRock;
	        	this.labelRock.visible = false;
	        	this.labelRock.width = 60;
	        	this.labelRock._boundHeight = 50;
	        	this.labelRock.touchEnabled = true;
	        	this.labelRock.addEventListener(enchant.Event.TOUCH_END, this.getRock);
				this.addChild(labelRock);
			}

        	this.addChild(labelView);

        	this.addChild(dialogPlayer);

        //listens to click and sets up touch positions
	        this.tx = 0;
	        this.ty = 0;
	        this.addEventListener('touchend', this.releasedKey);

	        currentScene = this;
	    },
	    onenterframe: function(evt) { 

	    	if ((this.player.x >= this.tx-playerSpeed) && (this.player.x < this.tx + playerSpeed)
	    	 && (this.player.y >= this.ty-playerSpeed) && (this.player.y < this.ty + playerSpeed)){
	    		this.player.moving = false;
	    	}

    		if (this.labelView.intersect(this.player)){
	    		this.labelView.visible = true;
	    	}else{
	    		this.labelView.visible = false;
	    	}

	    	if ((!hasRock) && (hasSeenSwitch) && (this.labelRock.intersect(this.player))){
	    		this.labelRock.visible = true;
	    	}else{
	    		if (this.labelRock){
	    			this.labelRock.visible = false;
	    		}
	    	}

	    	if (this.player.moving){
	    		if (this.player.x < this.tx){
	    			this.player.x += playerSpeed;
	    			if (!this.player.facingRight){
	    				this.player.faceRight(true);
	    			}
	    		}
	    		if (this.player.x > this.tx){
	    			this.player.x -= playerSpeed;
	    			if (this.player.facingRight){
	    				this.player.faceRight(false);
	    			}
	    		}
	    	 	if (this.player.y < this.ty){
	    			this.player.y += playerSpeed;
	    		}
	    		if (this.player.y > this.ty){
	    			this.player.y -= playerSpeed;
	    		}
	    	}
	    	if (this.player.x > SCR_WIDTH - 120){
	    		this.goToScene3();
	    	}
	    	if (this.player.x< 30){
	    		this.goToScene1();
	    	}
		},
		goToScene1: function(){
			var scene = new Scene1(650,400);
			game.replaceScene(scene);
		},
		goToScene3: function(){
			var scene = new Scene3(100,400);
			game.replaceScene(scene);
		},
		showView: function(){
			currentScene.dialogPlayer.x = currentScene.player.x;
			currentScene.dialogPlayer.y = currentScene.player.y-40;
			currentScene.dialogPlayer.text = "What is this place?";
			currentScene.dialogPlayer.tl.show().delay(60).fadeOut(10).hide();
		},
		getRock: function(){
			hasRock = true;
			currentScene.rock.visible = false;
			currentScene.labelRock.visible = false;
			game.assets['res/snd/button.wav'].play();
			currentScene.dialogPlayer.x = currentScene.player.x;
			currentScene.dialogPlayer.y = currentScene.player.y-40;
			currentScene.dialogPlayer.text = "Might come in handy.";
			currentScene.dialogPlayer.tl.show().delay(60).fadeOut(10).hide();
		},
		releasedKey: function(evt) {
			//clicked, player moves
			this.player.moving = true;			
			var targetY = evt.y - Math.floor(PLAYER_HEIGHT);
			var targetX = evt.x - Math.floor(PLAYER_WIDTH);
			if (targetY < this.horizonY){
				this.ty = this.horizonY;
			}else{
				this.ty = targetY;
			}

			if (targetX <0){
				targetX = 0;
			}

			this.tx = targetX;
		}
	});

// SCENE 3
	var Scene3 = Class.create(Scene, {
	    initialize: function(startX,startY) {
			//Scene vars
			var player;

			//Scene init
	    	Scene.apply(this);
        	var game = Game.instance;

        	//Loads player
        	//getting startPosition
        	this.horizonY = 300;

        	player = new Player(startX,startY);
        	this.player = player;

        	//loads scene bg
        	bg = new Sprite(800,600);
			bg.image = game.assets['res/scene_bg/scene_bg3.png'];
        	bg.x = bg.y = 0;

        	var door;

        	door = new Sprite(130,240);
        	door.image = game.assets['res/obj/scene3_door.png'];
        	door.x = 622;
        	door.y = 300;
        	this.door = door;

        	var button;



        	button = new Sprite(60,60);
        	if (scene3DoorOpen){
				button.image = game.assets['res/obj/switch_pushed_with_rock.png'];
	    		this.door.visible = false;
			}else{
				button.image = game.assets['res/obj/switch.png'];	
			}
        	button.x = 300;
        	button.y = 400;
        	this.button = button;

		////APPEND TO SCENE

			//adds scene background
			this.addChild(bg);

			this.addChild(door);
			this.addChild(button);

			//adds player to the scene
        	this.addChild(player);

        	var labelButton;
			if(hasRock){
	        	labelButton = new Label("Place rock");
				labelButton.x = 300;
				labelButton.y = 400;
	        	labelButton.color = itemTextColor;
	       		labelButton.font = itemFont;
	        	this.labelButton = labelButton;
	        	this.labelButton.visible = false;
	        	this.labelButton.width = 80;
	        	this.labelButton._boundHeight = 50;
	        	this.labelButton.touchEnabled = true;
	        	this.labelButton.addEventListener(enchant.Event.TOUCH_END, this.placeRock);
	        	this.labelButton = labelButton;
				this.addChild(labelButton);
			}

        //listens to click and sets up touch positions
	        this.tx = 0;
	        this.ty = 0;
	        this.addEventListener('touchend', this.releasedKey);
	        currentScene = this;

	    },
	    onenterframe: function(evt) { 

	    	if ((this.player.x >= this.tx-playerSpeed) && (this.player.x < this.tx + playerSpeed)
	    	 && (this.player.y >= this.ty-playerSpeed) && (this.player.y < this.ty + playerSpeed)){
	    		this.player.moving = false;
	    	}

	    	if(hasRock){
	    		if ((this.labelButton.intersect(this.player)) && (!buttonScene3Pressed)){
	    			this.labelButton.visible = true;
	    		}else{
	    			this.labelButton.visible = false;
	    		}
	    	}

	    	if (this.player.moving){
	    		if (this.player.x < this.tx){
	    			this.player.x += playerSpeed;
	    			if (!this.player.facingRight){
	    				this.player.faceRight(true);
	    			}
	    		}
	    		if (this.player.x > this.tx){
	    			this.player.x -= playerSpeed;
	    			if (this.player.facingRight){
	    				this.player.faceRight(false);
	    			}
	    		}
	    	 	if (this.player.y < this.ty){
	    			this.player.y += playerSpeed;
	    		}
	    		if (this.player.y > this.ty){
	    			this.player.y -= playerSpeed;
	    		}
	    	}

	    	var centerX = this.player.x + 40;
	    	var centerY = this.player.y + 75;

	    	if (!buttonScene3Pressed){
	    		hasSeenSwitch = true;
	    		if (this.button.within(this.player,60)){
	    			if (this.door.visible){
	    				//game.assets['res/snd/door.wav'].play();
	    			}
	    			this.door.visible = false;
	    			this.button.image = game.assets['res/obj/switch_pushed.png'];
	    		}else{
	    			if (!this.door.visible){
	    				//game.assets['res/snd/door.wav'].play();
	    			}
	    			this.door.visible = true;
	    			this.button.image = game.assets['res/obj/switch.png'];
	    		}
	    	}
	    	
	    	if (scene3DoorOpen){
	    		if (this.player.x > SCR_WIDTH - 200){
	    			this.goToScene4();
	    		}
	    	}
	    	if (this.player.x< 30){
	    		this.goToScene2();
	    	}
		},
		goToScene2: function(){
			var scene = new Scene2(650,400);
			game.replaceScene(scene);
		},
		goToScene4: function(){
			var scene = new Scene4(100,400);
			game.replaceScene(scene);
		},
		placeRock: function(){
			buttonScene3Pressed = true;
			scene3DoorOpen = true;
			//game.assets['res/snd/door.wav'].play();
			currentScene.button.image = game.assets['res/obj/switch_pushed_with_rock.png'];
			currentScene.door.visible = false;
		},
		releasedKey: function(evt) {
			//clicked, player moves
			this.player.moving = true;			
			var targetY = evt.y - Math.floor(PLAYER_HEIGHT);
			var targetX = evt.x - Math.floor(PLAYER_WIDTH);
			if ((!scene3DoorOpen) && (targetX > 600)){
				targetX = 600;
			}
			if (targetY < this.horizonY){
				this.ty = this.horizonY;
			}else{
				this.ty = targetY;
			}

			if (targetX <0){
				targetX = 0;
			}

			this.tx = targetX;
		}
	});

//SCENE4
	var Scene4 = Class.create(Scene, {
	    initialize: function(startX,startY) {
			//Scene vars
			var player;

			//Scene init
	    	Scene.apply(this);
        	var game = Game.instance;

        	var dialogPlayer;
        	dialogPlayer = new Label("");
			dialogPlayer.x = 500;
			dialogPlayer.y = 350;
        	dialogPlayer.color = dialogColor;
       		dialogPlayer.font = dialogFont;
        	this.dialogPlayer = dialogPlayer;

        	var labelCheck;
        	labelCheck = new Label("Windows");
        	labelCheck.x = 400;
        	labelCheck.y = 300;
        	labelCheck.color = itemTextColor;
        	labelCheck.font = itemTextColor;
        	labelCheck.visible = false;
        	this.labelCheck = labelCheck;
        	this.labelCheck.addEventListener(enchant.Event.TOUCH_END, this.checkWindows);

        	//Loads player
        	//getting startPosition
        	this.horizonY = 300;

        	player = new Player(startX,startY);
        	this.player = player;

        	//loads scene bg
        	bg = new Sprite(800,600);
			bg.image = game.assets['res/scene_bg/scene_bg4.png'];
        	bg.x = bg.y = 0;

		////APPEND TO SCENE

			//adds scene background
			this.addChild(bg);

			//adds player to the scene
        	this.addChild(player);

        	this.addChild(dialogPlayer);

        	this.addChild(labelCheck);

        //listens to click and sets up touch positions
	        this.tx = 0;
	        this.ty = 0;
	        this.addEventListener('touchend', this.releasedKey);

	        currentScene = this;

	    },
	    onenterframe: function(evt) { 

	    	if ((this.player.x >= this.tx-playerSpeed) && (this.player.x < this.tx + playerSpeed)
	    	 && (this.player.y >= this.ty-playerSpeed) && (this.player.y < this.ty + playerSpeed)){
	    		this.player.moving = false;
	    	}

	    	if (this.player.intersect(this.labelCheck)){
	    		this.labelCheck.visible = true;
	    	}else{
	    		this.labelCheck.visible = false;
	    	}

	    	if (this.player.moving){
	    		if (this.player.x < this.tx){
	    			this.player.x += playerSpeed;
	    			if (!this.player.facingRight){
	    				this.player.faceRight(true);
	    			}
	    		}
	    		if (this.player.x > this.tx){
	    			this.player.x -= playerSpeed;
	    			if (this.player.facingRight){
	    				this.player.faceRight(false);
	    			}
	    		}
	    	 	if (this.player.y < this.ty){
	    			this.player.y += playerSpeed;
	    		}
	    		if (this.player.y > this.ty){
	    			this.player.y -= playerSpeed;
	    		}
	    	}
	    	
	    	if (this.player.x > SCR_WIDTH - 100){
	    		this.goToScene5();
	    	}
	    	if (this.player.x< 30){
	    		this.goToScene3();
	    	}
		},
		goToScene3: function(){
			var scene = new Scene3(500,400);
			game.replaceScene(scene);
		},
		goToScene5: function(){
			var scene = new Scene5(100,400);
			game.replaceScene(scene);
		},
		checkWindows: function(){
			currentScene.dialogPlayer.x = currentScene.player.x + 50;
			currentScene.dialogPlayer.y = currentScene.player.y - 50;
			currentScene.dialogPlayer.text = "It's really quiet in here.";
			currentScene.dialogPlayer.tl.show().delay(60).fadeOut(10).hide();
		},
		releasedKey: function(evt) {
			//clicked, player moves
			this.player.moving = true;			
			var targetY = evt.y - Math.floor(PLAYER_HEIGHT);
			var targetX = evt.x - Math.floor(PLAYER_WIDTH);
			if (targetY < this.horizonY){
				this.ty = this.horizonY;
			}else{
				this.ty = targetY;
			}

			if (targetX <0){
				targetX = 0;
			}

			this.tx = targetX;
		}
	});

//SCENE5
	var Scene5 = Class.create(Scene, {
	    initialize: function(startX,startY) {
			//Scene vars
			var player;

			//Scene init
	    	Scene.apply(this);
        	var game = Game.instance;

        	var dialogPlayer;
        	dialogPlayer = new Label("");
			dialogPlayer.x = 500;
			dialogPlayer.y = 350;
        	dialogPlayer.color = dialogColor;
       		dialogPlayer.font = dialogFont;
        	this.dialogPlayer = dialogPlayer;

        	//Loads player
        	//getting startPosition
        	this.horizonY = 300;

        	player = new Player(startX,startY);
        	this.player = player;



        	//loads scene bg
        	bg = new Sprite(800,600);
			bg.image = game.assets['res/scene_bg/scene_bg5.png'];
        	bg.x = bg.y = 0;

		////APPEND TO SCENE

			//adds scene background
			this.addChild(bg);

			//adds player to the scene
        	this.addChild(player);

        	this.addChild(dialogPlayer);

        //listens to click and sets up touch positions
	        this.tx = 0;
	        this.ty = 0;
	        this.addEventListener('touchend', this.releasedKey);

	        currentScene = this;
	        this.falling = false;

	    },
	    onenterframe: function(evt) { 

	    	if ((this.player.x >= this.tx-playerSpeed) && (this.player.x < this.tx + playerSpeed)){
	    		this.player.moving = false;
	    	}

	    	if ((this.player.moving) && (!this.falling)){
	    		if (this.player.x < this.tx){
	    			this.player.x += playerSpeed;
	    			if (!this.player.facingRight){
	    				this.player.faceRight(true);
	    			}
	    		}
	    		if (this.player.x > this.tx){
	    			this.player.x -= playerSpeed;
	    			if (this.player.facingRight){
	    				this.player.faceRight(false);
	    			}
	    		}
	    	}
	    	
	    	if (this.player.x > 500){
	    		this.falling = true;
	    		this.player.frame=1;
	    		this.player.tl.delay(5).then(function(){
	    			currentScene.dialogPlayer.text = "Not sure about this...";

	    		}).delay(10).moveTo(500,700,10).then(function(){
	    			//game.assets['res/snd/falling.wav'].play();
					currentScene.goToScene6();
	    		});
	    		
	    	}
	    	if (this.player.x< 30){
	    		this.goToScene4();
	    	}
		},
		goToScene4: function(){
			var scene = new Scene4(700,400);
			game.replaceScene(scene);
		},
		goToScene6: function(){
			var scene = new Scene6();
			game.replaceScene(scene);
		},
		releasedKey: function(evt) {
			//clicked, player moves
			this.player.moving = true;			
			var targetX = evt.x - Math.floor(PLAYER_WIDTH/2);
			if (targetX <0){
				targetX = 0;
			}

			this.tx = targetX;
		}
	});

//SCENE6
	var Scene6 = Class.create(Scene, {
	    initialize: function() {
			//Scene vars
			var player;

			//Scene init
	    	Scene.apply(this);
        	var game = Game.instance;

 	      	player = new Player(350,-100);
        	this.player = player;

        	//loads scene bg
        	bg = new Sprite(800,600);
			bg.image = game.assets['res/scene_bg/scene_bg6.png'];
        	bg.x = bg.y = 0;

		////APPEND TO SCENE

			//adds scene background
			this.addChild(bg);

			//adds player to the scene
        	this.addChild(player);

	        currentScene = this;
	        this.falling = false;
	    },
	    onenterframe: function(evt) { 
	    	if (!this.falling){
	    		this. falling = true;
	    		this.player.tl.delay(5).moveTo(this.player.x,1000,50).then(function(){
					currentScene.goToScene7();
	    		});
	    	}
		},
		goToScene7: function(){
			var scene = new Scene7();
			game.replaceScene(scene);
		}
	});

// SCENE 7
	var Scene7 = Class.create(Scene, {
	    initialize: function() {
			//Scene vars
			var player;

			//Scene init
	    	Scene.apply(this);
        	var game = Game.instance;

 	      	player = new Player(350,-100);
        	this.player = player;

        	//loads scene bg
        	bg = new Sprite(800,600);
			bg.image = game.assets['res/scene_bg/scene_bg7.png'];
        	bg.x = bg.y = 0;

		////APPEND TO SCENE

			//adds scene background
			this.addChild(bg);

			//adds player to the scene
        	this.addChild(player);

	        currentScene = this;
	        this.falling = false;
	    },
	    onenterframe: function(evt) { 
	    	if (!this.falling){
	    		this. falling = true;
	    		this.player.tl.delay(5).moveTo(this.player.x,1000,30).then(function(){
					currentScene.goToScene8();
	    		});
	    	}
		},
		goToScene8: function(){
			var scene = new Scene8();
			game.replaceScene(scene);
		}
	});

//SCENE 8
	var Scene8 = Class.create(Scene, {
	    initialize: function() {
			//Scene vars
			var player;

			//Scene init
	    	Scene.apply(this);
        	var game = Game.instance;

 	      	player = new Player(350,-100);
        	this.player = player;

        	var labelGameOver;
        	labelGameOver = new Label("To be continued...");
        	labelGameOver.x = 330;
        	labelGameOver.y = 300;
			labelGameOver.color = itemTextColor;
	       	labelGameOver.font = bannerFont;
	        this.labelGameOver = labelGameOver;
	        this.labelGameOver.visible = false;

        	//loads scene bg
        	bg = new Sprite(800,600);
			bg.image = game.assets['res/scene_bg/scene_bg8.png'];
        	bg.x = bg.y = 0;

		////APPEND TO SCENE

			//adds scene background
			this.addChild(bg);

			//adds player to the scene
        	this.addChild(player);

        	this.addChild(labelGameOver);

	        currentScene = this;
	        this.falling = false;
	    },
	    onenterframe: function(evt) { 
	    	if (!this.falling){
	    		this. falling = true;
	    		this.player.tl.delay(5).moveTo(this.player.x,1000,18).delay(15).then(function(){
					currentScene.labelGameOver.visible = true;
	    		});
	    	}
		},
		goToScene9: function(){
			var scene = new Scene9();
			game.replaceScene(scene);
		}
	});


    //CLASSES
    var Player = Class.create(Sprite, {
    	initialize : function(x,y) {
    		Sprite.apply(this,[80, 150]);
	        this.image = Game.instance.assets['res/player/player.png'];
	        this.x = x;
	        this.y = y;
	        this.moveSpeed = 0;

	        //animate
	        this.animationDuration = 0;

	        this.moving = false;
	        this.facingRight = true;
    	},
    	onenterframe: function(evt) {
			//animation
			if (this.moving){
				this.animationDuration += evt.elapsed * 0.001;       
		        if (this.animationDuration >= playerSpriteSpeed) {
		        	if (this.facingRight){
		        		if (this.frame > 2){
		        			this.frame = 0;
		        		}else
		        	   	if (this.frame == 0){
		        			this.frame = 1;
		        		}else if (this.frame == 1){
		        			this.frame = 2;
		        		}else if (this.frame == 2){
		        			this.frame = 1;
		        		}
		        	}else{
		        		if (this.frame < 4){
		        			this.frame = 4;
		        		}else
		        		if (this.frame == 4){
		        			this.frame = 5;
		        		}else if (this.frame == 5){
		        			this.frame = 6;
		        		}else if (this.frame == 6){
		        			this.frame = 5;
		        		}
		        	}
	
		            this.animationDuration -= playerSpriteSpeed;
		        }
			}else{
				if (this.facingRight){
					this.frame = 0;	
				}else{
					this.frame = 4;
				}
				
				this.animationDuration = 0;
			}
    	},
    	faceRight: function(bool){
    		this.facingRight = bool;
    	}
    });
};

