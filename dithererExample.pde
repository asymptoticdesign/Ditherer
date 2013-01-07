Ditherer img;
int gridSize = 5;

void setup() {
  img = new Ditherer("data/teatime.jpg");
  int[] imgSize = img.getSize();
  size(imgSize[0],imgSize[1]);
  background(255);
  PFont.list();
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
  }
  if (key == '3') {
    img.digits(gridSize);
  }
  if(key == '4') {
    img.charactersUpper(gridSize);
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
