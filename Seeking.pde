import processing.sound.*;

public Boid[] seekers;

public void setup(){
  size(1200, 700);
  frameRate(30);
  seekers = new Boid[1];
  for(int i = 0; i < seekers.length; i++)
    seekers[i] = new SoundBoid((float)(Math.random() * width), (float)(Math.random() * height), (float)(Math.random() * 4 + 2), 5, .3, this);
}

public void draw(){
  background(255);
  fill(200);
  
  
  for(Boid b: seekers){
    if(mousePressed)
      b.applyForce(b.seek(mouseX, mouseY));
    b.applyForce(b.congregate(seekers));
    b.update();
    b.display();
  }
}
