//PICTURE
PImage sky, soil, life, soldier, cabbage;
PImage  groundhogIdle, groundhogDown, groundhogLeft, groundhogRight;
PImage startNormal, startHovered, title, gameover, restartHovered, restartNormal;

//soldier x y
int soldierX;
int soldierY;

/*
 //robot x y
 PImage robot;
 int robotX, robotY;
 
 //lazerx,xx,y
 int lazerX;
 int lazerXX, lazerY;
 int lazerLimit;
 
 */
//GAMESTATE
final int GAME_START = 0;
final int GAME_RUN = 1;
final int GAME_LOSE = 2;
int gameState = GAME_START;

//game life
final int LIFE_START=2;
final int LIFE_ADD=3;
final int LIFE_MI=1;
int gameLife=LIFE_START;

//cabbage x y
float cabbageX, cabbageY;

//BOTTON
final int BUTTON_TOP = 360;
final int BUTTON_BOTTOM = 420;
final int BUTTON_LEFT = 248;
final int BUTTON_RIGHT = 392;

boolean downPressed, rightPressed, leftPressed;
//groundhog x,y
float groundhogX, groundhogY;
float groundhogSize=80;
float groundhogSpeed=80;

void setup() {
  size(640, 480, P2D);
  sky=loadImage("img/bg.jpg");
  soil=loadImage("img/soil.png");
  groundhogIdle=loadImage("img/groundhogIdle.png");
  soldier=loadImage("img/soldier.png");
  startNormal=loadImage("img/startNormal.png");
  startHovered=loadImage("img/startHovered.png");
  restartNormal=loadImage("img/restartNormal.png");
  restartHovered=loadImage("img/restartHovered.png");
  title=loadImage("img/title.jpg");
  groundhogDown=loadImage("img/groundhogDown.png");
  groundhogLeft=loadImage("img/groundhogLeft.png");
  groundhogRight=loadImage("img/groundhogRight.png");
  gameover=loadImage("img/gameover.jpg");
  //cabbage randomx y
  cabbage=loadImage("img/cabbage.png");
  cabbageX=floor(random(0, 8))*80;
  cabbageY=160+floor(random(0, 4))*80;
  //soldier random y
  soldierY=160+floor((random(160, 480))%4)*80;
  //ground start place
  groundhogX=320;
  groundhogY=80;
  frameRate=60;
  //life
  life=loadImage("img/life.png");
  /*
  robot=loadImage("img/robot.png");
   //robot random x y
   robotX=160+floor(random(0, 6))*80;
   robotY=160+floor((random(160, 480))%4)*80;
   
   lazerX=robotX+25;
   lazerXX=robotX+25;
   lazerY=robotY+37;
   lazerLimit=lazerX-160-25;
   */
}

