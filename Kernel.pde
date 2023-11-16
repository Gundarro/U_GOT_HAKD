class Kernel {
    float[][] kernel;
    int size;

    Kernel(float[][] kernel) {
        this.kernel = kernel;
        this.size = kernel.length;
    }

    // static fromFile(String filename) {
    //     // for example the gaussian blur kernel
    //     // 0.05 0.1 0.05
    //     // 0.1  0.25 0.1
    //     // 0.05 0.1  0.05

    //     // the kernel is a square matrix
    //     // the size is the number of rows/columns
    //     // the kernel is a 2d array of floats
    //     // the kernel is normalized so that the sum of all elements is 1

        
    //     String lines[] = loadStrings(filename);
    //     int size = lines.length;
    //     float[][] kernel = new float[size][size];

    //     for (int i = 0; i < size; i++) {
    //         String[] line = split(lines[i], " ");
    //         for (int j = 0; j < size; j++) {
    //             kernel[i][j] = float(line[j]);
    //         }
    //     }
    // }

    PImage apply(PImage image, int x, int y) {
        color sum = 0;
        for (int i = 0; i < this.size; i++) {
            int xIndex = x - this.size / 2 + i;
            for (int j = 0; j < this.size; j++) {
                int yIndex = y - this.size / 2 + j;
                sum += image.get(xIndex, yIndex) * this.kernel[i][j];
            }
        }
        // return sum;
        return image;
    }
}
