TextPixelRenderer tpr;

void setup() {
    fullScreen(P3D);
    // size(800, 800);
    
    ImageProcessor ip = new ImageProcessor("images/despair.png");
    Kernel gauss = new Kernel("kernels/gauss.txt");
    Kernel fry = new Kernel("kernels/fry.txt");
    tpr = new TextPixelRenderer(ip, gauss, "texts/lostTime.txt");
    // tpr = new TextPixelRenderer(ip, fry, "texts/lostTime.txt");
    
    // ip.renderConvolution(gauss, 10);
    // ip.renderConvolution(fry, 1);
    // tpr.render(7);
}

void draw() {
    background(8);
    tpr.render(8);
}
