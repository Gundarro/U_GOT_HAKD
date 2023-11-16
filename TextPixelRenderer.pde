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
