TextPixelRenderer tpr;

void setup() {
    fullScreen(P3D);
    // size(800, 800, P3D);
    PFont font = createFont("fonts/LongCang-Regular.ttf", 20);
    textFont(font);
    
    // ImageProcessor ip = new ImageProcessor("images/despair.png");
    ImageProcessor ip = new ImageProcessor("images/alien_mad.png");
    Kernel gauss = new Kernel("kernels/gauss.txt");
    Kernel fry = new Kernel("kernels/fry.txt");

    String textFilename = "texts/chineese.txt";
    // String textFilename = "texts/english.txt";
    // String textFilename = "texts/lostTime.txt";
    tpr = new TextPixelRenderer(ip, gauss, textFilename);
    textSize(20);
    // tpr = new TextPixelRenderer(ip, fry, "texts/lostTime.txt");
    
    // ip.renderConvolution(gauss, 10);
    // ip.renderConvolution(fry, 1);
    // tpr.render(7);
}

void draw() {
    background(8);
    tpr.render(10);
}
