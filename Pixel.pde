class Pixel {
    color originalColor;
    color pColor;
    PVector originalPosition;
    PVector position;
    PVector originalRotation;
    PVector rotation;

    Pixel (color pColor, PVector originalPosition, PVector originalRotation) {
        this.originalColor = pColor;
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

        pColor = color(
            red(originalColor) + sin(frameCount * 0.01 + originalColor) * 10,
            green(originalColor) + sin(frameCount * 0.01 + originalColor) * 10,
            blue(originalColor) + sin(frameCount * 0.01 + originalColor) * 10
        );
    }

    void stepToOrigin(float percentage) {
        position.x = lerp(position.x, originalPosition.x, percentage);
        position.y = lerp(position.y, originalPosition.y, percentage);
        rotation.x = lerp(rotation.x, originalRotation.x, percentage);
        rotation.y = lerp(rotation.y, originalRotation.y, percentage);

        pColor = lerpColor(pColor, originalColor, percentage);
    }

    void makeReadable(float percentage) {
        // rotation.y = 0 means 100% readable
        // original rotation.y = 1 means 0% readable
        rotation.y = lerp(rotation.y, 0, percentage);

        // white means 100% readable
        // original color means 0% readable

        pColor = lerpColor(pColor, color(255), percentage);


    }
}
