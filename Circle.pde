class Circle 
{
  float x_1, y_1, z_1;
  float x_2, y_2, z_2; 
  float xSpeed, ySpeed, zSpeed;
  float sphereSize_1, sphereSize_2;
  float scalePresent; 
  String myTitle;
  String myClassification;
  PShape mySphere_1, mySphere_2, myLine_1, objectLine, objectArea;
  float t, xoff, xoffPlus, noiseVal;
  PShape mySphere_1pg, mySphere_2pg, myLine_1pg, objectLine_pg;
  int col, pickCol;


  Circle(float xPos_1, float yPos_1, float zPos_1, float xPos_2, float yPos_2, float zPos_2, String nyTitle, String nyClassification, float xoffBlus, int colo, int pickColo) 
  {
    this.x_1 = xPos_1;
    this.y_1 = yPos_1;
    this.z_1 = zPos_1;
    this.x_2 = xPos_2;
    this.y_2 = yPos_2;
    this.z_2 = zPos_2;
    
    this.myTitle = nyTitle;
    this.myClassification = nyClassification;
    
    this.xoffPlus = xoffBlus;

    this.xSpeed = random(.15, .75);
    this.ySpeed = random(.15, .75);
    this.zSpeed = random(.15, .75);
    
    this.sphereSize_1 = random(2, 2);
    this.sphereSize_2 = random(2, 2);   //random(1, 1)
      
    this.scalePresent = random(1.1, 1.4);
    
    this.mySphere_1 = createShape(SPHERE, sphereSize_1);
    this.mySphere_2 = createShape(BOX, sphereSize_2);
    this.myLine_1 = createShape(LINE, x_1, y_1, z_1, x_2, y_2, z_2);
    this.objectLine = createShape();
    this.objectArea = createShape();
    
    this.mySphere_1pg = createShape(SPHERE, sphereSize_1);
    this.mySphere_2pg = createShape(BOX, sphereSize_2);
    this.myLine_1pg = createShape(LINE, x_1, y_1, z_1, x_2, y_2, z_2);
    this.objectLine_pg = createShape();
    
    this.col = colo;
    this.pickCol = pickColo;
    
    
    objectLine.beginShape();        
        this.t = 0;
        this.xoff = this.t;         
        for (float i = 0.0; i < abs(this.z_1-this.z_2); i+=.1)
        {
          this.noiseVal = noise(this.xoff);
          this.xoff += this.xoffPlus;  
          objectLine.vertex(
                            (this.x_1 - map(i, 0, abs(this.z_1-this.z_2), 0, (this.x_1-this.x_2))) * (1-1.2*noiseVal*sin(map(i, 0, abs(this.z_1-this.z_2), 0, PI))), 
                            (this.y_1 - map(i, 0, abs(this.z_1-this.z_2), 0, (this.y_1-this.y_2))) * (1-1.2*noiseVal*sin(map(i, 0, abs(this.z_1-this.z_2), 0, PI))),
                            this.z_1-i
                            );
        }
    objectLine.endShape();   
    
    objectArea.beginShape();
        objectArea.vertex(       0,        0, boxSize/2);
        objectArea.vertex(this.x_1 * this.scalePresent, this.y_1 * this.scalePresent, boxSize/2);
        this.t = 0;
        this.xoff = this.t;
        for (float i = 0; i < abs(boxSize/2 - this.z_1); i+=.1)
        {
          this.noiseVal = noise(this.xoff);
          this.xoff += this.xoffPlus;  
          objectArea.vertex(
                            (this.x_1 * this.scalePresent - map(i, 0, abs(boxSize/2 - this.z_1), 0, (this.x_1 * this.scalePresent - this.x_1))) * (1-0.15*noiseVal*sin(map(i, 0, abs(boxSize/2 - this.z_1), 0, PI))), 
                            (this.y_1 * this.scalePresent - map(i, 0, abs(boxSize/2 - this.z_1), 0, (this.y_1 * this.scalePresent - this.y_1))) * (1-0.15*noiseVal*sin(map(i, 0, abs(boxSize/2 - this.z_1), 0, PI))),
                            boxSize/2-i
                            );
        }
        objectArea.vertex(this.x_1, this.y_1, this.z_1);
        this.t = 0;
        this.xoff = this.t; 
        for (float i = 0.0; i < abs(this.z_1-this.z_2); i+=.1)        
        {
          this.noiseVal = noise(this.xoff);
          this.xoff += this.xoffPlus;  
          objectArea.vertex(
                            (this.x_1 - map(i, 0, abs(this.z_1-this.z_2), 0, (this.x_1-this.x_2))) * (1-1.2*noiseVal*sin(map(i, 0, abs(this.z_1-this.z_2), 0, PI))), 
                            (this.y_1 - map(i, 0, abs(this.z_1-this.z_2), 0, (this.y_1-this.y_2))) * (1-1.2*noiseVal*sin(map(i, 0, abs(this.z_1-this.z_2), 0, PI))),
                            this.z_1-i
                            );
        }
        objectArea.vertex(this.x_2, this.y_2, this.z_2);
        objectArea.vertex(       0,        0, this.z_2);
        objectArea.vertex(       0,        0, boxSize/2);
    objectArea.endShape(CLOSE);
    
    objectLine_pg.beginShape();        
        this.t = 0;
        this.xoff = this.t;  
        for (float i = 0.0; i < abs(this.z_1-this.z_2); i+=.1)       
        {
          this.noiseVal = noise(this.xoff);
          this.xoff += this.xoffPlus;  
          objectLine_pg.vertex(
                            (this.x_1 - map(i, 0, abs(this.z_1-this.z_2), 0, (this.x_1-this.x_2))) * (1-1.2*noiseVal*sin(map(i, 0, abs(this.z_1-this.z_2), 0, PI))), 
                            (this.y_1 - map(i, 0, abs(this.z_1-this.z_2), 0, (this.y_1-this.y_2))) * (1-1.2*noiseVal*sin(map(i, 0, abs(this.z_1-this.z_2), 0, PI))),
                            this.z_1-i
                            );
        }
    objectLine_pg.endShape();   
  }



  void update() 
  {    
    shape(objectArea);
    shape(objectLine);
   
    fill(col, 180);   
    textSize(11);
    textAlign(LEFT, CENTER);
    text(this.myTitle, this.x_1, this.y_1, (this.z_1 + 2));
  }

  

  void displayYears(int nyAccessionyear, int nyDatebegin) 
  {
    int myAccessionyear = nyAccessionyear;
    int myDatebegin = nyDatebegin;
    
    fill(col, 140);  
    textSize(9);    
    textAlign(LEFT, CENTER);
    text(myAccessionyear, this.x_1 + 5, this.y_1, this.z_1); 
    text(myDatebegin, this.x_2 + 5, this.y_2, this.z_2); 
  }


  void render() 
  {
    mySphere_1.setFill(color(col, 180));   
    mySphere_1.setStroke(false);
    mySphere_2.setFill(color(col, 180));   
    mySphere_2.setStroke(false);
    myLine_1.setStroke(color(col));        
    myLine_1.setStrokeWeight(1);
    myLine_1.setFill(false);
    objectLine.setStroke(color(col, 255)); 
    objectLine.setStrokeWeight(1);
    objectLine.setFill(false);
    objectArea.setFill(color(col, 160));   
    objectArea.setStroke(false);


    pushMatrix();
      translate(this.x_1, this.y_1, this.z_1);
      shape(mySphere_1);   
    popMatrix();
    pushMatrix();
      translate(this.x_2, this.y_2, this.z_2);
      shape(mySphere_2);
    popMatrix();
    
    if(showObjectLine_1) 
    {
      pushMatrix();
        shape(myLine_1);
      popMatrix();
    }
    if(showObjectLine_2) 
    {  
      pushMatrix();  
        shape(objectLine);
      popMatrix();
    }   
  }
  
  
  void displayForPicker() 
  {
    mySphere_1pg.setFill(color(pickCol));
    mySphere_1pg.setStroke(false);
    mySphere_2pg.setFill(color(pickCol));
    mySphere_2pg.setStroke(false);
    myLine_1pg.setStroke(color(pickCol));
    myLine_1pg.setStrokeWeight(20);
    objectLine_pg.setStroke(color(pickCol));
    objectLine_pg.setStrokeWeight(20);
     
    pg.pushMatrix();
      pg.translate(this.x_1, this.y_1, this.z_1);
      pg.shape(mySphere_1pg); 
    pg.popMatrix();  
    pg.pushMatrix();
      pg.translate(this.x_2, this.y_2, this.z_2);
      pg.shape(mySphere_2pg); 
    pg.popMatrix();   
    pg.pushMatrix();
    pg.popMatrix();  
    pg.pushMatrix();
      pg.shape(objectLine_pg);
    pg.popMatrix();   
  }
}

