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
                
                int mouseRadius = 70;
                float distanceFromMouse = dist(pixel.originalPosition.x, pixel.originalPosition.y, pixel.originalPosition.z, mouseX, mouseY, 0);
                
                PVector pixelPosition = new PVector(pixel.position.x, pixel.position.y, pixel.position.z);
                float mouseForce = 1 - (distanceFromMouse / mouseRadius); 

                if (distanceFromMouse < mouseRadius) {
                    pixel.stepToOrigin(mouseForce);
                    pixel.makeReadable(mouseForce);
                } else {
                    pixel.update();
                    // push away from mouse
                    PVector mousePosition = new PVector(mouseX, mouseY, 0);
                    pixel.pushAwayFromPoint(mousePosition, 120);
                    
                }
                
                
                translate(pixel.position.x, pixel.position.y, pixel.position.z);
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
