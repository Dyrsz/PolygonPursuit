 float x, y, a, ac;
 int n = 40, N = 5;
 float [] xs = new float [500];
 float [] ys = new float [500];
 boolean desp;
 boolean bug;
 int nb = 5;
 RectButton [] bt = new RectButton [10];
 
 // ac: Intento de ponerle aceleración en las iteraciones.
 
 void setup () {
   size(600,600);
   a = 0;
   ac = 1;
   bt[0] = new RectButton(450,55,470,75,"-",12);
   bt[1] = new RectButton(480,55,500,75,"+",12);
   bt[2] = new RectButton(450,95,470,115,"-",12);
   bt[3] = new RectButton(480,95,500,115,"+",12);
   bt[4] = new RectButton(450,135,500,155,"Cambiar",10);
   bt[5] = new RectButton(450,505,500,525,"Cambiar",10);
   bt[6] = new RectButton(450,545,470,565,"-",12);
   bt[7] = new RectButton(480,545,500,565,"+",12);
   bt[8] = new RectButton(150,55,170,75,"-",12);
   bt[9] = new RectButton(180,55,200,75,"+",12);
 }

 void draw () {
   background  (0);
   xs [0] = width/2;
   ys [0] = height/4;
   polygon (xs [0], ys [0], N);
   if (n > 1) for (int j = 1; j < n; j++) {
     if (desp) {
       xs [j] = persP (xs [j-1], ys [j-1], j, n)[0];
       ys [j] = persP (xs [j-1], ys [j-1], j, n)[1];
     } else {
       xs [j] = persP (xs [j-1], ys [j-1])[0];
     ys [j] = persP (xs [j-1], ys [j-1])[1];
     }
     polygon (xs [j], ys [j], N);
   }
   a += 0.005;
   if (a >= 1) a = 0;
   fill(200);
   stroke(150);
   textSize(14);
   text("Nº de lados:", 400, 50);
   text(str(N), 400, 70);
   text("Iteraciones:", 400, 90);
   text(str(n),400, 110);
   text("Desplazamiento:", 400, 130);
   text(str(desp), 400, 150);
   text("Bug:", 400, 500);
   text(str(bug), 400, 520);
   text("Aceleración en cada iteración:", 100, 50);
   text(str(ac), 100, 70);
   text(str(bug), 400, 520);
   if (bug) text("Lados fijos:", 400, 540);
   if (bug) text(str(nb), 400, 560);
   for (int j = 0; j < 10; j++) {
     if (j < 6 || j > 7) bt[j].display();
     if (j == 6 || j == 7) if (bug) bt[j].display();
   }
   if (bt[0].onFirstFramePressed()) if (N > 3) N --;
   if (bt[1].onFirstFramePressed()) if (N < 500) N++;
   if (bt[2].onFirstFramePressed()) if (n > 1) n--;
   if (bt[3].onFirstFramePressed()) n++;
   if (bt[4].onFirstFramePressed()) desp = !desp;
   if (bt[5].onFirstFramePressed()) bug = !bug;
   if (bt[6].onFirstFramePressed()) if (nb > 1) nb --;
   if (bt[7].onFirstFramePressed()) nb ++;
   //if (bt[8].onFirstFramePressed()) if (ac > 0.02) ac -= 0.01;
   //if (bt[9].onFirstFramePressed()) if (ac < 1.95) ac += 0.01;
 }
 
 void polygon (float x, float y, int N) {
   float x1, y1;
   if (!bug) {
     for (int i = 0; i < N; i++) {  // Si fijo N en este bucle (saco la variable de él), queda un efecto que me gusta. 
       noStroke ();
       fill (160,0,160);
       ellipse (x, y, 2, 2);
       x1 = rot (x, y, width/2, height/2, 2*PI/N)[0];
       y1 = rot (x, y, width/2, height/2, 2*PI/N)[1];
       stroke (130,0,130);
       line (x,y,x1,y1);
       x = x1;
       y = y1;
     }
   } else {
     for (int i = 0; i < nb; i++) {
       noStroke ();
       fill (160,0,160);
       ellipse (x, y, 2, 2);
       x1 = rot (x, y, width/2, height/2, 2*PI/N)[0];
       y1 = rot (x, y, width/2, height/2, 2*PI/N)[1];
       stroke (130,0,130);
       line (x,y,x1,y1);
       x = x1;
       y = y1;
     }
   }
 }
 
 float [] persP (float x, float y) {
   float x1, y1, vx, vy, l;
   float [] ret = new float [2];
   x1 = rot (x, y, width/2, height/2, -2*PI/N)[0];
   y1 = rot (x, y, width/2, height/2, -2*PI/N)[1];
   vx = x1 - x;
   vy = y1 - y;
   l = a * ac;
   if (l >= 1) l -= 1;
   ret [0] = x + a*vx;
   ret [1] = y + a*vy;
   return ret;
 }
 
  float [] persP (float x, float y, int k, int m) {
   float x1, y1, vx, vy, l;
   float [] ret = new float [2];
   x1 = rot (x, y, width/2, height/2, -2*PI/N)[0];
   y1 = rot (x, y, width/2, height/2, -2*PI/N)[1];
   vx = x1 - x;
   vy = y1 - y;
   l = a*ac*(float(k)/float(m) + 1);
   if (l >= 1) l -= 1;
   ret [0] = x + l*vx;
   ret [1] = y + l*vy;
   return ret;
 }

 float [] rot (float x, float y, float cx, float cy, float rad) {
   float[] ret = new float [2];
   x = x - cx;
   y = y - cy;
   ret [0] = x*cos(rad) - y*sin(rad) + cx;
   ret [1] = x*sin(rad) + y*cos(rad) + cy;
   return ret;
 }