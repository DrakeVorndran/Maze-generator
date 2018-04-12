float res = 400;
float[][] grid;
float dif = 0.50;
float zoom = 15;
float defZ = zoom;
int px;
int py;
int playerX = 1;
int playerY = 1;
color c;
int oldX;
int oldY;
boolean zOut = false;
boolean solve(float[][]l) {
  int checked = 0;
  //int[] end = new int[2];
  int[][] beenChecked = new int[l.length][l[0].length];
  //System.out.println(beenChecked[0][0]);
  //end[0] = 1;
  //end[1] = 1;
  int max = 1;
  int[][] tocheck = new int[ l.length * l[0].length][2];
  tocheck[0][0] = 1;
  tocheck[0][1] = 1;
  while (true) {
    //System.out.print(tocheck[checked][0]);
    //System.out.print(",");
    //System.out.println(tocheck[checked][1]);s
    if (tocheck[checked][0] == l.length-2 && tocheck[checked][1]==l[0].length-2) {
      return true;
    }
    if (tocheck[checked][0]>0) {
      if (l[tocheck[checked][0]-1][tocheck[checked][1]]==0 && beenChecked[tocheck[checked][0]-1][tocheck[checked][1]]==0) {
        max+=1;
        beenChecked[tocheck[checked][0]-1][tocheck[checked][1]] = 1;
        tocheck[max][0]=tocheck[checked][0]-1;
        tocheck[max][1] = tocheck[checked][1];
      }
    }
    if (tocheck[checked][1]>0) {
      if (l[tocheck[checked][0]][tocheck[checked][1]-1]==0 && beenChecked[tocheck[checked][0]][tocheck[checked][1]-1]==0) {
        max+=1;
        beenChecked[tocheck[checked][0]][tocheck[checked][1]-1]=1;
        tocheck[max][0]=tocheck[checked][0];
        tocheck[max][1] = tocheck[checked][1]-1;
      }
    }
    if (tocheck[checked][0]<l.length-2) {
      if (l[tocheck[checked][0]+1][tocheck[checked][1]]==0 && beenChecked[tocheck[checked][0]+1][tocheck[checked][1]]==0) {
        max+=1;
        beenChecked[tocheck[checked][0]+1][tocheck[checked][1]]=1;
        tocheck[max][0]=tocheck[checked][0]+1;
        tocheck[max][1] = tocheck[checked][1];
      }
    }
    if (tocheck[checked][1]<l[0].length-2) {
      if (l[tocheck[checked][0]][tocheck[checked][1]+1]==0 && beenChecked[tocheck[checked][0]][tocheck[checked][1]+1]==0) {
        max+=1;
        beenChecked[tocheck[checked][0]][tocheck[checked][1]+1]=1;
        tocheck[max][0]=tocheck[checked][0];
        tocheck[max][1] = tocheck[checked][1]+1;
      }
    }
    if (checked==max) {
      return false;
    }
    checked++;
    //System.out.print(checked);
    //System.out.print(" ");
    //System.out.println(max);
  }
}
void map(float[][] l) {
  for (int x = 0; x<l.length; x++) {
    for (int y = 0; y<l[int(x)].length; y++) {
      if (!zOut) {
        if (x*res*zoom<playerX*res*zoom+width/2 && y*res*zoom<playerY*res*zoom+height/2 && res*zoom+(x*res*zoom)>playerX*res*zoom-width/2 && res*zoom+(y*res*zoom)>playerY*res*zoom-height/2) {
          if (l[x][y]==0) {
            c = color(255);
          } else if (l[x][y]==1) {
            c = color(0);
          } else if (l[x][y]==2) {
            c = color(255, 0, 0);
          } else if (l[x][y]==4) {
            c = color(0, 255, 0);
          } else {
            c = color(0, 0, 255);
          }

          stroke(c);
          fill(c);
          rect((x*res)*zoom, (y*res)*zoom, (res)*zoom, res*zoom);
          //System.out.println(l[x][y]);
        }
      } else {
        if (l[x][y]==0) {
          c = color(255);
        } else if (l[x][y]==1) {
          c = color(0);
        } else if (l[x][y]==2) {
          c = color(255, 0, 0);
        } else if (l[x][y]==4) {
          c = color(0, 255, 0);
        } else {
          c = color(0, 0, 255);
        }

        stroke(c);
        fill(c);
        rect((x*res)*zoom, (y*res)*zoom, (res)*zoom, res*zoom);
      }
    }
  }
}
void build() {
  for (int x =0; x<grid.length; x++) {
    for (int y = 0; y<grid[x].length; y++) {
      if (x==0||x==grid.length-1||y==0||y==grid[0].length-1) {
        grid[x][y]=1;
      } else if (x % 2 == 0 && y % 2 == 0 ) {
        grid[x][y]=1;
      } else if ( x % 2 == 0 || y % 2 == 0 ) {
        float rand = map(random(100), 0, 100, 0, 1);
        //System.out.println(rand);
        if (dif > rand) {
          grid[x][y] = 1;
        } else {
          grid[x][y] = 0;
        }
      } else {
        grid[x][y] = 0;
      }
    }
  }
  grid[grid.length-2][grid[0].length-2]=0;
  grid[1][1]=2;
}
void setup() {
  size(800, 800);
  res = height/res;
  zoom = (width/res)/zoom;
  defZ = zoom;
  py = height/2;
  px = width/2;
  grid = new float[int(width/res)][int(height/res)];
  build();
  //System.out.println(grid);

  build();
  //map(grid);
  boolean solveable = solve(grid);
  int tries = 1;
  while (!solveable) {
    build();
    //map(grid);
    solveable = solve(grid);
    tries++;
    //System.out.println(tries);
  }
  
  grid[grid.length-2][grid[0].length-2]=4;

  map(grid);
}
void keyPressed() {
  oldX = playerX;
  oldY = playerY;
  grid[playerX][playerY]=3;
  if (key==' ') {
    if (zOut) {
      zoom = defZ;
      zOut = false;
    } else {
      zoom = 1;
      zOut = true;
      //translate(0,0);
      map(grid);
    }
  } else if (keyCode==RIGHT) {
    playerX++;
    //px-=res*zoom;
  } else if (keyCode==LEFT) {
    playerX--;
    //System.out.println(playerX);
    //px+=res*zoom;
  } else if (keyCode==UP) {
    playerY--;
    //py+=res*zoom;
  } else if (keyCode==DOWN) {
    playerY++;
    //py-=res*zoom;
  }
  if (!(grid[playerX][playerY]==1)) {
    px = (int(playerX*res*zoom)*-1)+width/2;
    py = (int(playerY*res*zoom)*-1)+height/2;
  } else {
    playerX=oldX;
    playerY=oldY;
  }
  grid[playerX][playerY]=2;
}
void draw() {
  background(255);
  //px-=res*zoom;
  //if (keyPressed) {
  //  if (keyCode==RIGHT) {
  //    px-=res*zoom;
  //    System.out.println("right");
  //  }

  //}
  if (playerX == grid.length-2  && playerY == grid[0].length-2) {
    zOut = true;
    zoom = 1;
    fill(0, 255, 0);
    textSize(100);
    text("You win!", width/2-25, height/2-50);
  }
  if (!zOut) {

    translate(px, py);
  } else {
    translate(0, 0);
  }
  map(grid);
  //px+=1;

  //System.out.println(px);
  //if(keyPressed){
  //  if(keyCode==RIGHT){
  //    px+=zoom*res;
  //    System.out.println(px);

  //  }
  //}
}
