class TextPixel {
    color pColor;
    // char character;

    PVector position;
    PVector rotation;

    TextPixel (color pColor, PVector position, PVector rotation) {
        this.pColor = pColor;
        // this.character = character;
        this.position = position;
        this.rotation = rotation;
    }
}

class TextPixelRenderer {
    TextPixel[][] pixelGrid;
    String characters;

    TextPixelRenderer(TextPixel[][] pixelGrid, String characters) {
        this.pixelGrid = pixelGrid;
        this.characters = characters;
    }

    void render(int granularity) {

        int i = 0;
        for (int y = 0; y < pixelGrid.length; y += granularity) {
            for (int x = 0; x < pixelGrid[y].length; x += granularity) {
                TextPixel pixel = pixelGrid[y][x];
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

class ImageProcessor {
    PImage image;

    ImageProcessor(PImage image) {
        this.image = image;
    }

    // static ImageProcessor fromFile(String filename) {
    //     return new ImageProcessor(loadImage(filename));
    // }

    TextPixelRenderer toTextPixelRenderer(Kernel kernel, String characters) {

        TextPixel[][] pixelGrid = new TextPixel[image.height][image.width];
        PImage convulation = kernel.apply(this.image, 0, 0);
    
        for (int y = 0; y < image.height; y++) {
            for (int x = 0; x < image.width; x++) {
                int i = y * image.width + x;

                color kernelColor = convulation.get(x, y);
                float kernelBrightness = brightness(kernelColor);

                float rotationY = map(kernelBrightness, 0, 255, 0, PI / 2);  // Map brightness to rotation angle

                // create a new TextPixel
                PVector position = new PVector(x, y, 0);
                PVector rotation = new PVector(0, rotationY, 0);
                // PVector rotation = new PVector(0, 0, 0);

                pixelGrid[y][x] = new TextPixel(kernelColor, position, rotation);
            }
        }

        TextPixelRenderer renderer = new TextPixelRenderer(pixelGrid, characters);
        return renderer;
    }
}
