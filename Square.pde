
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
            this.giveBirth(false);
            break;
        case Birthing:
        case Alive:
            this.kill(false);
            break;
        }
    }

    boolean isAlive() {
        return this.status == Status.Birthing || this.status == Status.Alive;
    }

    void giveBirth(boolean animation) {
        if (animation) {
            this.status = Status.Birthing;
        } else {
            this.status = Status.Alive;
        }
    }
    
    void kill(boolean animation) {
        if (animation) {
            this.status = Status.Dying;
        } else {
            this.status = Status.Dead;
        }
    }
    
    void drawSquare(boolean borderOn) {
        // If we don't want a border then border needs to be same as fillColor
        // Else it has to be the opposit
        bordersColor = borderOn ? (fillColor == SQUARE_BORDER_OFF ? SQUARE_BORDER_ON : SQUARE_BORDER_OFF ) : fillColor;
        switch (status) {
            case Empty:
                fillColor = SQUARE_COLOR_DEAD;
                break;
            case Alive:
                fillColor = SQUARE_COLOR_ALIVE;
                break;
            case Dead:
                fillColor = SQUARE_COLOR_DEAD;
                break;
            case Dying:
                fillColor -= COLOR_ANIMATION_TICK;
                if (fillColor < SQUARE_COLOR_DEAD) {
                    fillColor = SQUARE_COLOR_DEAD;
                } else {
                    status = Status.Dead;
                }
                break;
            case Birthing:
                if (fillColor < SQUARE_COLOR_ALIVE)  {
                    fillColor += COLOR_ANIMATION_TICK;
                    if (fillColor > SQUARE_COLOR_ALIVE) {
                        fillColor = SQUARE_COLOR_ALIVE;
                    } 
                } else {
                    status = Status.Alive;
                }
                break;
            default:
            break;
        }
        fill(fillColor);
        stroke(bordersColor);
        square(posX, posY, size);
    }


}