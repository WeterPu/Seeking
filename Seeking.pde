public Boid[] seekers;

public void setup(){
  size(1200, 700);
  frameRate(30);
  seekers = new Boid[60];
  for(int i = 0; i < seekers.length; i++)
    seekers[i] = new Boid((float)(Math.random() * width), (float)(Math.random() * height), (float)(Math.random() * 3 + 2), 5, .3);
}

public void draw(){
  background(255);
  fill(200);
  
  
  for(Boid b: seekers){
    if(mousePressed)
      b.applyForce(b.seek(mouseX, mouseY));
    b.applyForce(b.congregate(seekers));
    b.applyForce(b.align(seekers));
    b.update();
    b.display();
  }
}
