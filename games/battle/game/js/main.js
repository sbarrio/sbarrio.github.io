  /*
   - Battle - 
     by sbarrio 
     11/01/2014
   */

  enchant(); // initialize


  //Player vars
  var hull = 5;
  var enemyHull = 3;
  var moveSpeed = 4;
  var newEnemyTime = 1.5;
  var enemySpeed = 2;
  var bulletSpeed = -6;
  var enemyBulletSpeed = 5;
  var killPoints = 10;
  var fireSpeed = 0.5;
  var maxBullets = 5;  //5 balas a la vez como máximo
  var enemyFireSpeed = 2.5;
  var soundEnabled = true;

  var scoreLevel2 = 300;

    // 2 - On document load 
window.onload = function() {
    // 3 - Starting point
    var game = new Game(640, 480);
    // 4 - Preload resources
    if (soundEnabled){
        game.preload('res/bg.png',
         'res/ship.png',
         'res/ship2.png',
         'res/bullet.png',
         'res/audio/bang.wav',
         'res/audio/hit.wav',
         'res/audio/hurt.wav');
    }else{
            game.preload('res/bg.png',
             'res/ship.png',
             'res/ship2.png',
             'res/bullet.png');
    }

    // 5 - Game settings
    game.fps = 30;
    game.scale = 1;

    game.onload = function() {
        //key bindings
        game.keybind(65, 'b');
        game.keybind(83, 'a');
        game.keybind(32, 'space');

        // Once Game finishes loading
        var scene = new SceneTitle();
        game.replaceScene(scene);
    }
    // 7 - Start
    game.start();   


// SceneTitle
var SceneTitle = Class.create(Scene, {
    initialize: function(score) {
        var titleLabel, introLabel, bg, ship,animationDuration;
        Scene.apply(this);
        var game = Game.instance;
        
        bg = new Sprite(640,480);
        bg.image = game.assets['res/bg.png'];
        this.bg = bg;

        ship = new Sprite(64,64);
        ship.image = game.assets['res/ship.png'];
        ship.x = 300;
        ship.y = 100;
        this.ship = ship;
        animationDuration = 0;
        this.animationDuration = animationDuration;
        
        titleLabel = new Label("BATTLE");
        titleLabel.x = 170;
        titleLabel.y = 160;
        titleLabel.color = 'white';
        titleLabel.font = '40px strong';
        titleLabel.textAlign = 'center';
        this.titleLabel = titleLabel;

        introLabel = new Label("Press A to fire!");
        introLabel.x = 170;
        introLabel.y = 280;
        introLabel.color = 'white';
        introLabel.font = '22px strong Calibri, Candara, Segoe, Optima, Arial, sans-serif';
        introLabel.textAlign = 'center';
        this.introLabel = introLabel;

        //bg 
        this.addChild(bg);

        //ship
        this.addChild(ship);

        //add labels to scene
        this.addChild(titleLabel);
        this.addChild(introLabel);

        // Update
        this.addEventListener(Event.ENTER_FRAME, this.update);
    },
    update: function(evt){
        if (game.input.b){
            enemyFireSpeed = 2.5;
            enemySpeed=2;
            newEnemyTime = 1.5;
            game.replaceScene(new SceneGame());
            game.assets['res/audio/bang.wav'].play();
        }
        
        this.animationDuration += evt.elapsed * 0.001;       
        if (this.animationDuration >= 0.5) {
            this.ship.frame = (this.ship.frame + 1) % 2;
            this.animationDuration -= 0.5;
        }

    }
});

// SceneGame  
var SceneGame = Class.create(Scene, {
     // The main gameplay scene.     
    initialize: function() {
        var game, scoreLabel, hullLabel, chargeShotLabel, bg, ship, enemyGroup, bulletGroup, enemyBulletGroup;
 
        // 1 - Call superclass constructor
        Scene.apply(this);
        // 2 - Access to the game singleton instance
        game = Game.instance;
        // 3 - Create child nodes
        scoreLabel = new Label('KILLS<br>0');     
        scoreLabel.x = 10;
        scoreLabel.y = 10;
        scoreLabel.color = 'white';
        scoreLabel.font = '14px strong Calibri, Candara, Segoe, Optima, Arial, sans-serif';
        scoreLabel.textAlign = 'center';
        scoreLabel._style.textShadow ="-1px 0 black, 0 1px black, 1px 0 black, 0 -1px black";
        this.scoreLabel = scoreLabel;

        hullLabel = new Label('HULL<br>' + hull);
        hullLabel.x = 100;
        hullLabel.y = 10;
        hullLabel.color = 'white';
        hullLabel.font = '14px strong Calibri, Candara, Segoe, Optima, Arial, sans-serif';
        hullLabel.textAlign = 'center';
        hullLabel._style.textShadow ="-1px 0 black, 0 1px black, 1px 0 black, 0 -1px black";
        this.hullLabel = hullLabel;

        chargeShotLabel = new Label('BULLETS<br>' + hull);
        chargeShotLabel.x = 180;
        chargeShotLabel.y = 10;
        chargeShotLabel.color = 'white';
        chargeShotLabel.font = '14px strong Calibri, Candara, Segoe, Optima, Arial, sans-serif';
        chargeShotLabel.textAlign = 'center';
        chargeShotLabel._style.textShadow ="-1px 0 black, 0 1px black, 1px 0 black, 0 -1px black";
        this.chargeShotLabel = chargeShotLabel;

        bg = new Sprite(640,480);
        bg.image = game.assets['res/bg.png'];
        this.bg = bg;

        // 3b - Create ship node
        ship = new Ship(hull);
        ship.x = 560;
        ship.y = 280;
        this.ship = ship;

        // enemy group
        enemyGroup = new Group();
        this.enemyGroup = enemyGroup;

        //bulletGroup
        bulletGroup = new Group();
        this.bulletGroup = bulletGroup;

        //enemyBulletGroup
        enemyBulletGroup = new Group();
        this.enemyBulletGroup = enemyBulletGroup;

        // 4 - Add child nodes - LAYER ORDER IS RELEVANT
        //bg
        this.addChild(bg);  
         //sprites
        this.addChild(ship);
        // enemies
        this.addChild(enemyGroup);      
        // bullets
        this.addChild(bulletGroup);
        // enemyBullets
        this.addChild(enemyBulletGroup);
        //hud
        this.addChild(scoreLabel);
        this.addChild(hullLabel);
        this.addChild(chargeShotLabel);

        // Update
        this.addEventListener(Event.ENTER_FRAME, this.update);

        // Instance variables
        this.spawnEnemyTimer = 0;

        this.lastShotTimer = 0;

        this.score = 0;
    },
    update: function (evt) {
        
        // increases difficulty
        if (this.score > scoreLevel2){
            enemyFireSpeed = 1.5;
            enemySpeed=4;
            newEnemyTime = 0.7;
        }

        //Spawns new enemies
        this.spawnEnemyTimer += evt.elapsed * 0.001;
        if (this.spawnEnemyTimer >= newEnemyTime) {
            var enemy = new Enemy(10,Math.floor(Math.random()* 300) + 100);
            this.spawnEnemyTimer -= newEnemyTime;
            //add enemy to enemy array
            this.enemyGroup.addChild(enemy);
        }

        //shooting
        this.lastShotTimer += evt.elapsed * 0.001;
        if (this.lastShotTimer > maxBullets/2){
            this.lastShotTimer = maxBullets/2;
        }
        if(game.input.b & this.lastShotTimer >= fireSpeed){
            var bullet = new Bullet(this.ship.x,this.ship.y + 2*this.ship.height/3,bulletSpeed);
            this.bulletGroup.addChild(bullet);
            this.lastShotTimer -= fireSpeed;
            if (soundEnabled){
                game.assets['res/audio/bang.wav'].play();    
            }
            
        }

        //update bullets count
        var bullets = this.lastShotTimer*2;
        if (bullets > maxBullets){
            bullets = maxBullets;
        }
        bullets = Math.round(bullets);
        this.chargeShotLabel.text = 'BULLETS<br>' + bullets;  

        //Actions with enemies
        for (var i = this.enemyGroup.childNodes.length - 1; i >= 0; i--) {
            var enemy;
            enemy = this.enemyGroup.childNodes[i];
            // collision with player
            if (enemy.within(this.ship,40)){
                this.enemyGroup.removeChild(enemy);  
                this.ship.setHull(this.ship.hull -1);
                this.hullLabel.text = 'HULL<br>' + this.ship.hull;
                if (soundEnabled){
                    game.assets['res/audio/hurt.wav'].play();    
                }
                //no more hits -> game over
                if (this.ship.isPlayerDead()){
                    game.replaceScene(new SceneGameOver(this.score)); 
                }
                break;
            }
            // collision with player bullets
            for (var b = this.bulletGroup.childNodes.length -1; b >= 0; b-- ){
                var bullet = this.bulletGroup.childNodes[b];
                if (enemy.intersect(bullet)){
                    enemy.setHull(enemy.hull-1);
                    if (soundEnabled){
                        game.assets['res/audio/hit.wav'].play();    
                    }
                    if (enemy.isEnemyDead()){
                        this.enemyGroup.removeChild(enemy);    
                        this.setScore(this.score + killPoints);
                    }
                    this.bulletGroup.removeChild(bullet);
                }

                //removes bullet out of screen
                if (bullet.x <0){
                    this.bulletGroup.removeChild(bullet);
                }
            }

            //collision with enemyBullets

            //enemy shooting bullets
            enemy.lastTimeShot += evt.elapsed * 0.001;
            if (enemy.lastTimeShot >= enemyFireSpeed){
                var enemyBullet = new Bullet(enemy.x + enemy.width,enemy.y + 2*enemy.height/3,enemyBulletSpeed);
                this.enemyBulletGroup.addChild(enemyBullet);
                enemy.lastTimeShot -= enemyFireSpeed;
            }

            //dumps enemies out of screen
            if (enemy.x > 640){
                this.enemyGroup.removeChild(enemy);
                break;
            }

            //collisions with enemyBullets
            for (var b = this.enemyBulletGroup.childNodes.length -1; b >= 0; b-- ){
                var bullet = this.enemyBulletGroup.childNodes[b];
                if (this.ship.within(bullet,24)){
                    this.ship.setHull(this.ship.hull-1);
                    this.hullLabel.text = 'HULL<br>' + this.ship.hull;
                    if (soundEnabled){
                        game.assets['res/audio/hurt.wav'].play();    
                    }
                    this.enemyBulletGroup.removeChild(bullet);
                    if (this.ship.isPlayerDead()){
                        game.replaceScene(new SceneGameOver(this.score)); 
                    }

                }
                //bullet out of screen
                if (bullet.x>640){
                    this.enemyBulletGroup.removeChild(bullet);
                }
            }
        }
    },
    setScore: function(score) {
        this.score = score; 
        this.scoreLabel.text = 'KILLS<br>' + this.score;  
    }
});

// SceneGameOver  
var SceneGameOver = Class.create(Scene, {
    initialize: function(score) {
        
        var game = Game.instance;
        var gameOverLabel, scoreLabel, buttonLabel;
        Scene.apply(this);
        this.backgroundColor = 'black';
        // Game Over label
        gameOverLabel = new Label("GAME OVER");
        gameOverLabel.x = 170;
        gameOverLabel.y = 128;
        gameOverLabel.color = 'white';
        gameOverLabel.font = '32px strong Calibri, Candara, Segoe, Optima, Arial, sans-serif';
        gameOverLabel.textAlign = 'center';

        // Score label
        scoreLabel = new Label('SCORE<br>' + score);
        scoreLabel.x = 175;
        scoreLabel.y = 32;        
        scoreLabel.color = 'white';
        scoreLabel.font = '16px strong Calibri, Candara, Segoe, Optima, Arial, sans-serif';
        scoreLabel.textAlign = 'center';

        //buttonLabel
        buttonLabel = new Label("Press SPACE to try again!");
        buttonLabel.x = 165;
        buttonLabel.y = 200;
        buttonLabel.color = 'white';
        buttonLabel.font = '16px strong Calibri, Candara, Segoe, Optima, Arial, sans-serif';
        buttonLabel.textAlign = 'center';


        // Add labels
        this.addChild(gameOverLabel);
        this.addChild(scoreLabel);
        this.addChild(buttonLabel);

        //update
        this.addEventListener(Event.ENTER_FRAME, this.update);
    },
    update: function (evt) {
        if(game.input.space){
            //reset values
            enemyFireSpeed = 2.5;
            enemySpeed=2;
            newEnemyTime = 1.5;
            game.replaceScene(new SceneGame());
            if (soundEnabled){
                game.assets['res/audio/bang.wav'].play();    
            }
        }
        if(game.input.a){
            game.replaceScene(new SceneTitle());
        }
    }
});


// OBJECTS

 // ship
 var Ship = Class.create(Sprite, {
    // The player character.     
    initialize: function(hull) {
        // 1 - Call superclass constructor
        Sprite.apply(this,[64, 64]);
        this.image = Game.instance.assets['res/ship.png'];
        var hull = hull;
        this.hull = hull;
        //animate
        this.animationDuration = 0;
    },
    onenterframe: function(evt) {
        //console.log(this.x + " " + this.y);
        //animation
        this.animationDuration += evt.elapsed * 0.001;       
        if (this.animationDuration >= 0.25) {
            this.frame = (this.frame + 1) % 2;
            this.animationDuration -= 0.25;
        }
        
        //03 Player Controls
        if(game.input.left && !game.input.right){
            this.x -= moveSpeed;
        }
        else if(game.input.right && !game.input.left){
            this.x += moveSpeed;
        }
        if(game.input.up && !game.input.down){
            this.y -= moveSpeed;
        }
        else if(game.input.down && !game.input.up){
            this.y += moveSpeed;
        }


        // Collisions with screen border
        if (this.x > 640 - this.width){
            this.x = 640 -this.width;
        }
        if (this.x <  0){
            this.x =  0;
        }
        if (this.y > 480 - this.height){
            this.y = 480 -this.height;
        }
        if (this.y < 100){
            this.y = 100;
        }
    },
    setHull: function(hull) {
        this.hull = hull;
    },
    isPlayerDead: function() {
        if (this.hull <= 0){
            return true;
        }
        return false;
    }
});


 // enemy
var Enemy = Class.create(Sprite, {
    // The obstacle that the penguin must avoid
    initialize: function(ini_x,ini_y) {
        // Call superclass constructor
        Sprite.apply(this,[64, 64]);
        this.image  = Game.instance.assets['res/ship2.png'];

        //animate
        this.animationDuration = 0;

        this.x = ini_x;
        this.y = ini_y;      
        var hull = enemyHull;
        this.hull = hull;
        var lastTimeShot = enemyFireSpeed;
        this.lastTimeShot = lastTimeShot;
    },
    onenterframe: function(evt) {
        this.x += moveSpeed;
        this.animationDuration += evt.elapsed * 0.001;       
        if (this.animationDuration >= 0.25) {
            this.frame = (this.frame + 1) % 2;
            this.animationDuration -= 0.25;
        }
    },
    setHull: function(hull) {
        this.hull = hull;
    },
    isEnemyDead: function() {
        if (this.hull<= 0){
            return true;
        }
        return false;
    }
});

var Bullet = Class.create(Sprite, {
    // The obstacle that the penguin must avoid
    initialize: function(ini_x,ini_y,bulletSpeed) {
        // Call superclass constructor
        Sprite.apply(this,[10, 10]);
        this.image  = Game.instance.assets['res/bullet.png'];
        this.x = ini_x;
        this.y = ini_y;      
        var bulletSpeed = bulletSpeed;
        this.bulletSpeed = bulletSpeed;
    },
    onenterframe: function() {
        this.x += this.bulletSpeed;
    }
});


};