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
  if(isEndOfTheGame()) victory();
  b.display();
  f.move();
  if(isEndOfTheGame()) victory();
  f.display();
  
}

boolean isEndOfTheGame(){
 return dist((int)b.x+15,260,f.real_x,f.real_y) < 30 | dist((int)b.x+7,277,f.real_x,f.real_y) < 15;
 //Voir les points de contact...
}

void victory(){
  setup();
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
  double puissance=44200,x=0,v=0,Te=0.04,fuel=100,masse=24190,k=1000,longueur=2000,cf=500; 
  int h=0, hmax = 3 , hmin = -3;
  float ar=map(h, 0, hmax, 0, TWO_PI*(3/4)) - HALF_PI;
  float es;
  
  PImage chal=loadImage("chalutier.png");
  PImage tele=loadImage("telegraph.png");
  PImage ess=loadImage("essence.png");
  PFont params = createFont("Arial",16,true); 
  
  void move() {
    
    if(fuel > 0)
    {
      
      double frott = 500*v*v;
      if(v < 0)
      {
        frott = -frott;
      }
      v= v*0.9991736+0.073*h*puissance;
      x+= 0.039*v+0.0014*h*puissance;    
      
      println(frott);
    
      x+= Te*v;
      fuel -= abs(h)*Te*0.1;
      es = map((int)fuel, 0.0, 100.0, -HALF_PI/3, HALF_PI/3) - HALF_PI-0.15 ;   
    
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
    
    textFont(params,16);
    fill(0);  
    text("v="+(int)v+" m/s x="+(int)x,width/2,30);
    //Points de contact
    //ellipse((int)x+11,250,15,15);
    //ellipse((int)x+7,277,15,15);
    //ellipse((int)x+13,265,20,20);
    //ellipse((int)x+25,257,15,15);
    
    
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
  int x, y;
  int real_x, real_y;
  void move() {
    m += 0.01;
    t +=0.003;
    x = (int)(400+250*sin(t));
    y = (int)(280+40*sin(m));
    real_x = x+10;
    real_y = y+10;
  }
  void display() {
     fish.resize(20,0);
     image(fish,x,y);
     //ellipse(real_x,real_y,5,5);
  }
}




  





