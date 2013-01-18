//  Title: Ditherer
//  Description: A class that manages various image dithering techniques.

class Ditherer {
  PImage targetImage;

  Ditherer(String filePath) {
    println(filePath);
    this.targetImage = loadImage(filePath);
    this.targetImage.loadPixels();
  }

  int[] getSize() {
    int[] output = {
      this.targetImage.width, this.targetImage.height
    };
    return output;
  }

  void showImage() {
    background(255);
    for (int i = 0; i < width; i++) {
      for (int j = 0; j < height; j++) {
        set(i, j, this.targetImage.pixels[j*width+i]);
      }
    }
  }

  void halftone(float maxCircleSize) {
    background(255);
    noStroke();
    fill(0);
    //varies circle size proportional to pixel brightness
    for (int i = 0; i < width; i += floor(maxCircleSize)) {
      for (int j = 0; j < height; j += floor(maxCircleSize)) {
        float modulus = maxCircleSize * brightness(this.targetImage.pixels[j*width + i]) / 255.0;
        ellipse(i, j, modulus, modulus);
      }
    }
  }

  void halftoneSq(float maxSquareSize) {
    background(255);
    noStroke();
    fill(0);
    //varies square size proportional to pixel brightness
    rectMode(CENTER);
    for (int i = 0; i < width; i += floor(maxSquareSize)) {
      for (int j = 0; j < height; j += floor(maxSquareSize)) {
        float modulus = maxSquareSize * brightness(this.targetImage.pixels[j*width + i]) / 255.0;
        rect(i, j, modulus, modulus);
      }
    }
  }

  void maze(float gridSize) {
    background(255);
    noFill();
    stroke(0);
    //maps pixel brightness to strokeWeight between 0 and 2.
    for (int i = 0; i < width; i+=gridSize) {
      for (int j = 0; j < height; j+=gridSize) {
        strokeWeight(map(brightness(this.targetImage.pixels[j*width+i]), 0, 255, 0, 2));
        float seed = gridSize*(this.targetImage.pixels[j*width+i] & 0x01);
        line(i+seed, j, i+gridSize-seed, j+gridSize);
      }
    }
  }

  void maze(float gridSize, float maxWeight) {
    background(255);
    noFill();
    stroke(0);
    //maps pixel brightness to a strokeWeight set by user
    for (int i = 0; i < width; i+=gridSize) {
      for (int j = 0; j < height; j+=gridSize) {
        strokeWeight(map(brightness(this.targetImage.pixels[j*width+i]), 0, 255, 0, maxWeight));
        float seed = gridSize*(this.targetImage.pixels[j*width+i] & 0x01);
        line(i+seed, j, i+gridSize-seed, j+gridSize);
      }
    }
  }

  void digits(int gridSize) {
    background(255);
    noFill();
    stroke(0);
    //this works best with large files, otherwise the text is too small to read
    PFont font = createFont("Bitstream Vera Sans Bold", gridSize);
    textFont(font);
    //varies circle size proportional to pixel brightness
    for (int i = 0; i < width; i+=gridSize) {
      for (int j = 0; j < height; j+=gridSize) {
        int digit = int(map(brightness(this.targetImage.pixels[j*width+i]), 0, 255.0, 0, 9));
        text(digit, i, j);
      }
    }
  }

  void charactersLower(int gridSize) {
    background(255);
    fill(0);
    noStroke();
    //this works best with large files, otherwise the text is too small to read
    PFont font = createFont("mono", gridSize, true);
    textFont(font);
    //varies circle size proportional to pixel brightness
    for (int i = 0; i < width; i+=gridSize) {
      for (int j = 0; j < height; j+=gridSize) {
        int digit = int(map(brightness(this.targetImage.pixels[j*width+i]), 0, 255.0, 97, 122));
        println(char(digit));
        text(char(digit), i, j);
      }
    }
  }

  void charactersUpper(int gridSize) {
    background(255);
    fill(0);
    noStroke();
    //this works best with large files, otherwise the text is too small to read
    PFont font = createFont("mono", gridSize, true);
    textFont(font);
    //varies circle size proportional to pixel brightness
    for (int i = 0; i < width; i+=gridSize) {
      for (int j = 0; j < height; j+=gridSize) {
        int digit = int(map(brightness(this.targetImage.pixels[j*width+i]), 0, 255.0, 65, 90));
        println(char(digit));
        text(char(digit), i, j);
      }
    }
  }

  void packCircles(int numCircles, float minRadius, float maxRadius) {
    background(255);
    noStroke();
    fill(0);
    //need to reorganize
    ArrayList<Circle> circleList = new ArrayList<Circle>();
    float x = 0;
    float y = 0;
    float rad = 0;
    boolean validRadius = false;
    boolean validCenter = false;

    while (circleList.size () < numCircles) {
      validRadius = false;
      validCenter = false;

      while (validCenter == false) {
        //set to true -- if the center is not valid, this gets changed.  if it passes all tests, this goes through the for loop untouched.
        validCenter = true;
        //pick a random position
        x = random(width);
        y = random(height);
        rad = map(brightness(this.targetImage.pixels[(int)y*width+(int)x]), 0, 255.0, minRadius, maxRadius);
        //make circle object
        //check if it is inside any other circle
        for (int i = 0; i < circleList.size(); i++) {
          Circle compareWith = (Circle) circleList.get(i);
          float distance = dist(x, y, compareWith.x, compareWith.y);
          if (distance < compareWith.rad) {
            //if this circle is too close
            validCenter = false;
          }
        }
      }

//      while (validRadius == false) {
//        validRadius = true;
        //now check radii
        for (int i = 0; i < circleList.size(); i++) {
          Circle compareWith = (Circle) circleList.get(i);
          float distance = dist(x, y, compareWith.x, compareWith.y);
          if (distance < compareWith.rad + rad) {
            //radii overlap
            rad = distance - compareWith.rad;
          }
        }
        circleList.add(new Circle(x, y, rad));
      //}
      Circle currentCircle = (Circle) circleList.get(circleList.size() - 1);
      ellipse(currentCircle.x, currentCircle.y, 2*currentCircle.rad, 2*currentCircle.rad);
//      validRadius = false;
   }
  }
}
