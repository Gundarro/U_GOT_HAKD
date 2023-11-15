PImage img;

void setup() {
  size(800, 600, P3D);  // Use P3D renderer for 3D capabilities
  // Upload the image from your computer
  selectInput("Select an image to process:", "imageSelected");
}

void draw() {
  background(255);
  // Display the image
  if (img != null) {
    translate(width / 2, height / 2);
    //rotateZ(frameCount * 0.01);  // Rotate the entire scene over time
    drawTextBasedOnBrightness();
  }
}

void imageSelected(File selection) {
  if (selection == null) {
    println("No image selected");
  } else {
    // Load the selected image
    img = loadImage(selection.getAbsolutePath());
    img.resize(width, height);
  }
}

void drawTextBasedOnBrightness() {
  if (img != null) {
    // Loop through each pixel and display text
    String text = "You_cannot_catch_me_brother!";
    int i = 0;
    for (int x = 0; x < img.width; x += 9) {
      for (int y = 0; y < img.height; y += 9) {
        i += 1;
        float bright = brightness(img.get(x, y));
        // char letter = char((int) map(bright, 0, 255, 32, 126));  // Map brightness to ASCII characters
        //char letter = 'o';
        char letter = text.charAt(((i+1)%(text.length()+0)));
        float rotation = map(bright, 0, 255, 0, PI / 2);  // Map brightness to rotation angle

        pushMatrix();
        translate(x - img.width / 2, y - img.height / 2);
        rotateY(rotation);
        //rotateX(rotation);
        fill(1);
        text(letter, 0, 0);
        popMatrix();
      }
    }
  }
}
