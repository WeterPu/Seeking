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
      vel.y = Math.abs(vel.y) * -.75;
      acc.mult(0);
    }
    else if(pos.y <= 0){
      vel.y = Math.abs(vel.y) * 1;
      acc.mult(0);
    }
    if(pos.x >= width){
      vel.x = Math.abs(vel.x) * -.8;
      acc.mult(0);
    }
    else if(pos.x <= 0){
      vel.x = Math.abs(vel.x) * .8;
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
