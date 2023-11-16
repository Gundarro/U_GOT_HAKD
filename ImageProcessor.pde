class ImageProcessor {
    PImage image;

    ImageProcessor(String imageSource) {
        this.image = loadImage("images/despair.png");
    }

    ImageProcessor (PImage image) {
        this.image = image;
    }

    Pixel[][] toPixelGrid(Kernel kernel) {
        Pixel[][] pixelGrid = new Pixel[image.height][image.width];
        PImage convulation = kernel.apply(this.image, 0, 0);
    
        for (int y = 0; y < image.height; y++) {
            for (int x = 0; x < image.width; x++) {
                int i = y * image.width + x;

                color kernelColor = convulation.get(x, y);
                float kernelBrightness = brightness(kernelColor);

                float rotationY = map(kernelBrightness, 0, 255, 0, (PI / 2)-PI/8); // Map brightness to rotation angle

                // create a new Pixel
                PVector position = new PVector(x, y, 0);
                PVector rotation = new PVector(0, rotationY, 0);
                pixelGrid[y][x] = new Pixel(kernelColor, position, rotation);
            }
        }

        return pixelGrid;
    }
}
