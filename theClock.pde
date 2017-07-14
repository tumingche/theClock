/*
Data Visualization: The Clock
By Ming Tu, DIET, Harvard Art Museums
Spring, 2015

Data from Harvard Art Museums API
http://api.harvardartmuseums.org/object?size=100&page=6&gallery=any&color=any&classification=any&accessionyear=any&datebegin=any&totalpageviews=any&exhibitioncount=any&publicationcount=any&sort=accessionyear&fields=title,classification,accessionyear,datebegin,totalpageviews,exhibitioncount,publicationcount,primaryimageurl,colors&apikey=fea7e8c0-088f-11e4-b359-096cc3102188

2015 Cambridge Science Festival
2015 Art, Technology, Psyche
2015 SIGHTLines: obJECT

- Press and drag the mouse to rotate the visualization
- Move the mouse in the 3D space to pick and reveal more information of the selected objects
- Scroll to zoom in/out
- Press key 1 to toggle the explanation mode (Start from the first object)  
        key 2 to display the second object
        key 3 to toggle the thread
        key UP to add objects
        key DOWN to reduce objects
        key 8 to toggle the timeline
        key 9 to toggle the year information (accessionyear and datebegin)
        key 0 or SPACE to toggle the mockup view of Lightbox Gallery 

Use the implemented alarm clock to interact with the data visualization
*/


import java.net.*;
import java.awt.event.KeyEvent;
import peasy.*;
import processing.opengl.*;


String baseURL = "http://api.harvardartmuseums.org/object?";
String apiKey = "fea7e8c0-088f-11e4-b359-096cc3102188";
String size = "size=100";
String page = "page=6";
String filters = "gallery=any&color=any&accessionyear=any&datebegin=any&totalpageviews=any&exhibitioncount=any&publicationcount=any";
String fields = "fields=objectid,title,classification,accessionyear,datebegin,totalpageviews,exhibitioncount,publicationcount,colors,gallery";
String sort = "sort=accessionyear";
String classification = "classification=any";

int[] output_1;
int[] output_2;
int[] output_3;
String[] output_4;
int[] output_5;
int[] output_6;
String[] output_7;

JSONObject myAPI;
JSONArray myRecords;
JSONArray myColors;

color primaryColor;

public float boxSize = 400;

boolean showTimeline = true;        
boolean showObjectYears = true;     
boolean showObjectLine_1 = false;
boolean showObjectLine_2 = true;    
boolean show_05 = false;
boolean show_intro_1 = false;
boolean show_intro_2 = false;

int nCircles = 100;
Circle circles[] = new Circle[nCircles];

PeasyCam cam;
float[] rotations = new float[3];

PFont myFont_1;
PFont myFont_2;

PImage img_05;

PShape myEllipse_1;
PShape myEllipse_2;

PGraphicsOpenGL pg;
Circle picked = null;
boolean mouseOver = false;

float transPos_x= 0, transPos_y=0, a;

float bacPos = -1.24;  //0
float speed;
float timeMoved;
float period = 2000;

int c;




