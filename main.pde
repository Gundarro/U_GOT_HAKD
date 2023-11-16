void setup() {
    // fullScreen(P3D);
    background(0);
    size(800, 600, P3D);  // Use P3D renderer for 3D capabilities


    ImageProcessor ip = new ImageProcessor(loadImage("images/despair.png"));
    // Kernel gauss = Kernel.fromFile("kernels/gauss.txt");
    String[] kernelLines = loadStrings("kernels/gauss.txt");
    int size = kernelLines.length;
    float[][] kernel = new float[size][size];

    for (int i = 0; i < size; i++) {
        String[] line = split(kernelLines[i], " ");
        for (int j = 0; j < size; j++) {
            kernel[i][j] = float(line[j]);
        }
    }

    Kernel gauss = new Kernel(kernel);
    String[] lines = loadStrings("texts/lostTime.txt");


    ip.toTextPixelRenderer(gauss, join(lines, " ")).render(10);
}

void draw() {
}
