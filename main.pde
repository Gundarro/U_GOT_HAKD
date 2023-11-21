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

import processing.video.*;

Capture cam;

void setup2() {
    size(640, 480);
    
    String[] cameras = Capture.list();
    
    if (cameras.length == 0) {
        println("There are no cameras available for capture.");
        exit();
    } else {
        println("Available cameras:");
        for (int i = 0; i < cameras.length; i++) {
            println(cameras[i]);
        }
        
        // The camera can be initialized directly using an 
        // element from the array returned by list():
        cam = new Capture(this, cameras[0]);
        cam.start();     
    }   
}

void draw3() {
    if (cam.available() == true) {
        cam.read();
    }
    //  image(cam, 0, 0);
    ImageProcessor ip = new ImageProcessor(cam);
    ip.renderConvolution(new Kernel("kernels/gauss.txt"), 1);
    
    // Kernel gauss = new Kernel("kernels/gauss.txt");
    // TextPixelRenderer tpr = new TextPixelRenderer(ip, gauss, "texts/lostTime.txt");
    // tpr.render(7);
    
    //The following does the same, and is faster when just drawing the image
    //without any additional resizing, transformations, or tint.
    //set(0, 0, cam);
}
