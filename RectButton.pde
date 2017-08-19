
  class RectButton {
    int x1;
    int x2;
    int y1;
    int y2;
    String title;
    int ts; // Tamaño de letra
    boolean active = true;
    boolean ffseg; // firstFramePr seg.
    boolean ffoseg; // firstFrameOn seg.
    color cFillPressed = 100;
    boolean hide;
    boolean isDisplaying;
  
    RectButton (int tx1, int ty1, int tx2, int ty2, String ttitle) {
      x1 = tx1;
      x2 = tx2;
      y1 = ty1;
      y2 = ty2;
      title = ttitle;
      ts = 30;
    }
  
    RectButton (int tx1, int ty1, int tx2, int ty2, String ttitle, int tts) {
      x1 = tx1;
      x2 = tx2;
      y1 = ty1;
      y2 = ty2;
      title = ttitle;
      ts = tts;
    }
  
    // Puedo ponerle otra construcción para cambiar el color
    // de fondo o cosas así. En el futuro si es necesario.
  
    void display () {
      if (!hide) {
        stroke (180);
        fill(0);
        if (pressed ()) {
          fill (cFillPressed);
        }
        rect (x1, y1, x2-x1, y2-y1);
        textAlign (CENTER);
        textSize (ts);
        fill (200);
        if (ts >= 15) {
          text (title, (x1+x2)/2, (y1+y2)/2+10+ts/5);
        } else {
          text (title, (x1+x2)/2, (y1+y2)/2+ts/3);
        }
        textAlign (LEFT);
      }
    }
  
    boolean pressed () {
      if (active) {
        if (x1 < mouseX && mouseX < x2 && y1 < mouseY && mouseY < y2 && mousePressed) {
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    }
    
    boolean on () {
      if (active) {
        if (x1 < mouseX && mouseX < x2 && y1 < mouseY && mouseY < y2) {
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    }
    
    boolean onFirstFramePressed () {
      boolean r = false;
      if (active) {
        if (pressed ()) {
          if (!ffseg) {
            ffseg = true;
            r = true;
          }
        } else {
          ffseg = false;
        }
      }
      return r;
    }
    
    boolean onFirstFrameOn () {
      boolean r = false;
      if (active) {
        if (on ()) {
          if (!ffoseg) {
            ffoseg = true;
            r = true;
          }
        } else {
          ffoseg = false;
        }
      }
      return r;
    }
    
    boolean isActive () {
      return active;
    }
    
    boolean isHide () {
      return hide;
    }
    
    public void SetActive (boolean sActive) {
      active = sActive;
    }
    
    public void SetFillPressed (color c) {
      cFillPressed = c;
    }
    
    public void SetHide (boolean sHide) {
      if (sHide) {
        hide = true;
        active = false;
      } else {
        hide = false;
        active = true;
      }
    }
    
  }
  
  class CheckBox  { // No hacer muy grande.
    int x1;
    int x2;
    int y1;
    int y2;
    boolean v;
    
    CheckBox (int tx1, int ty1, int tx2, int ty2) {
      x1 = tx1;
      x2 = tx2;
      y1 = ty1;
      y2 = ty2;
      v = false;
    }
    
    void display () {
      if (v) {
        stroke (180);
        fill (0);
        rect (x1, y1, x2-x1, y2-y1);
        fill (0, 150, 0);
        beginShape ();
          vertex (x1-5, (y2+y1)/2);
          vertex ((x1+x2)/2, y2+5);
          vertex (x2+10, y1-10);
          vertex ((x1+x2)/2, (y1+y2)/2 + 5);
        endShape ();
        fill (180);
      } else {
        stroke (180);
        fill (0);
        rect (x1, y1, x2-x1, y2-y1);
      }
    }
    
    void pressed () {
      if (x1 < mouseX && mouseX < x2 && y1 < mouseY && mouseY < y2 && mousePressed) {
        v = !v;
      }
    }
  }
  
  