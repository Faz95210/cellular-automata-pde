
enum Status {
    Alive,
    Birthing,
    Dying,
    Dead,
    Empty
}

class Square {
    
    final float size;
    final float posX;
    final float posY;
    int fillColor = 0;
    int bordersColor = 0;
    Status status = Status.Empty;
    
    Square(final float posX, final float posY, final float size) {
        this.posX = posX;
        this.posY = posY;
        this.size = size;
    }



    void manualTrigger() {
        switch (this.status) {
        case Empty:
        case Dying:
        case Dead:
            this.status = Status.Birthing;
            break;
        case Birthing:
        case Alive:
            this.status = Status.Dying;
            break;
        }
    }

    boolean isAlive() {
        return this.status == Status.Birthing || this.status == Status.Alive;
    }
    
    void drawSquare() {
        switch (status) {
            case Empty:
                fillColor = 0;
                bordersColor = 0;
                break;
            case Alive:
                fillColor = 250;
                bordersColor = 0;
                break;
            case Dead:
                fillColor = 0;
                bordersColor = 0;
                break;
            case Dying:
                // This square is dying so we draw it first so as to not override death animation.
                bordersColor = 0;
                fillColor -= 25;
                if (fillColor < 0) {
                    fillColor = 0;
                } else {
                    status = Status.Dead;
                }
                break;
            case Birthing:
                if (fillColor < 250)  {
                    fillColor += 25;
                    if (fillColor > 250) fillColor = 250;
                } else {
                    status = Status.Alive;
                }
                bordersColor = 0;
                break;
            default:
            break;
        }
        fill(fillColor);
        stroke(bordersColor);
        square(posX, posY, size);
    }


}