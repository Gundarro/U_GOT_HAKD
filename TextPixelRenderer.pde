class TextPixelRenderer extends PixelRenderer {
    String characters;
    
    TextPixelRenderer(ImageProcessor ip, Kernel kernel, String charactersFilename) {
        super(ip, kernel);
        this.loadCharactersFromFile(charactersFilename);
    }
    
    void loadCharactersFromFile(String filename) {
        this.characters = join(loadStrings(filename), " ");
    }

    int[] findHoveredLetterIndex() {

        // find the x and y of the mouse in the pixel grid

        int x = (int) map(mouseX, 0, width, 0, pixelGrid[0].length);
        int y = (int) map(mouseY, 0, height, 0, pixelGrid.length);

        return new int[] {x, y};
    }
    
    void render(int granularity) {
        int i = 0;
        int[] hoveredLetterIndex = this.findHoveredLetterIndex();
        for (int y = 0; y < pixelGrid.length; y += granularity) {
            for (int x = 0; x < pixelGrid[y].length; x += granularity) {
                Pixel pixel = pixelGrid[y][x];
                if (pixel == null) {
                    continue;
                }

                pushMatrix();
                
                int mouseRadius = 50;
                float distanceFromMouse = dist(pixel.originalPosition.x, pixel.originalPosition.y, pixel.originalPosition.z, mouseX, mouseY, 0);
                
                PVector pixelPosition = new PVector(pixel.position.x, pixel.position.y, pixel.position.z);
                // if (distanceFromMouse < mouseRadius) {
                float mouseForce = 1 - (distanceFromMouse / mouseRadius); 
                // pixel.position.x += (mouseX - pmouseX) * mouseForce;
                // pixel.position.y += (mouseY - pmouseY) * mouseForce;
                // pixel.position.z += (mouseY - pmouseY) * mouseForce * 10;
                // pixel.position.z += (mouseY - pmouseY) * mouseForce * 10;
                
                // if (x == hoveredLetterIndex[0] && y == hoveredLetterIndex[1]) {
                //     pixel.stepToOrigin(1);
                //     pixel.makeReadable(1);
                // } else 
                if (distanceFromMouse < mouseRadius) {
                    pixel.stepToOrigin(mouseForce);
                    pixel.makeReadable(mouseForce);
                } else {
                    pixel.update();
                    // push away from mouse
                    PVector mousePosition = new PVector(mouseX, mouseY, 0);
                    pixel.pushAwayFromPoint(mousePosition, 50);
                    
                }
                
                
                translate(pixel.position.x, pixel.position.y, pixel.position.z);
                // translate(pixelPosition.x, pixelPosition.y, pixelPosition.z);
                rotateX(pixel.rotation.x);
                rotateY(pixel.rotation.y);
                rotateZ(pixel.rotation.z);
                
                fill(pixel.pColor);
                char c = this.characters.charAt(i % this.characters.length());
                text(c, 0, 0);
                popMatrix();
                i += 1;
            }
        }
    }
}
