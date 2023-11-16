void setup() {
    fullScreen(P3D);
    background(8);

    ImageProcessor ip = new ImageProcessor("images/despair.png");
    Kernel gauss = new Kernel("kernels/gauss.txt");
    TextPixelRenderer tpr = new TextPixelRenderer(ip, gauss, "texts/lostTime.txt");

    tpr.render(10);
    // tpr.renderImage();
}

void draw() {
}
