import gifAnimation.*;
class Explosion {
  private float x, y;
  private Gif anim;
  private int startTime;

  Explosion(float x, float y, Gif anim) {
    this.x = x;
    this.y = y;
    this.anim = anim;
    this.startTime = millis();
    this.anim.play();
  }

  void draw() {
    image(anim, x, y);
  }

  boolean isFinished() {
    return millis() - startTime > 500;
  }
}
