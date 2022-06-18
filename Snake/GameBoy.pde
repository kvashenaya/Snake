class GameBoy {

  boolean[][] display = new boolean[8][16];
  byte[][][] block = new byte[4][4][4];

  int offset = 5;

  int testX = 0;
  int testY = 0;
 

  public void begin(int x) {
    drawMatrix(8, 16);
  }

  public void drawMatrix(int cols, int rows) {
    int offsetX= offset;
    int offsetY = offset;
    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < cols; j++) {
        circle(j*30+15 + offsetX, i*30+15 + offsetY, 30);
        offsetX += offset;
      }
      offsetY += offset;
      offsetX = offset;
    }
  }

  public void drawPoint(int x, int y) {
    if (x < 0 || y < 0) return;

    fill(255, 0, 0);
    int offsetX = 0;
    int offsetY = 0;

    if (x == 0) offsetX = 5; 
    else offsetX = (x+1) * offset;
    if (y == 0) offsetY = 5; 
    else offsetY = (y+1) * offset;

    circle(30 * x + offsetX + 15, 30 * y + offsetY + 15, 30);
    fill(255, 255, 255);
  }

  public void wipePoint(int x, int y) {
    if (x < 0 || y < 0) return;

    fill(255, 255, 255);
    int offsetX = 0;
    int offsetY = 0;

    if (x == 0) offsetX = 5; 
    else offsetX = (x+1) * offset;
    if (y == 0) offsetY = 5; 
    else offsetY = (y+1) * offset;

    circle(30 * x + offsetX + 15, 30 * y + offsetY + 15, 30);
  }

  public int getKey() {
    if (keyPressed) {
      if (key == 'w' || key == 'W' || keyCode == UP) return 3; 
      if (key == 'a' || key == 'A' || keyCode == LEFT) return 4; 
      if (key == 'd' || key == 'D' || keyCode == RIGHT) return 5; 
      if (key == 's' || key == 'S' || keyCode == DOWN) return 6;
      if (key == ' ') return 1;
    }
    return 0;
  }

  boolean testMatrix(int del) {
    drawPoint(testX, testY);
    testX++;
    if (testX == 9) {
      if (testY < 15) {
        testY++;
        testX = 0;
      } else {
        testX = 0;
        testY = 0;
        drawMatrix(8, 16);
        delay(1000);
        return false;
      }
    }
    delay(del);

    return true;
  }

  void drawDisplay() {
    for (int x = 0; x < 8; x++) {
      for (int y = 0; y < 16; y++) {
        if (display[x][y]) {
          drawPoint(x, y);
        } else {
          wipePoint(x, y);
        }
      }
    }
  }
}
