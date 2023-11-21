TextPixelRenderer tpr;

void setup() {
    fullScreen(P3D);

    PFont font = createFont("fonts/LongCang-Regular.ttf", 20);
    textFont(font);

    ImageProcessor ip = new ImageProcessor("images/alien_mad.png");
    Kernel gauss = new Kernel("kernels/gauss.txt");
    Kernel fry = new Kernel("kernels/fry.txt");

    // String textFilename = "texts/chineese.txt";
    // String textFilename = "texts/english.txt";
    String textFilename = "texts/lostTime.txt";
    tpr = new TextPixelRenderer(ip, gauss, textFilename);
    textSize(24);
}

void draw() {
    background(8);
    tpr.render(10);
}
