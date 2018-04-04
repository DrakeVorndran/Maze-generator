float res = 10;
float[][] grid;
float dif = 0.5;


void solve(float[][]l) {
  int checked = 1;
  int[] end = new int[2];
  end[0] = 0;
  end[1] = 0;
  int max = 1;
  int[][] tocheck = new int[ l.length * l[0].length][2];
  tocheck[0][0] = l.length;
  tocheck[0][1] = l[0].length;
  while (true) {

    if (tocheck[checked][0] == 0) {
      return true;
    }
    if (tocheck[checked][0]>0) {
      if (l[tocheck[checked][0]-1][tocheck[checked][1]]==0) {
        max+=1;
        tocheck[max][0]=tocheck[checked][0]-1;
        tocheck[max][1] = tocheck[checked][1];
      }
    }
    if (tocheck[checked][1]>0) {
      if (l[tocheck[checked][0]][tocheck[checked][1]-1]==0) {
        max+=1;
        tocheck[max][0]=tocheck[checked][0];
        tocheck[max][1] = tocheck[checked][1]-1;
      }
    }
    if (tocheck[checked][0]<l.length-1) {
      if (l[tocheck[checked][0]+1][tocheck[checked][1]]==0) {
        max+=1;
        tocheck[max][0]=tocheck[checked][0]+1;
        tocheck[max][1] = tocheck[checked][1];
      }
    }
    if (tocheck[checked][0]<l[0].length-1) {
      if (l[tocheck[checked][0]][tocheck[checked][1]+1]==0) {
        max+=1;
        tocheck[max][0]=tocheck[checked][0];
        tocheck[max][1] = tocheck[checked][1]+1;
      }
    }
    checked++;
  }
}
void map(float[][] l) {
  for (int x = 0; x<l.length; x++) {
    for (int y = 0; y<l[int(y)].length; y++) {
      fill(map(l[x][y], 0, 1, 255, 0));
      rect(x*res, y*res, res, +res);
      //System.out.println(l[x][y]);
    }
  }
}
void build() {
  for (int x =0; x<grid.length; x++) {
    for (int y = 0; y<grid[x].length; y++) {
      if (x % 2 == 1 && y % 2 == 1 ) {
        grid[x][y]=1;
      } else if ( x % 2 == 1 || y % 2 == 1 ) {
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
}
void setup() {
  size(700, 450);
  grid = new float[int(width/res)][int(height/res)];
  build();
  //System.out.println(grid);

  map(grid);
}

void draw() {
  build();
  fill(255);
  rect(0, 0, width, height);
  map(grid);
}
