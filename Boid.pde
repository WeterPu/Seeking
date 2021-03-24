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
      desired.mult(.05);
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
      desired.mult(.0005);
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
    triangle(0, mass * -2.5, mass * -2, mass * 2.5, mass * 2, mass * 2.5);
    popMatrix();
  }
}
