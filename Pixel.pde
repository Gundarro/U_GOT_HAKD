class Pixel {
    color pColor;
    PVector originalPosition;
    PVector position;
    PVector originalRotation;
    PVector rotation;

    Pixel (color pColor, PVector originalPosition, PVector originalRotation) {
        this.pColor = pColor;
        this.originalPosition = originalPosition;
        this.position = originalPosition.copy();
        this.originalRotation = originalRotation;
        this.rotation = originalRotation.copy();
    }

    void update() {
        position.x = originalPosition.x + sin(frameCount * 0.01 + originalPosition.x) * 10;
        position.y = originalPosition.y + sin(frameCount * 0.01 + originalPosition.y) * 10;
        rotation.x = originalRotation.x + sin(frameCount * 0.01 + originalRotation.x) * 10;
        rotation.y = originalRotation.y + sin(frameCount * 0.01 + originalRotation.y) * 10;
    }
}
