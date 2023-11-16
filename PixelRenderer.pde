abstract class PixelRenderer {
    protected Pixel[][] pixelGrid;
    abstract void render(int granularity);

    PixelRenderer(Pixel[][] pixelGrid) {
        this.pixelGrid = pixelGrid;
    }

    PixelRenderer(ImageProcessor ip, Kernel kernel) {
        this.pixelGrid = ip.toPixelGrid(kernel);
    }
}
