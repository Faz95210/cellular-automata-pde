static final int WINDOW_HEIGHT = 600;
static final int WINDOW_WIDTH  = 1000;
static final float SQUARE_SIZE = 20;
static final int SQUARE_COLOR_DEAD = 0;
static final int SQUARE_COLOR_ALIVE = 250;
static final int SQUARE_BORDER_OFF = 0;
static final int SQUARE_BORDER_ON = 250;
static final int TICK_BETWEEN_RUN = 10;
static final int COLOR_ANIMATION_TICK  = (SQUARE_COLOR_ALIVE - SQUARE_COLOR_DEAD) / TICK_BETWEEN_RUN;

boolean[] rules = new boolean[8];
ArrayList<Runnable> arraylist = new ArrayList<Runnable>();

Grid grid;
boolean running = false;
int tick = 0;
int runCounter = 0;

void settings() {
    size(WINDOW_WIDTH, WINDOW_HEIGHT);
}

void setup() {
    grid = new Grid(WINDOW_WIDTH, WINDOW_HEIGHT, SQUARE_SIZE);
    background(0);
    initRules(8, false);
    frameRate(30);

}

void initRules(int size, boolean random) {
    if (random) {
        for (int i = 0; i < 8; i++) {
            rules[i] = floor(random(100) % 2) == 0;
        }
    } else {
        rules[0] = false;
        rules[1] = false;
        rules[2] = false;
        rules[3] = true;
        rules[4] = true;
        rules[5] = true;
        rules[6] = true;
        rules[7] = false;
    }
}

void draw() {
    grid.drawGrid();
    if (running) {
        if (tick > TICK_BETWEEN_RUN) {
            grid.processGrid();
            tick = 0;
            runCounter++;
            if (runCounter > grid.rows) {
                runCounter = 0;
                initRules(8, true);
            }
        } else {
            tick += 1;
        }
    }
}

void mousePressed() {
  int squareX = floor(mouseX/ SQUARE_SIZE);
  int squareY = floor(mouseY / SQUARE_SIZE);

  if (squareY < grid.grid.length && squareX < grid.grid[squareY].length) {
    grid.grid[squareY][squareX].manualTrigger();
  }
}

void keyPressed() {
    switch (key) {
        case ' ': 
            running = !running;
            break;
        case 'c' :
        case 'C' :
            grid.initGrid();
            initRules(8, false);
            break;
        case 'r' :
        case 'R' :
            grid.randomizeGrid();
            initRules(8, true);
            break;
        case 'g' :
        case 'G' :
            grid.borderOn = !grid.borderOn;
            break;
        case 'a' :
        case 'A' :
            grid.animationOn = !grid.animationOn;
            break;
        default :
            break;
    }
}