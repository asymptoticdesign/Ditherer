//  Title: Ditherer
//  Description: A class that manages various image dithering techniques.
//  Date Started: 2013 Jan
//  Last Modified: 2013 Jan
//  http://asymptoticdesign.org/
//  This work is licensed under a Creative Commons 3.0 License.
//  (Attribution - NonCommerical - ShareAlike)
//  http://creativecommons.org/licenses/by-nc-sa/3.0/
//  
//  In summary, you are free to copy, distribute, edit, and remix the work.
//  Under the conditions that you attribute the work to me, it is for
//  noncommercial purposes, and if you build upon this work or otherwise alter
//  it, you may only distribute the resulting work under this license.
//
//  Of course, the conditions may be waived with permission from the author.

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
1        float seed = gridSize*(this.targetImage.pixels[j*width+i] & 0x01);
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
    PFont font = createFont("mono", gridSize,true);
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
    PFont font = createFont("mono", gridSize,true);
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
}
