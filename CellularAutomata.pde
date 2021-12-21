Grid grid;
final int windowHeight = 360;
final int windowWidth = 640;
final float squareSize = 20;
boolean running = false;
int tick = 0;
int runCounter = 0;
boolean[] rules = new boolean[8];
ArrayList<Runnable> arraylist = new ArrayList<Runnable>();

void settings() {
    size(windowWidth, windowHeight);
}

void setup() {
    grid = new Grid(windowWidth, windowHeight, squareSize);
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
        if (tick > 3) {
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
  int squareX = floor(mouseX/ squareSize);
  int squareY = floor(mouseY / squareSize);

  if (squareY < grid.grid.length && squareX < grid.grid[squareY].length) {
    grid.grid[squareY][squareX].manualTrigger();
  }
}

void keyPressed() {
    if (key == ' ') {
        running = !running;
    } else if (key == 'c') {
        grid.initGrid();
        initRules(8, false);
    } else if (key == 'r') {
        grid.randomizeGrid();
        initRules(8, true);
    }
}