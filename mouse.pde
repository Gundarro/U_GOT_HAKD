// TAB

class MouseInteraction {
  float circleRadius = 50;

  MouseInteraction 

  void drawRotatingLettersAroundCursor() {
    float cursorX = mouseX - width / 2;
    float cursorY = mouseY - height / 2;

    noFill();
    stroke(0);
    ellipse(cursorX, cursorY, circleRadius * 2, circleRadius * 2);

    String text = "You_cannot_catch_me_brother!";
    int i = 0;
    for (float angle = 0; angle < TWO_PI; angle += radians(10)) {
      float x = cursorX + cos(angle) * circleRadius;
      float y = cursorY + sin(angle) * circleRadius;

      float bright = brightness(img.get(int(x + img.width / 2), int(y + img.height / 2)));
      char letter = text.charAt(((i + 1) % text.length()));

      float rotation = map(bright, 0, 255, 0, PI / 2);

      pushMatrix();
      translate(x, y);
      rotateZ(rotation);
      fill(0);
      text(letter, 0, 0);
      popMatrix();

      i += 1;
    }
  }
}
