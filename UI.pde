

void drawTimeline()
{
  myEllipse_1.setStroke(false);
  myEllipse_1.setFill(color(255, 8)); 
  myEllipse_1.setFill(color(0, 60));
  myEllipse_2.setFill(color(0, 60)); 
  myEllipse_2.setStroke(false);

  pushMatrix();
  translate(-boxSize/2, -boxSize/2, boxSize/2); 
  shape(myEllipse_1);
  popMatrix();  
  pushMatrix();
  translate(-20/2, -20/2, 0); 
  shape(myEllipse_2);
  popMatrix(); 
  pushMatrix();
  translate(-20/2, -20/2, -boxSize/2); 
  shape(myEllipse_2);
  popMatrix();

  noFill();
  stroke(255, 60);   
  strokeWeight(1);

  for (int i = 0; i<boxSize*2; i+=10)  
  {
    line(0, -3, boxSize/2-i, 0, 3, boxSize/2-i);
  }
  for (int i = 0; i<boxSize*2; i+=20)  
  {
    line(0, -5, boxSize/2-i, 0, 5, boxSize/2-i);
    fill(255, 50);
    textFont(myFont_2);
    textSize(4);   
    text(2000-i*10, 2, 0, boxSize/2-i);
    textFont(myFont_1);
  }
}


void drawTimelineTotalpageviews()
{
  noFill();
  stroke(255, 60);   
  strokeWeight(1);

  line(0, 0, boxSize/2, 0, 0, -boxSize/2); 
  for (int i = 0; i<boxSize*2; i+=10)  
  {
    line(0, -3, boxSize/2-i, 0, 3, boxSize/2-i);
  }
  for (int i = 0; i<boxSize*2; i+=20)  
  {
    line(0, -5, boxSize/2-i, 0, 5, boxSize/2-i);
  }  
  for (int i = 0; i<boxSize*2; i+=20)  
  {
    fill(255, 50);
    textFont(myFont_2);
    textSize(4);   //(2)
    text(2000-i*10, 2, 0, boxSize/2-i);
  }

  line(0, 0, boxSize/2, boxSize/2*cos(77*PI/50), boxSize/2*sin(77*PI/50), boxSize/2);
  
  for (int i = 0; i<boxSize/2; i+=5)  
  {
    line(i*cos(77*PI/50), i*sin(77*PI/50), boxSize/2+3, i*cos(77*PI/50), i*sin(77*PI/50), boxSize/2-3);
  }
  
  rotateY(1.58);
  fill(255, 200);
  textSize(12);
  text("year", boxSize/2, 20);
  text("totalpageviews", -boxSize/2, -boxSize/2);
  rotateY(-1.58);
}


void drawObjectYears()
{
  for (int i=0; i<myRecords.size (); i++)
  {
    circles[i].displayYears(output_1[i], output_2[i]);
  }
}


void draw_img_05()
{
  image(img_05, 0, 0, displayWidth, displayHeight);
}


void draw_intro_1()
{
  background(2, 0, 8);
  speed = 0;
  drawTimelineTotalpageviews();
  circles[79].render();
  
  rotateY(1.58);
  fill(circles[79].col, 180);
  textSize(16);
  text(circles[79].myTitle, circles[79].x_1-200, circles[79].y_1-60);
  textSize(12);
  text("classification: " + circles[79].myClassification, circles[79].x_1-200, circles[79].y_1-40);
  text("accessionyear: " + output_1[79], circles[79].x_1-200, circles[79].y_1-10);
  text("datebegin: " + output_2[79], circles[79].x_2+40, circles[79].y_2-20);
  rotateY(-1.58);
  
  if (show_intro_2)  draw_intro_2();

  for (int i = 0; i < (0+c); i++)
  {
    circles[i].render();
    speed = .005;
  }
}


void draw_intro_2()
{
  circles[78].render();
  
  rotateY(1.58);
  fill(circles[78].col, 120);
  textSize(16);
  text(circles[78].myTitle, circles[78].x_1-210, circles[78].y_1-40);
  textSize(12);
  text("classification: " + circles[78].myClassification, circles[78].x_1-210, circles[78].y_1-20);
  text("accessionyear: " + output_1[78], circles[78].x_1-210, circles[78].y_1-8);
  text("datebegin: " + output_2[78], circles[78].x_2-170, circles[78].y_2-14);
  rotateY(-1.58);
}


void mouseMoved()
{
  timeMoved = millis();
}


void myRotate()
{
  float elapsed = millis() - timeMoved;

  if (elapsed < period)  speed = 0;  
  
  cam.beginHUD();
  textSize(24);
  cam.endHUD();
}



void keyPressed()
{
  if (key == CODED) 
  {
    if (keyCode == UP) 
    {
      if (c >= 99) c = 99;
      else c++;
    } 
    else if (keyCode == DOWN) 
    {
      if (c <= 0) c = 0;
      else c--;
      ;
    }
  } 
  else 
  {
    if (key == '1')  show_intro_1 = !show_intro_1 ? true : false;
    if (key == '2')  show_intro_2 = !show_intro_2 ? true : false;
    if (key == '3')  showObjectLine_2 = !showObjectLine_2 ? true : false;
    if (key == '6')  //showObjectLine_1 = !showObjectLine_1 ? true : false;
    if (key == '8')  showTimeline = !showTimeline ? true : false;
    if (key == '9')  showObjectYears = !showObjectYears ? true : false;
    if (key == '0' || key == ENTER || key == ' ')  show_05 = ! show_05 ? true : false;
  }
}

///*
void init() 
 {
 frame.removeNotify();
 frame.setUndecorated(true);
 frame.addNotify();
 super.init(); 
 }
//*/
