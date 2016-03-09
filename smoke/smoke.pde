int rows = 40, cols = 40;
int w = 400, h = 400;

Vector[][] grid = new Vector[rows][cols];

int numparticles = 500;
Particle[] particles = new Particle[numparticles];

void setup(){
  size(400, 400);
 frameRate(30); 
 for(int i = 0; i < rows; i++){
    for(int j = 0; j < cols; j++){
       grid[i][j] = new Vector(random(1.0)*PI); 
    }
 }
 
 for(int i = 0; i< numparticles; i++){
   particles[i] = new Particle(color(random(255), random(255), random(255)), random(w), 0);
 }
}

class Vector{
  float x, y;
  Vector(float phi){
     x = cos(phi);
     y = sin(phi);
  }
}

class Particle{
 float posX, posY; 
 float speedX, speedY;
 color col;
 
 Particle(color c, float nx, float ny){
    posX = nx;
    posY = ny;
    col = c;
    speedX = speedY = 0;
 }
}

void draw(){
  background(0);
  loadPixels();
   for(int i = 0; i< numparticles; i++){
      int x = (int)(particles[i].posX/w * cols);
      int y = (int)(particles[i].posY/h * rows);
      
      Vector v = grid[y][x];
      
      particles[i].speedX += v.x*0.02;
      particles[i].speedY += v.y*0.02;
      particles[i].posX += particles[i].speedX;
      particles[i].posY += particles[i].speedY;
      if(particles[i].posX >= w){
       particles[i].posX -= w; 
      }
      if(particles[i].posY >= h){
       particles[i].posY -= h; 
       particles[i].speedY = 0;
      }
      if(particles[i].posX<0){
       particles[i].posX += w; 
      }
      if(particles[i].posY<0 ){
       particles[i].posY += h; 
      }
      
        /*pixels[((int)particles[i].posY*w) + (int)particles[i].posX] = particles[i].col;
        pixels[((int)particles[i].posY*w) + (int)particles[i].posX] = particles[i].col;
        pixels[((int)particles[i].posY*w) + (int)particles[i].posX] = particles[i].col;
        pixels[((int)particles[i].posY*w) + (int)particles[i].posX] = particles[i].col;*/
      stroke(particles[i].col);
      fill(particles[i].col);
      rect((int)particles[i].posX, (int)particles[i].posY, 4, 4);
   }
   //updatePixels();
}