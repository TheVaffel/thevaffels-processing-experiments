PImage img;
int count = 0;

int w = 400;
int h = 400;

void setup(){
  size(800, 400);
  frameRate(60);
  background(0);
  img = loadImage("picasso.jpg");
}

void setPixel(int x, int y, color c){
  pixels[y*width + x] = c;
}

color getPixel(int x, int y){
   return pixels[y*width + x]; 
}

int[][] accumulations = new int[3][w*h];

double ma = 200000.0/255;//Normalization, gets changed after the full Radon Transform is computed
float mr = 0;

void draw(){
  //if(!clicked){
    //return;
  //}
  background(0);
  
  
  image(img, 0, 0, 400, 400);
  
  stroke(0);
  
  if(count == 0){
    count++;
    return;
  }
  count++;
  
  loadPixels();
  
  
  if(count == w){
      println(mr);
      if(mr != 0){
        ma = mr/255;
      }
    }
  if(count < w){
  for(int k = count%w; k <= (count+1)%w; k++){
    float angle = k*PI/w;
        
    float ca = cos(angle);
    float sa = sin(angle);  
    for(int i = 0; i< h; i++){
      for(int j = 0; j < w; j++){
        
        int dx = j - w/2;
        int dy = -(i - h/2);
        
        int val = (int)(ca*dx + sa*dy + w/2);
        if(val>= 0 && val < h){
          accumulations[0][val*w + k] += blue(pixels[i*w*2 + j]);
          accumulations[1][val*w + k] += green(pixels[i*w*2 + j]);
          accumulations[2][val*w + k] += red(pixels[i*w*2 + j]);
        }
      }
    }
  }
  }
  
  
  for(int i = 0; i<3; i++){
    for(int j = 0; j < w*h;j++){
      mr = max(mr, (float)(accumulations[i][j]));
    }
  }
  
  for(int i = 0; i< h; i++){
    for(int j = 0; j < w ; j++){
      pixels[i*w*2 + j + w] = color((int)(accumulations[2][i*w + j]/ma) , (int)(accumulations[1][i*w + j]/ma), (int)(accumulations[0][i*w + j]/ma));
    }
  }
  
  
  updatePixels();
  
  drawPointer();
  
}
  
void drawPointer(){
  if(mouseX > w){
    float a = PI/2 - (mouseX - w)*PI/w;
    float ca = cos(a);
    float sa = sin(a);
    
    float x1 = w/2 - (w/2 - 10)*ca;
    float y1 = h/2 - (w/2 - 10)*sa;
    float x2 = w/2 + (w/2 - 10)*ca;
    float y2 = h/2 + (w/2 - 10)*sa;
    
     float offx = sa;
     float offy = -ca;
     
     float offxArr = (5)*sa - (5)*ca;
     float offyArr = (-5)*sa - ( 5)*ca; 
     
     float offxArr2 = -5*sa - 5*ca;
     float offyArr2 = -5*sa + 5*ca;
    
    stroke(255, 255, 0);
      line(x1 + (mouseY - w/2)*offx, y1 + (mouseY - w/2)*offy, x2 + (mouseY - w/2)*offx, y2 + (mouseY - w/2)*offy);
      line(x2 + (mouseY - w/2)*offx, y2 + (mouseY - w/2)*offy, x2 + (mouseY - w/2)*offx + offxArr, y2 + (mouseY - w/2)*offy + offyArr);
      line(x2 + (mouseY - w/2)*offx, y2 + (mouseY - w/2)*offy, x2 + (mouseY - w/2)*offx + offxArr2, y2 + (mouseY - w/2)*offy + offyArr2);
    
    line(x2 - w/2*offx, y2 - w/2*offy, x2 + w/2*offx, y2 + w/2*offy);
  }
}

boolean clicked = false;

void mousePressed(){
  clicked = true;
}