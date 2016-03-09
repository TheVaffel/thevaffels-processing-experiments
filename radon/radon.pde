PImage img;
int count = 0;

int w = 400;
int h = 400;

void setup(){
  size(800, 400);
  frameRate(60);
  background(0);
  img = loadImage("autumn.jpg");
}

void setPixel(int x, int y, color c){
  pixels[y*width + x] = c;
}

color getPixel(int x, int y){
   return pixels[y*width + x]; 
}

int[][] accumulations = new int[3][w*h];

double ma = 200000.0/255;
float mr = 0;

void draw(){
  
  //background(0);
  
  image(img, 0, 0, 400, 400);
  
  /*stroke(255,255,255);
  for(int i = 0; i< 10; i++){
     line(0,(i+1)*20, w, (i + 1)*20); 
  }*/
  if(count == 0){
    count ++;
    return;
  }
  count++;
  

  loadPixels();
  /*for(int j = w; j < w + 10; j++){
    float v = (j-w)*PI/w;
    float vc = v + PI/2;
    
    float cvc = cos(vc);
    float svc = sin(vc);
    for(int i = 0; i< h; i++){
      if(abs(cvc) > abs(svc)){
        
        float cx = w/2 + svc*(j - w/2);
        float cy = h/2 + cvc*(i - h/2);
        
        cy -= svc*cx;
        for(int k = 0; k < w; k++){
            if(cy + k*cvc<h && cy + k*cvc >= 0){
            accumulations[0][(int)(i*w + j-w)] += getPixel(k,(int)(cy + k*cvc))&255;
            accumulations[1][(int)(i*w + j-w)] += (getPixel(k, (int)(cy+ k*cvc))>>8)&255;
            accumulations[2][(int)(i*w + j-w)] += (getPixel(k, (int)(cy + k*cvc))>>16)&255;
          }
        }
      }else{
        float cx = w/2 + svc*(j - w/2);
        float cy = h/2 + cvc*(i - h/2);//Cartesian coordinates!
         
        cx -= cvc*cy;
        for(int k = 0; k < h; k++){
          if(cx + k*svc<w && cx + k*svc >= 0){
            accumulations[0][(int)(i*w + j-w)] += getPixel((int)(cx + k*svc), k)&255;
            accumulations[1][(int)(i*w + j-w)] += (getPixel((int)(cx + k*svc), k)>>8)&255;
            accumulations[2][(int)(i*w + j-w)] += (getPixel((int)(cx + k*svc), k)>>16)&255;
          }
        }
      }
    }
  }
  
  float ma = 0;
  
  
  for(int i = 0; i< w*h;i++){
    accumulations[0][i] = (int)(accumulations[0][i]);
    accumulations[1][i] = (int)(accumulations[1][i]);
    accumulations[2][i] = (int)(accumulations[2][i]);
    ma = max(max(ma ,accumulations[0][i], accumulations[1][i]), accumulations[2][i]);
  }
  
  
  println(ma);
  ma /= 255;
  for(int i = 0; i< w*h; i++){
    pixels[(i/w)*w*2 + (i)%w + w] = color((((int)(accumulations[0][i]/ma)&255)) , (((int)(accumulations[1][i]/ma)&(255))<<8) , (((int)(accumulations[2][i]/ma)&(255))<<16));
  }
  
  */
  
  if(count > w){
    
    drawPointer();
    return;
  }
  if(count == w){
      println(mr);
      ma = mr/255;
    }
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
          accumulations[0][val*w + k] += blue(pixels[i*w + j]);
          accumulations[1][val*w + k] += green(pixels[i*w + j]);
          accumulations[2][val*w + k] += red(pixels[i*w + j]);
        }
      }
    }
  }
  
  
  for(int i = 0; i<3; i++){
    for(int j = 0; j < w*w;j++){
      mr = max(mr, (float)(accumulations[i][j]));
    }
  }
  
  //println(mr);
  
  //ma /= 255;
  
  /*for(int i = 0; i<3; i++){
    for(int j = 0; j < h;j++){
      for(int k = 0; k < w; k++){
        accumulations[i][j*w + k]= (int)((accumulations[i][j*w + k]/ma));
      }
      
    }
  }*/
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
    float a = (mouseX - w)*PI/w;
    float ca = cos(a);
    float sa = sin(a);
    
    line(w/2, h/2, w/2 + w/2*ca, h/2 + w/2*sa);
  }
}