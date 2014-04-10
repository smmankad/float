//Class for random-no-repeat shape generation @ specified coordinates
//(c)Copyright 2009, Siddharth Mankad, Sunil Vallu and Aashka Shah
//(c)Copyright 2009, National Institute of Design, India.
//Version 0.1alpha
//Coded for the Interactive Wall by Team WIG2 for DP2: IIJS, Goa - 2010.

//DESIGNED FOR 20 ELEMENTS ONLY. MAKE CHANGES FOR USING MORE IMAGES :D


class randomShape
{
  PShape[] shapes; //the shape array declaration
  int[] toggle; //the shape toggle array declaration that will store 1 or 0;
  int tcount; //Will be used to determine if the array has been fully used up.
  color pix;

  randomShape()
  {
  }

  randomShape(String imagePrefix) //the main constructor - used for initialization of the object
  {
    shapes = new PShape[30];
    toggle = new int[30];
    this.pix=pix;

    for (int i = 0; i < 29; i++) {
      // Use nf() to number format 'i' into four digits
      String filename = imagePrefix + nf(i, 4) + ".svg";
      shapes[i] = loadShape(filename);
      toggle[i]=0; //first time set all toggles to 0 = image is fresh - unused.
    }


  }

  public void resettoggle() //used to clear all toggles
  {
    for(int i=0; i<29;i++)
    {
      toggle[i]=0;
    }
    tcount=0;
  }
  
  public void stripNColor(PShape sh)
  {
   
    sh.disableStyle();
  }


  public void fire(float x, float y, color pix)
  {
    this.pix = pix;
    int a=0; //for the while loop - a infinite toggle variable
    int r; //random value hold.
    if(tcount!=29) //check if all images have been used
    {
      while(a!=1) //run a loop continuously until a=1
      {
        r=int(random(29));  //Generate a random number between 0 and 9
        if(toggle[r]==1) //check if the particular image has been used or not
        {
          continue; //if it has, skip all remaining parts of the loop and go to next cycle.
        }
        else
        {
          stripNColor(shapes[r]);
          if(pix==#FFFFFF || tcount%2==0)
          {
            stroke(0,0,0);
            strokeWeight(random(.02,3));
        
            fill(255);
             
          }
          else
          {
            noStroke();
          
            fill(pix);
          }
          //translate(mouseX,mouseY);
          //scale(random(0.1,0.9));
          shape(shapes[r],x,y); //if shape hasnt been used, display @ (x,y)
          toggle[r]=1; //set usability toggle to 1 to avoid re-use
          tcount++; //increment the use counter
          a=1; //activate loop termination by enabling a=1;
        }
      }
    }
    else
    {
      resettoggle(); //if all elements have been used, clean all counters and toggles to allow re-use.
    }
  }
}






