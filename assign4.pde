PImage bg1;
PImage bg2;
PImage fighter;
PImage hp;
PImage treasure;
PImage end1,end2,start1,start2;
int bg1X,bg2X;
int hpX;
int treasureX,treasureY;
int firstEnemyX,firstEnemyY;
int fighterX,fighterY;

final int GAME_START=1,WAVE1=2,WAVE2=3,WAVE3=4,GAME_LOSE=5;
int gameState;

boolean upPressed = false;
boolean downPressed = false;
boolean leftPressed = false;
boolean rightPressed = false;
int fighterSpeed=5;

int enemySpace=60;

int enemyNbr1 = 5;
int enemyNbr2 = 8;
PImage [] enemy1 = new PImage[enemyNbr1];
PImage [] enemy = new PImage[enemyNbr2];
int [] enemyPos1 = new int[enemyNbr1];
int [][] enemyPos = new int[5][5];
int [] enemyX1 = new int[enemyNbr1];
int [] enemyY1 = new int[enemyNbr1];
int [] enemyX = new int[enemyNbr2];
int [] enemyY = new int[enemyNbr2];
final int NOBOMB = 0;
final int BOMB = 1;
PImage [] flame = new PImage[5];
int [] currentFrame = new int[5];
boolean trigger = false;
int [] flameX1 = new int[enemyNbr1];
int [] flameY1 = new int[enemyNbr1];
int [] flameX = new int[enemyNbr2];
int [] flameY = new int[enemyNbr2];

void setup () {
  size(640, 480) ;
  bg1 = loadImage("img/bg1.png");
  bg2 = loadImage("img/bg2.png");
  fighter = loadImage("img/fighter.png");
  hp = loadImage("img/hp.png");
  treasure = loadImage("img/treasure.png");
  start1 = loadImage("img/start1.png");
  start2 = loadImage("img/start2.png");
  end1 = loadImage("img/end1.png");
  end2 = loadImage("img/end2.png");
  
  bg1X = 640;
  bg2X = 0;
  
  hpX = 40;
  
  treasureX = floor(random(0,470));
  treasureY = floor(random(60,420));
  
   firstEnemyX = 0-firstEnemyX-5*enemySpace;
   firstEnemyY = floor(random(50,420));
  
  fighterX = 550;
  fighterY = 240;
  
  gameState = 1;
  
   for(int i=0; i<enemyNbr2; i++){
    enemy[i] = loadImage("img/enemy.png");
  }
  
   for(int i=0; i<enemyNbr1; i++){
    enemy1[i] = loadImage("img/enemy.png");
    currentFrame[i] = 0;
  }
  
  for(int i=0; i<5; i++){
    for(int j=0; j<5; j++){
      enemyPos[i][j] = NOBOMB;
    }
  }
  
  for(int i=0; i<5; i++){
      enemyPos1[i] = NOBOMB;
    }
  
   for(int i=0; i<5; i++){
    flame[i] = loadImage("img/flame"+(i+1)+".png");
  }
  frameRate(60);
}