void draw() {
  // Switch Game State
  switch(gameState) {
  case GAME_START:
    image(title, 0, 0);
    if (mouseX > BUTTON_LEFT && mouseX < BUTTON_RIGHT
      && mouseY > BUTTON_TOP && mouseY < BUTTON_BOTTOM) {
      image(startHovered, 248, 360);
      if (mousePressed) {
        gameState = GAME_RUN;
      }
    } else {
      image(startNormal, 248, 360);
    }
    break;

  case GAME_RUN:
    image(sky, 0, 0);
    image(soil, 0, 160);
    //cabbage
    image(cabbage, cabbageX, cabbageY);
    //grass
    noStroke();
    fill(124, 204, 25);
    rect(0, 145, width, 15);
    //sun
    stroke(255, 255, 0);
    fill(253, 184, 19);
    strokeWeight(5);
    ellipse(590, 50, 120, 120);

    //soldier walking
    soldierX+=4;
    image(soldier, soldierX, soldierY);
    if (soldierX >= width) {
      soldierX = -80;
    }
    soldierX%=width;

    //groundhog walking
    if (downPressed) {
      image(groundhogDown, groundhogX, groundhogY);
      if ( groundhogY+groundhogSize>height)groundhogY=height-groundhogSize;
    } else if (leftPressed) {
      image(groundhogLeft, groundhogX, groundhogY);
      if (groundhogX<0)groundhogX=0;
       if (groundhogX+groundhogSize>width)groundhogX=width-groundhogSize;
    } else if (rightPressed) {
      image(groundhogRight, groundhogX, groundhogY);
      if (groundhogX+groundhogSize>width)groundhogX=width-groundhogSize;
       if (groundhogX<0)groundhogX=0;
    } else {
      image(groundhogIdle, groundhogX, groundhogY);
    }

    //life time
    switch(gameLife) {

    case LIFE_MI:
      //life*1
      image(life, 10, 10);
      if (soldierY<groundhogY+80&&soldierY+80>groundhogY) {
        if (soldierX<groundhogX+groundhogSize&&
          groundhogX < soldierX+80) {
          gameState=GAME_LOSE ;
        }
      } else if (cabbageY<groundhogY+80&&cabbageY+80>groundhogY) {
        if (cabbageX<groundhogX+groundhogSize&&
          cabbageX+80>groundhogX) {
          cabbageX=800;
          cabbageY=800;
          gameLife=LIFE_START;
        }
      }
      break;
    case LIFE_START:
      //life*2
      image(life, 10, 10);
      image(life, 80, 10);

      if (soldierY<groundhogY+80&&soldierY+80>groundhogY) {
        if (soldierX<groundhogX+groundhogSize&&
          groundhogX < soldierX+80) {
          groundhogX=320;
          groundhogY=80;
          gameLife=LIFE_MI;
        }
      }
      if (cabbageY<groundhogY+80&&cabbageY+80>groundhogY) {
        if (cabbageX<groundhogX+groundhogSize&&
          cabbageX+80>groundhogX) {
          cabbageX=800;
          cabbageY=800;
          gameLife=LIFE_ADD;
        }
      }
      break;


    case LIFE_ADD:
      //life*3
      image(life, 10, 10);
      image(life, 80, 10);
      image(life, 150, 10);
      if (soldierY<groundhogY+80&&soldierY+80>groundhogY) {
        if (soldierX<groundhogX+groundhogSize&&
          groundhogX < soldierX+80) {
          groundhogX=320;
          groundhogY=80;
          gameLife=LIFE_START;
        }
      }
      break;
    }

    /*
  image(robot, robotX, robotY);
     //robot place
     stroke(255, 0, 0);
     strokeWeight(10);
     line(lazerX, lazerY, lazerXX, lazerY);
     lazerX-=2;
     
     if (lazerX<=robotX+25-40) {
     lazerXX-=2;
     }
     //robot lazer
     if (lazerX<=lazerLimit) {
     lazerX=lazerX+80*2+25;
     lazerXX=robotX+25;
     }
     //robot lazer restart
     */
    break;
  case GAME_LOSE:
    image(gameover, 0, 0);
    if (mouseX > BUTTON_LEFT && mouseX < BUTTON_RIGHT
      && mouseY > BUTTON_TOP && mouseY < BUTTON_BOTTOM) {
      image(restartHovered, 248, 360);
      if (mousePressed) {
        groundhogX=320;
        groundhogY=80;
        cabbageX=floor(random(0, 8))*80;
        cabbageY=160+floor(random(0, 4))*80;
         soldierY=160+floor((random(160, 480))%4)*80;
        gameLife=LIFE_START;
        ;
        gameState = GAME_RUN;
      }
    } else {
      image(restartNormal, 248, 360);
    }
    break;
  }
}


void keyPressed() {
  if (key==CODED) {
    switch(keyCode) {
    case DOWN:
      groundhogY+=groundhogSpeed;
      downPressed=true;
      break;
    case LEFT:
      groundhogX-=groundhogSpeed;
      leftPressed=true;
      break;
    case RIGHT:
      groundhogX+=groundhogSpeed;
      rightPressed=true;
      break;
    }
  }
}

void keyReleased() {
  switch(keyCode) {
  case DOWN:
    downPressed=false;
    break;
  case LEFT:
    leftPressed=false;
    break;
  case RIGHT:
    rightPressed=false;
    break;
  }
}
