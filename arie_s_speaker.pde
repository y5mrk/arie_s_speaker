PImage backImage;
PFont font;
String typing = "";
String [] saved = new String[4];
float easingT = 0.04;

float [] x = new float [4];
float [] y = new float [4];
float [] targetY = new float [4];
float [] targetX = new float [4];
float [] dx = new float [4];
float [] dy = new float [4];
int num = 0;
float d=0;
int ten = 0;
int ct = 0;

boolean rotate = false;

PrintWriter writer;
void setup() {
  size(700, 440);
  backImage = loadImage("back.png");
  font = loadFont("Marion-Bold-200.vlw");

  for (int i=0; i<4; i++) {
    x[i]=750;
    y[i]=350;
    targetY[i] = y[i];
    targetX[i] = x[i];
    saved[i] = "";
  }
  textFont( font );
}

void draw() {
  if (num>3) {
    if (x[3]<210) {
      ct++;
    }
    if(ct>30){
      rotate = true;
      ct=0;
    }
  }
  background(255);     
  image(backImage, 0, 0); 

  if (rotate) {
    pushMatrix();
    translate(-100, -100);
    rotate(-radians(d));
    fill(0);
    for (int i=0; i<4; i++) {
      dx[i] = targetX[i] - x[i];
      x[i] += dx[i] * easingT;
      dy[i] = targetY[i] - y[i];
      y[i] += dy[i] * easingT;
      if (saved[i].length()<3) {
        textSize(300);
      } else if (saved[i].length()<5) {
        textSize(200);
      } else if (saved[i].length()<7) {
        textSize(100);
      } else if (saved[i].length()<10) {
        textSize(80);
      } else if (saved[i].length()<13) {
        textSize(50);
      } else {
        textSize(30);
      }
      textAlign(LEFT, CENTER);
      text(saved[i], x[i], y[i]);
    }
    popMatrix();
    d+=2.2;
  } else {
    fill(0);
    for (int i=0; i<4; i++) {
      dx[i] = targetX[i] - x[i];
      x[i] += dx[i] * easingT;
      dy[i] = targetY[i] - y[i];
      y[i] += dy[i] * easingT;
      if (saved[i].length()<3) {
        textSize(300);
      } else if (saved[i].length()<5) {
        textSize(200);
      } else if (saved[i].length()<7) {
        textSize(100);
      } else if (saved[i].length()<10) {
        textSize(80);
      } else if (saved[i].length()<13) {
        textSize(50);
      } else {
        textSize(30);
      }
      textAlign(LEFT, CENTER);
      text(saved[i], x[i], y[i]);
    }
  }
  if (d>90) {
    rotate = false;
    d=0;
    for (int i=0; i<4; i++) {
      saved[i] = "";
      targetX[i] = 750;
      targetY[i] = 350;
      num=0;
    }
  }

  fill(0, 0, 0, 100);
  rect(20, height-80, width-40, 60);
  fill(200, 200, 255);
  textSize(40);
  textAlign(LEFT, CENTER);
  text("TEXT", 60, height-50);
  fill(255);
  textSize(48);
  if (ten%50<25) {
    text("|", typing.length()*23+190, height-50);
  }
  fill(255);
  textSize(48);
  text(typing, 200, height-50);
  ten++;
}

int ty1 = 0;
int ty2 = 0;
void keyPressed() {
  if (key == '\n' ) {
    if (num>3) {
      num=0;
    }
    if (typing.length()>0) {

      if (num==0) {
        for (int i=0; i<4; i++) {
          saved[i] = "";
          x[i]=750;
          y[i]=350;
          targetY[i] = y[i];
          targetX[i] = x[i];
        }
        saved[0] = typing;
        targetY[0] = 120;
      } else {
        saved[num] = typing;
        if (saved[num-1].length()<3) {
          ty1 = 115;
        } else if (saved[num-1].length()<5) {
          ty1 = 80;
        } else if (saved[num-1].length()<7) {
          ty1 = 50;
        } else if (saved[num-1].length()<10) {
          ty1 = 40;
        } else {
          ty1 = 25;
        }
        if (saved[num].length()<3) {
          ty2 = 45;
        } else if (saved[num].length()<5) {
          ty2 = 40;
        } else if (saved[num].length()<7) {
          ty2 = 35;
        } else if (saved[num].length()<10) {
          ty2 = 30;
        } else {
          ty2 = 25;
        }
        targetY[num] = targetY[num-1]+ty1+ty2;
      }
      typing = "";
      x[num] = 750;
      y[num] = 350;
      targetX[num] = 200;
      num++;
    } else {
      rotate = true;
    }
  } else if (key == '\b') {
    if (typing.length()>0) {
      int len = typing.length();
      if (typing.equals("")) {
        typing = "";
      } else {
        typing = typing.substring(0, len-1);
      }
    }
  } else {
    typing = typing + key;
  }
}