void draw() {
  //background
  image(bg1,bg1X-640,0);
  image(bg2,bg2X-640,0);
  bg1X++;
  bg2X++;
  bg1X%=1280;
  bg2X%=1280;


  //fighter
  image(fighter,fighterX,fighterY);
  
  //hp
  fill(255,0,0);
  noStroke();
  rect(20,13,hpX,20,10);
  image(hp,10,10);
  
  //treasure hit
    image(treasure,treasureX,treasureY);
     if(fighterX <= treasureX+40 && fighterX>=treasureX-40 && fighterY <= treasureY+40 && fighterY>= treasureY-40){
          hpX += 20;
      treasureX=floor(random(0,470));
      treasureY=floor(random(60,420));
     }
  
  //enemy
  

  for(int i=0; i<8; i++){
     if(fighterX <= enemyX[i]+40 && fighterX>=enemyX[i]-40 && fighterY <= enemyY[i]+50 && fighterY>= enemyY[i]-50){
        hpX -= 40;
        for(int k=0; k<5; k++){
        for(int j=0; j<5; j++){
          enemyPos[k][j] = BOMB;
          enemyX[i] = -100;
          enemyY[i] = -100;
         }
       }
     }
  }
  
   for(int i=0; i<5; i++){
     if(fighterX <= enemyX1[i]+40 && fighterX>=enemyX1[i]-40 && fighterY <= enemyY1[i]+50 && fighterY>= enemyY1[i]-50){
        hpX -= 40;
       enemyPos1[i] = BOMB;
       flameX1[i] = enemyX1[i];
       flameY1[i] = enemyY1[i];
         }
       }
     
  switch(gameState){
     case GAME_START:
      image(start2,0,0);
      if(mouseX>200 && mouseX<460 && mouseY>375 && mouseY<415)
        if(mousePressed){
          gameState = WAVE1;
        }else{
          image(start1,0,0);
        }
 
    break;
    case WAVE1:  
      firstEnemyX += 3;
      for(int i=0; i<5; i++){
        if(enemyPos1[i] == NOBOMB){       
         image(enemy1[i],firstEnemyX+i*enemySpace,firstEnemyY);
         enemyX1[i] = firstEnemyX+i*enemySpace;
         enemyY1[i] = firstEnemyY;
        }else{
          if(frameCount % 6 == 0){
             currentFrame[i]++;
          }
          if(currentFrame[i] < 5){
            image(flame[currentFrame[i]],flameX1[i],flameY1[i]);
          }
           enemyX1[i] = -100;
           enemyY1[i] = -100;
      }
    }
   
        if(firstEnemyX>width){
        gameState = WAVE2;
        firstEnemyX=0-firstEnemyX+5*enemySpace;
        firstEnemyY=floor(random(50,300));
        for(int i=0; i<5; i++){
        enemyPos1[i] = NOBOMB;
        currentFrame[i] = 0;
    }
      }
       if(hpX<=0){
        gameState = GAME_LOSE;
        for(int i=0; i<5; i++){
        enemyPos1[i] = NOBOMB;
        currentFrame[i] = 0;
      }
       }
    
    break;
    case WAVE2:
      firstEnemyX += 3;
     for(int i=0; i<5; i++){
       if(enemyPos1[i] == NOBOMB){
        image(enemy1[i],firstEnemyX+i*enemySpace,firstEnemyY+i*enemySpace/2);
        enemyX1[i] = firstEnemyX+i*enemySpace;
        enemyY1[i] = firstEnemyY+i*enemySpace/2;
         }else{
         if(frameCount % 6 == 0){
             currentFrame[i]++;
          }
          if(currentFrame[i] < 5){
            image(flame[currentFrame[i]],flameX1[i],flameY1[i]);
          }
            enemyX1[i] = -100;
            enemyY1[i] = -100; 
       }
     }
       if(firstEnemyX>width){
        gameState = WAVE3;
        firstEnemyX=0-firstEnemyX+5*enemySpace;
        firstEnemyY=floor(random(50,150));
        for(int i=0; i<5; i++){
          enemyPos1[i] = NOBOMB;
          currentFrame[i] = 0;
    }
      }
       if(hpX<=0){
        gameState = GAME_LOSE;
        for(int i=0; i<5; i++){
          enemyPos1[i] = NOBOMB;
          currentFrame[i] = 0;
      }
       }
   break;
   case WAVE3:
     firstEnemyX += 3;
      enemyX[0] = firstEnemyX+0*enemySpace;
      enemyY[0] = firstEnemyY+2*enemySpace;
      enemyX[1] = firstEnemyX+1*enemySpace;
      enemyY[1] = firstEnemyY+1*enemySpace;
      enemyX[2] = firstEnemyX+2*enemySpace;
      enemyY[2] = firstEnemyY+0*enemySpace;
      enemyX[3] = firstEnemyX+3*enemySpace;
      enemyY[3] = firstEnemyY+1*enemySpace;
      enemyX[4] = firstEnemyX+4*enemySpace;
      enemyY[4] = firstEnemyY+2*enemySpace;
      enemyX[5] = firstEnemyX+1*enemySpace;
      enemyY[5] = firstEnemyY+3*enemySpace;
      enemyX[6] = firstEnemyX+2*enemySpace;
      enemyY[6] = firstEnemyY+4*enemySpace;
      enemyX[7] = firstEnemyX+3*enemySpace;
      enemyY[7] = firstEnemyY+3*enemySpace;    

   for(int i=0; i<5; i++){
     for(int j=0; j<5; j++){
       if(j==-i+2 || j==-i+6 || j==i-2 || j==i+2){
         if(enemyPos[i][j] == NOBOMB){
            image(enemy[i],firstEnemyX+i*enemySpace,firstEnemyY+j*enemySpace);
          }
      }
   }
   }
      
   if(firstEnemyX>width){
     gameState = WAVE1;
     firstEnemyX=0-firstEnemyX+5*enemySpace;
     firstEnemyY=floor(random(50,420));
     for(int i=0; i<5; i++){
       for(int j=0; j<5; j++){
        enemyPos[i][j] = NOBOMB;
        enemyPos1[i] = NOBOMB;
       }
     }
  }
   if(hpX<=0){
     gameState = GAME_LOSE;
     for(int i=0; i<5; i++){
       for(int j=0; j<5; j++){
        enemyPos[i][j] = NOBOMB;
        enemyPos1[i] = NOBOMB;
      }
     }
   }
 
   break; 
  case GAME_LOSE:
     image(end2,0,0);
     if(mouseX>200 && mouseX<440 && mouseY>300 && mouseY<350)
      if(mousePressed){
        gameState = WAVE1;
        hpX=40;
        fighterX=550;
        fighterY=240;
        treasureX=floor(random(0,470));
        treasureY=floor(random(60,420));  
       firstEnemyX=0-firstEnemyX-3*enemySpace;
       firstEnemyY=floor(random(50,420));
      }else{
        image(end1,0,0);
      }
   break;
  }
      //hp boundary
      if(hpX > 200){
        hpX = 200;  
      }
      if(hpX <= 0){
        hpX = 0;
      }
      
       //move
  if(upPressed){
    fighterY -= fighterSpeed;
  }
  if(downPressed){
    fighterY += fighterSpeed;
  }
  if(leftPressed){
    fighterX -= fighterSpeed;
  }
  if(rightPressed){
    fighterX += fighterSpeed;
  }
  
  //boundary
  if(fighterX<0){
    fighterX=0;
  }
  if(fighterX>590){
    fighterX=590;
  }
  if(fighterY<0){
    fighterY=0;
  }
  if(fighterY>430){
    fighterY=430;
  }
  }


void keyPressed(){
  if(key == CODED){
    switch(keyCode){
      case UP:
        upPressed = true;
        break;
      case DOWN:
        downPressed = true;
        break;
      case LEFT:
        leftPressed = true;
        break;
      case RIGHT:
        rightPressed = true;
        break;
    }
  }
}
void keyReleased(){
  if(key == CODED){
    switch(keyCode){
      case UP:
        upPressed = false;
        break;
      case DOWN:
        downPressed = false;
        break;
      case LEFT:
        leftPressed = false;
        break;
      case RIGHT:
        rightPressed = false;
        break;
    }
  }
}
