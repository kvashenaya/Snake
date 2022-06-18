GameBoy gb = new GameBoy();

int headX = 0;
int headY = 0;

int moveX = 1;
int moveY = 0;

int foodX = (int)random(0, 8);
int foodY = (int)random(0, 16);

ArrayList<TailPiece> tail = new ArrayList<TailPiece>();

boolean game = true;

int animation_x = 0;
int animation_y = 0;

int anim_move_x = 1;

void setup() {
  size(285, 565);
  gb.begin(0);
}


void draw() {  
  if (game) {
    gb.drawDisplay();
    gb.drawPoint(headX, headY);
    gb.drawPoint(foodX, foodY);

    if (frameCount % 20 == 0) {    
      updateTail(headX, headY);

      headX += moveX;
      headY += moveY;

      checkCollision();

      if (headX > 7) {
        headX = 0;
      } else if (headX < 0) {
        headX = 7;
      }

      if (headY > 15) {
        headY = 0;
      } else if (headY < 0) {
        headY = 15;
      }

      if (headX == foodX && headY == foodY) {
        addTail();
        foodX = (int)random(0, 8);
        foodY = (int)random(0, 16);
      }
    }

    drawTail();
  } else {
    gb.drawPoint(animation_x, animation_y);
    animation_x += anim_move_x;
    if (animation_x > 7 || animation_x < 0) {
      anim_move_x = anim_move_x * -1;
      animation_y++;
    }
    delay(100);
  }
}

void checkCollision() {
  for (int i = 2; i < tail.size(); i++) {
    if (headX == tail.get(i).x && headY == tail.get(i).y) {
      game = false;
    }
  }
}

void drawTail() {
  for (int i = 0; i < tail.size(); i++) {
    gb.drawPoint(tail.get(i).x, tail.get(i).y);
  }
}

void updateTail(int targetX, int targetY) {
  if (tail.size() > 0) {
    for (int i = tail.size() - 1; i > 0; i--) {
      tail.get(i).x = tail.get(i - 1).x;
      tail.get(i).y = tail.get(i - 1).y;
    }
    tail.get(0).x = targetX;
    tail.get(0).y = targetY;
  }
}

void addTail() {
  int newPieceX = headX;
  int newPieceY = headY;
  tail.add(new TailPiece(newPieceX, newPieceY));
}

void keyPressed() {
  if (gb.getKey() == 3 && moveY != 1) {
    moveX = 0;
    moveY = -1;
  }

  if (gb.getKey() == 4 && moveX != 1) {
    moveX = -1;
    moveY = 0;
  }

  if (gb.getKey() == 5 && moveX != -1) {
    moveX = 1;
    moveY = 0;
  }

  if (gb.getKey() == 6 && moveY != -1) {
    moveX = 0;
    moveY = 1;
  }
}
