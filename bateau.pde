Boat b;
Fish f;

void setup() {
  size(768, 450);
  b = new Boat();
  f = new Fish();
}

void draw() {
  background(200);
  fill(10 ,105 , 148);
  rect(0, 200, width ,height-155);

  fill(0);
  rect(0, height-30, width, 30);
  
  //Bouton reset
  PImage reset_button = loadImage("reset.jpeg");
  reset_button.resize(30,30);
  image(reset_button,0,height-30);
  
  //Bouton pause
  PImage pause_button = loadImage("pause_button.jpeg");
  pause_button.resize(30,30);
  image(pause_button,30,height-30);
  
  b.move();
  b.display();
  f.move();
  f.display();
}

void keyPressed() {
  if (key == CODED){
    if (keyCode == LEFT)   b.machinesArrieres();
    if (keyCode == RIGHT)  b.machinesAvant();
  }
}

boolean overRect(int x, int y, int width, int height)  {
  if (mouseX >= x && mouseX <= x+width && 
      mouseY >= y && mouseY <= y+height) {
    return true;
  } else {
    return false;
  }
}

void mousePressed() {
  if (overRect(0, height-30, width, 30)) {
    setup();
  }
  else if(overRect(0, height-(30*2), width, 30*2)){
    //while(pause==true);
  }
}


class Boat { 
  double puissance=1,x=0,v=0,Te=0.04;
  int h=0, hmax = 3 , hmin = -3;
  float ar=map(h, 0, hmax, 0, TWO_PI*(3/4)) - HALF_PI;
  
  float fuel=100;
  float es;
  
  PImage chal=loadImage("chalutier.png");
  PImage tele=loadImage("telegraph.png");
  PImage ess=loadImage("essence.png");
  
  void move() {
    if(fuel > 0)
    {
    v+= 0.04*h*puissance;
    x+= Te*v;
    fuel -= abs(h)*Te;
    es = map(fuel, 0.0, 100.0, -HALF_PI/3, HALF_PI/3) - HALF_PI-0.15 ;   
    println(fuel);
    }

  }
  void display() {
    chal.resize(100,0);
    image(chal,(int)x,145);
    
    tele.resize(120,0);
    image(tele,width-120,0);
    
    ess.resize(120,0);
    image(ess,width-120-120,0);
    int cx = width-60;
    int cy = 60;
    int cex = width-60-120;
    int cey = 60;
    int radius = 42;
    int radius2 = 25;
    strokeWeight(4);
    arrow(cx,cy,(int)(cx+cos(ar)*radius),(int)(cy+sin(ar)*radius));
    strokeWeight(2);
    line(cex,cey,(int)(cex+cos(es)*radius2),(int)(cey+sin(es)*radius2));
    strokeWeight(1);
  }
  
  void machinesAvant()
  {
     if (h < hmax)
     {
       h++;
     }
     //Modifier le facteur si on modifie le hmax
     ar = map(-h, 0, hmax*3, 0, TWO_PI) - HALF_PI;
     
  }
  void machinesArrieres()
  {
     if(h> hmin)
     {
     h--;
     //Modifier le facteur si on modifie le hmax
     ar = map(-h, 0, hmax*3, 0, TWO_PI) - HALF_PI;
     
     }
  }
  

  
  
  void arrow(int x1, int y1, int x2, int y2) {
    
    line(x1, y1, x2, y2);
    pushMatrix();
    translate(x2, y2);
    float a = atan2(x1-x2, y2-y1);
    rotate(a);
    line(0, 0, -5, -5);
    line(0, 0, 5, -5);
    popMatrix();
    strokeWeight(1);
  } 
  

}

class Fish{  
  PImage fish=loadImage("fish.png");
  float m = 0.0;
  float t = 0.0;
  void move() {
    m += 0.1;
    t +=0.005;
  }
  void display() {
     fish.resize(20,0);
     image(fish,250*(1+sin(t)),280+30*sin(m));
  }
}




  




