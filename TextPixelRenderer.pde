class TextPixelRenderer extends PixelRenderer {
    String characters;
    
    TextPixelRenderer(ImageProcessor ip, Kernel kernel, String charactersFilename) {
        super(ip, kernel);
        this.loadCharactersFromFile(charactersFilename);
    }
    
    void loadCharactersFromFile(String filename) {
        this.characters = join(loadStrings(filename), " ");
    }
    
    void render(int granularity) {
        int i = 0;
        for (int y = 0; y < pixelGrid.length; y += granularity) {
            for (int x = 0; x < pixelGrid[y].length; x += granularity) {
                Pixel pixel = pixelGrid[y][x];
                pushMatrix();
                
                int mouseRadius = 100;
                float distanceFromMouse = dist(pixel.position.x, pixel.position.y, pixel.position.z, mouseX, mouseY, 0);
                
                PVector pixelPosition = new PVector(pixel.position.x, pixel.position.y, pixel.position.z);
                // if (distanceFromMouse < mouseRadius) {
                float mouseForce = 1 - (distanceFromMouse / mouseRadius); 
                // pixel.position.x += (mouseX - pmouseX) * mouseForce;
                // pixel.position.y += (mouseY - pmouseY) * mouseForce;
                // pixel.position.z += (mouseY - pmouseY) * mouseForce * 10;
                // pixel.position.z += (mouseY - pmouseY) * mouseForce * 10;
                
                if (distanceFromMouse < mouseRadius) {
                    pixel.stepToOrigin(mouseForce);
                    pixel.makeReadable(mouseForce);
                } else {
                    pixel.update();
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
