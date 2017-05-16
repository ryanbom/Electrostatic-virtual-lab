int cpx=800, cpy=350;
int cnx=300, cny=300;
int qp=120, qn=-120;
float[] F={0,0};
float K=8.99;
float x, y, dx, dy, dxn, dyn;
float d1, E1, E1x, E1y, d2, E2, E2x, E2y;
float EEx, EEy, EE, deltax, deltay;
float Dx,Dy,DD,F1x,F1y,FT;
float ll = 0.5;
float x2,y2;

//set up electric fields
ArrayList <Particle> particles = new ArrayList <Particle> ();

//set up electric charges
ArrayList <ElectricCharge> charges = new ArrayList <ElectricCharge> ();


void setup() {
  size(1000, 700, P2D);
  smooth(16);
  background(#3c4677);
  strokeWeight(0.75);

  
  while (particles.size () < 20000) { particles.add(new Particle()); }
}

float[] Force(){
    Dx=(cpx-cnx);
    Dy=(cpy-cny);
    DD=sqrt(Dy*Dy+Dx*Dx);
    FT=K*qp*qn/(DD*DD);
    F1x=FT*Dx/DD;
    F1y=FT*Dy/DD;
    F[0]=F1x;
    F[1]=F1y;
    return F;

}

void draw() {
  
  //Drawing the fluid dynamics
  if (frameCount % 5 == 0) {
    noStroke();
    fill(#3c4677, 15);
    rect(0, 0, width, height);
  }
  
  stroke(#9cadb5);
  for (Particle p : particles) {
    p.run();
  }
  
  
  float[] F=Force();
  x2=(F[0]*200);
  y2=(F[1]*200);
   println(x2,y2);
   line(cpx, cpy, cpx+x2,cpy+y2);
  pushMatrix();
  translate(cpx+x2,cpy+y2);
  float a = atan2(-x2, y2);
  rotate(a);
  line(0, 0, -10, -10);
  line(0, 0, 10, -10);
  popMatrix();
  
  for( ElectricCharge e : charges) {
   
    for (int i = 0; i < 100; i+=5) {
      fill(#FF0000, i/10); //change to color of its sign
      stroke(#000000);
      noStroke();
      ellipse(e.x_pos, e.y_pos, e.c_radius - i, e.c_radius - i);
  }
 
  }
}

Boolean ifSelect(){
  return false;
}

void mousePressed() {
  if (charges.size() < 2 && !ifSelect()) {
      ElectricCharge c = new ElectricCharge(10, 100, mouseX, mouseY);
      charges.add(c); 
  }
  
}