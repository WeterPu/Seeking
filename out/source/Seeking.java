import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class Seeking extends PApplet {

public Boid[] seekers;

public void setup(){
  
  frameRate(30);
  seekers = new Boid[60];
  for(int i = 0; i < seekers.length; i++)
    seekers[i] = new Boid((float)(Math.random() * width), (float)(Math.random() * height), (float)(Math.random() * 3 + 2), 5, .3f);
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
class Ball{
  /*FEILDS*/
 
 /*
  *The PVectors are used to determine movement
  *The mass is used to calculate the effect of forces on acceleration
  *and also the size of the ball
  */
  protected PVector pos, vel, acc;
  public float mass;
 
  /*CONSTRUCTORS*/
 
 /*
  *Default construcor sets mass to 3
  */
 
  public Ball(){
    this(0, 0, 3);
  }
 
  /*sets the position vector and the mass*/
  public Ball(float x, float y, float m){
    pos = new PVector(x, y);
    vel = new PVector(0,0);
    acc = new PVector(0,0);
    mass = m;
  }
 
  /*MOVEMENT and DISPLAY*/
 
  /*Changes all vectors accordingly, resets the acceleration vector*/
  public void update(){
    loop();
    //bounce();
    
    vel.add(acc);
    pos.add(vel);
    acc.mult(0);
  }
 
 
 /* checks if ball is on edge, then flips the velocity accordindgly. use in update to be useful.*/
  private void bounce(){
    if(pos.y >= height){
      vel.y = Math.abs(vel.y) * -.75f;
      acc.mult(0);
    }
    else if(pos.y <= 0){
      vel.y = Math.abs(vel.y) * 1;
      acc.mult(0);
    }
    if(pos.x >= width){
      vel.x = Math.abs(vel.x) * -.8f;
      acc.mult(0);
    }
    else if(pos.x <= 0){
      vel.x = Math.abs(vel.x) * .8f;
      acc.mult(0);
    }
  }
  
  /* similar, just makes the border teleport/ will not check distances over the border!!!*/
  private void loop(){
    if(pos.y >= height){
      pos.y = 0;
    }
    else if(pos.y <= 0){
      pos.y = height;
    }
    if(pos.x >= width){
      pos.x = 0;
    }
    else if(pos.x <= 0){
      pos.x = width;
    }
  }
 
  /*changes acceleration based on strength of force and mass*/
  public void applyForce(PVector force){
    acc.add(PVector.mult(force, 1 / mass));
  }
 
  public void display(){
    circle(pos.x, pos.y, mass * 15);
  }
}
class Boid extends Ball{
  private float maxSpeed, maxForce;
  
  public Boid(float x, float y, float m, float s, float f){
    super(x, y, m);
    maxSpeed = s;
    maxForce = f;
  }
  
  public Boid(){
    super();
    maxSpeed = 5;
    maxForce = 1;
  }
  
  public PVector seek(float x, float y){
    PVector desired = PVector.sub(new PVector(x, y), pos);
    if(desired.mag() > 100)
      desired.setMag(maxSpeed);
    else
      desired.mult(.05f);
    PVector steer = PVector.sub(desired, vel);
    steer.limit(maxForce);
    return steer;
  }
  
  public PVector avoid(float x, float y){
    PVector desired = PVector.sub(new PVector(x, y), pos);
    desired.mult(-1);
    if(desired.mag() < 10)
      desired.setMag(maxSpeed);
    else
      desired.mult(.0005f);
    PVector steer = PVector.sub(desired, vel);
    steer.limit(maxForce);
    return steer;
  }
  
  public PVector align(Ball[] arr){
    PVector desired = new PVector(0, 0);
    int count = 0;
    for(Ball b: arr){
      float dist = PVector.sub(this.pos, b.pos).mag();
      if(dist > 0 && dist < 100){
        desired.add(b.vel);
        count++;
      }
    }
    if(count > 0)
      desired.div(count);
    else
      desired.set(this.vel);
    
    PVector steer = PVector.sub(desired, vel);
    steer.limit(maxForce);
    return steer;
  }
  
  public PVector congregate(Ball[] arr){
    PVector desired = new PVector(0, 0);
    int count = 0;
    for(Ball b: arr){
      float dist = PVector.sub(b.pos, this.pos).mag();
      if(dist > 0 && dist < 200){
        desired.add(PVector.sub(b.pos, this.pos));
        count++;
      }
    }
    if(count > 0)
      desired.div(count);
    else
      desired.set(this.vel);
    
    PVector steer = PVector.sub(desired, vel);
    steer.limit(maxForce);
    return steer;
  }
  
  @Override
  public void display(){
    pushMatrix();
    translate(pos.x, pos.y);
    float dir = vel.heading() + PI/2;
    rotate(dir);
    triangle(0, mass * -2.5f, mass * -2, mass * 2.5f, mass * 2, mass * 2.5f);
    popMatrix();
  }
}
  public void settings() {  size(1200, 700); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Seeking" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
