Ditherer img;
int gridSize = 5;

void setup() {
  img = new Ditherer("teatime.jpg");
  int[] imgSize = img.getSize();
  //uncomment to automaticaly determine window size
  //size(imgSize[0],imgSize[1]);
  size(512,384);
  background(255);
  PFont.list();
  img.showImage();
}

void draw() {
}

void keyPressed() {
  if(key == '0') {
    img.showImage();
  }
  if (key == '1') {
    img.halftone(gridSize);
  }
  if (key == '2') {
    img.maze(gridSize);
    saveFrame("maze.jpg");
  }
  if (key == '3') {
    img.digits(gridSize);
  }
  if(key == '4') {
    img.charactersUpper(gridSize);
  }
  if(key == '5') {
    img.packCircles(20.0);
  }
  if (key == CODED) {
    if (keyCode == UP) {
      gridSize++;
    }
    if (keyCode == DOWN) {
      gridSize--;
    }
  }
}
