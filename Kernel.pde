class Kernel {
    float[][] kernel;
    int size;
    
    Kernel(float[][] kernel) {
        this.kernel = kernel;
        this.size = kernel.length;
    }
    
    Kernel(String kernelFileSource) {
        String[] kernelLines = loadStrings(kernelFileSource);
        int size = kernelLines.length;
        this.kernel = new float[size][size];
        
        for (int i = 0; i < size; i++) {
            String[] line = split(kernelLines[i], " ");
            for (int j = 0; j < size; j++) {
                this.kernel[i][j] = float(line[j]);
            }
        }

    }
    PImage apply(PImage image, int x, int y) {
        color sum = 0;
        for (int i = 0; i < this.size; i++) {
            int xIndex = x - this.size / 2 + i;
            for (int j = 0; j < this.size; j++) {
                int yIndex = y - this.size / 2 + j;
                sum += image.get(xIndex, yIndex) * this.kernel[i][j];
            }
        }

        return image;
    }
}
