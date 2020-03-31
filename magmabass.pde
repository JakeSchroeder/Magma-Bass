import processing.sound.*;

SoundFile file;
Amplitude amp;
float angle = 0;
float w = 32;
float ma;
float maxD;
float ampValue = 0;

void setup() {
  size(800, 800, P3D);
  smooth(8);
  ma = atan(cos(QUARTER_PI));
  
  maxD = dist(100, 0, 200, 200);
  
  file = new SoundFile(this, "Clubbed to Death (Kurayamino Variation).mp3");
  
 amp = new Amplitude(this);
  file.play();
  amp.input(file);

}

void draw() {
  ampValue = amp.analyze();
  lights();
  //pointLight(0, 10, 100 * amp.analyze(), mouseX, mouseY, 50);
  //pointLight(255, 255, 0, mouseX, height / 2 + 75, 0);
  pointLight(255, 60, 0, width / 2, height / 2, 50);
  pointLight(255, 0, 0, -width / 2, -height / 2, 50);
  
  background(0);
  ortho(800, -800, -800, 800, -200, 2000);
  rotateX(-ma);
  rotateY(-QUARTER_PI);
  translate(width/2 + 75, height/2 - 75);

  for (int z = 0; z < height; z += w) {
    for (int x = 0; x < width; x += w) {
       
      pushMatrix();
      float d = dist(x, z, width / 2, height / 2);
      float offset = map(d, 0, maxD, -PI, PI);
      
      float a = angle + offset;
      float h = floor(map(sin(a), -1, 1, 100 * -ampValue, 600 * ampValue));
      //float h = floor(map(sin(a), -1, 1, 100, 400));
      
      translate(x - width / 2 + 100, 0, z - height / 2);
     
      //fill(redValue, 0, 0);
      specular(255,255,255);
    shininess(8.0);
    ambient(255,0,100);
      box(w, h, w);
      //rect(x - width / 2 + w / 2, 0, w - 2, h);
      popMatrix();
     
    }
  }
  

  angle -= 0.1 * ampValue;
}