void setup()
{
  //fullScreen(P3D, SPAN);  //for Processing 3
  //size(5760, 3240, OPENGL);  //for Lightbox video wall
  size(displayWidth, displayHeight, OPENGL);  //for laptop/desktop display
  frame.setLocation(0, 0);

  cam = new PeasyCam(this, 700);   
  cam.setMinimumDistance(1);       
  cam.setMaximumDistance(3000);    
  cam.setWheelScale(.4);           
  
  rotations = cam.getRotations();

  String apiURL = baseURL + "apikey=" + 
    apiKey + "&" + 
    size + "&" + 
    page + "&" +
    classification + "&" +
    filters + "&" +
    sort + "&" +
    fields; 

  myAPI = loadJSONObject(apiURL); 
  myRecords = myAPI.getJSONArray("records");

  output_1 = new int[myRecords.size()];
  output_2 = new int[myRecords.size()];
  output_3 = new int[myRecords.size()];
  output_4 = new String[myRecords.size()];
  output_5 = new int[myRecords.size()];
  output_6 = new int[myRecords.size()];
  output_7 = new String[myRecords.size()];


  for (int i=0; i< myRecords.size (); i++) 
  {
    JSONObject objectX = myRecords.getJSONObject(i);

    output_1[i] = objectX.getInt("accessionyear");
    output_2[i] = objectX.getInt("datebegin");
    output_3[i] = objectX.getInt("totalpageviews");
    output_4[i] = objectX.getString("title");
    output_5[i] = objectX.getInt("exhibitioncount");
    output_6[i] = objectX.getInt("publicationcount");
    output_7[i] = objectX.getString("classification");

    myColors = objectX.getJSONArray("colors");
    primaryColor = unhex("FF" + myColors.getJSONObject(0).getString("color").substring(1));
    
    println(primaryColor + ", " + output_1[i] + ", " + output_2[i] + ", " + output_3[i]+ ", " + output_4[i] + ", " + output_5[i] + ", " + output_6[i] + ", " + output_7[i]);
    circles[i] = new Circle(
                            (map(output_3[i], 0, 800, 0, boxSize/2))*cos(i*PI/50), 
                            (map(output_3[i], 0, 800, 0, boxSize/2))*sin(i*PI/50), 
                            map(output_1[i], -2000, 2000, -boxSize/2, boxSize/2), 
                            2*cos(i*PI/50), 
                            2*sin(i*PI/50), 
                            map(output_2[i], -2000, 2000, -boxSize/2, boxSize/2), 
                            output_4[i], 
                            output_7[i], 
                            map(output_5[i]+output_6[i], 0, 211, 0.002, 0.1), ////0.03 - 0.005
                            primaryColor,   //origColor(),
                            0xff000000 + i
                           );
  }
  myFont_1 = createFont("SansSerif", 36);
  myFont_2 = createFont("Arial Italic", 36);
  textFont(myFont_1);
   
  img_05 = loadImage("05.png");
  
  myEllipse_1 = createShape(ELLIPSE, 0, 0, boxSize, boxSize);
  myEllipse_2 = createShape(ELLIPSE, 0, 0, 20, 20);
  
  pg = (PGraphicsOpenGL)createGraphics(width, height, OPENGL);
  
  timeMoved = -period;
}




void draw()
{
  //background(2, 0, 8);
  background(74);

  rotateY(bacPos);
  bacPos += speed;
  speed = .005;
  
  pushMatrix();
  //lights();

  picked = pickCube(mouseX, mouseY);

  if (showObjectYears)  drawObjectYears();
 
  for (int i = 0; i < myRecords.size (); i++)  circles[i].render();
  
  if (picked != null) 
  {
    cam.beginHUD();  
    textSize(20); 
    fill(picked.col);
    text(picked.myClassification + "  |  " + picked.myTitle, width/2-300, height-80);
    cam.endHUD();
  } 
  else
  {
    cam.beginHUD();  
    fill(255);
    cam.endHUD();
  }  
  
  popMatrix(); 

  myRotate();
  
  if (showTimeline)   drawTimeline();
  if (show_intro_1)  draw_intro_1();

  cam.beginHUD();  
  if (show_05)  draw_img_05();
  cam.endHUD();

  cam.beginHUD();   
  fill(200);
  textSize(20);
  frame.setTitle(int(frameRate) + " fps"); 
  cam.endHUD();
}


int hoverColor() 
{
  return color(255, 0, 0);
}
int origColor() 
{
  return color(255, 255, 255, 120);
}



Circle pickCube(int x, int y) 
{
  Circle cube = null;

  pg.beginDraw();
  pg.camera.set(((PGraphicsOpenGL)g).camera);
  pg.projection.set(((PGraphicsOpenGL)g).projection);
  pg.noLights();
  pg.noStroke();
  pg.background(255);
  pg.rotateY(bacPos);
  
  for (int i = 0; i <  myRecords.size (); i++)  circles[i].displayForPicker();
  int c = pg.get(x, y);

  pg.endDraw();

  for (int i = 0; i <  myRecords.size (); i++) 
  {
    if (circles[i].pickCol == c) 
    {
      cube = circles[i];
      circles[i].update();
      mouseOver = true;
      break;
    } else
    { 
      //println(mouseOver);
    }
  }
  return cube;
}

