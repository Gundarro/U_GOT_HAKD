class Kernel {
    float[][] kernel;
    int size;
    
    Kernel(float[][] kernel) {
        this.kernel = kernel;
        this.size = kernel.length;
    }
    
    Kernel(String kernelFileSource) {
        String[] kernelLines = loadStrings(kernelFileSource);
        this.size = kernelLines.length;
        this.kernel = new float[size][size];
        
        for (int i = 0; i < size; i++) {
            String[] line = split(kernelLines[i], " ");
            for (int j = 0; j < size; j++) {
                this.kernel[i][j] = float(line[j]);
            }
        }

    }

    int apply(PImage image, int x, int y) {
        float rSum = 0, gSum = 0, bSum = 0;
        for (int i = 0; i < this.size; i++) {
            int xIndex = x - this.size / 2 + i;
            for (int j = 0; j < this.size; j++) {
                int yIndex = y - this.size / 2 + j;
                
                // Handle edge cases here

                color pixelColor = image.get(xIndex, yIndex);
                float kernelValue = this.kernel[i][j];

                rSum += red(pixelColor) * kernelValue;
                gSum += green(pixelColor) * kernelValue;
                bSum += blue(pixelColor) * kernelValue;
            }
        }

        // Clamp color values to range 0-255
        int r = int(constrain(rSum, 0, 255));
        int g = int(constrain(gSum, 0, 255));
        int b = int(constrain(bSum, 0, 255));

        return color(r, g, b);
    }

    PImage convolution(PImage image) {
        PImage result = createImage(image.width, image.height, RGB);
        for (int i = 0; i < image.width; i++) {
            for (int j = 0; j < image.height; j++) {
                result.set(i, j, apply(image, i, j));
            }
        }
        return result;
    }
}
