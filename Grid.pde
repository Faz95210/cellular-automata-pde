
class Grid {
    final int rows;
    final int columns;
    final float width;
    final float height;
    Square[][] grid;
    final float squareSize;
    Grid(final float width, final float height, final float squareSize) {
        this.rows = floor(height/squareSize);
        this.columns = floor(width/squareSize);
        this.width = width;
        this.height = height;
        this.squareSize = squareSize;
        this.grid = new Square[rows][columns];
        this.initGrid();
    }

    Status analyzeNeighbors(final int y, final int x) {
        // 1 All top
        if (
            grid[y - 1][x].isAlive()
            && (x > 0 && grid[y - 1][x - 1].isAlive())
            && (x < grid[y - 1].length - 1 && grid[y - 1][x + 1].isAlive())
        ) {
            return rules[0] == true ? Status.Birthing : Status.Dying;
        }
        // 2 Top Left + TOP
        if (
            grid[y - 1][x].isAlive()
            && (x > 0 && grid[y - 1][x - 1].isAlive())
            && (x < grid[y - 1].length - 1 && !grid[y - 1][x + 1].isAlive())
        ) {
            return rules[1] == true ? Status.Birthing : Status.Dying;
        }
        // 3 Top Left + Top Right
        if (
            !grid[y - 1][x].isAlive()
            && (x > 0 && grid[y - 1][x - 1].isAlive())
            && (x < grid[y - 1].length - 1 && grid[y - 1][x + 1].isAlive())
        ) {
            return rules[2] == true ? Status.Birthing : Status.Dying;
        }
        // 4 Top Left
        if (
            !grid[y - 1][x].isAlive()
            && (x > 0 && grid[y - 1][x - 1].isAlive())
            && (x < grid[y - 1].length - 1 && !grid[y - 1][x + 1].isAlive())
        ) {
            return rules[3] == true ? Status.Birthing : Status.Dying;
        }
        // 5 Top + Top Right
        if (
            grid[y - 1][x].isAlive()
            && (x > 0 && !grid[y - 1][x - 1].isAlive())
            && (x < grid[y - 1].length - 1 && grid[y - 1][x + 1].isAlive())
        ) {
            return rules[4] == true ? Status.Birthing : Status.Dying;
        }
        // 6 Top
        if (
            grid[y - 1][x].isAlive()
            && (x > 0 && !grid[y - 1][x - 1].isAlive())
            && (x < grid[y - 1].length - 1 && !grid[y - 1][x + 1].isAlive())
        ) {
            return rules[5] == true ? Status.Birthing : Status.Dying;
        }
        // 7 Top Right
        if (
            !grid[y - 1][x].isAlive()
            && (x > 0 && !grid[y - 1][x - 1].isAlive())
            && (x < grid[y - 1].length - 1 && grid[y - 1][x + 1].isAlive())
        ) {
            return rules[6] == true ? Status.Birthing : Status.Dying;
        }
        // 8 None
        if (
            !grid[y - 1][x].isAlive()
            && (x > 0 && !grid[y - 1][x - 1].isAlive())
            && (x < grid[y - 1].length - 1 && !grid[y - 1][x + 1].isAlive())
        ) {
            return rules[7] == true ? Status.Birthing : Status.Dying;
        }
        return grid[y][x].status;
    }

    void processGrid() {
        final ArrayList<Square> dyingSquares = new ArrayList<Square>();
        final ArrayList<Square> birthingSquares = new ArrayList<Square>();

        // Don't process the first row.
         for (int y = 1; y < this.grid.length; y++) {
            for (int x = 0; x < this.grid[y].length; x++) {
                final Status status = analyzeNeighbors(y, x);
                if (status == Status.Birthing)
                    birthingSquares.add(this.grid[y][x]);
                else if (status == Status.Dying)
                    dyingSquares.add(this.grid[y][x]);
            }
        }    

        for (final Square square : dyingSquares) {
            square.status = Status.Dying;
        }
        for (final Square square : birthingSquares) {
            square.status = Status.Birthing;
        }
    }

    void initGrid() {
        for (int y = 0; y < this.grid.length; y++) {
            for (int x = 0; x < this.grid[y].length; x++) {
                this.grid[y][x] = new Square(squareSize * x, squareSize * y, squareSize);
            }
        }
    }

    //Shamelessly copied from the documentation.
    void randomizeGrid() {
        for (int y = 0; y < this.grid.length; y++) {
            for (int x = 0; x < this.grid[y].length; x++) {
                float state = random (100);
                    grid[y][x].status = Status.Dead;
                if (state < 15) {
                    grid[y][x].status = Status.Alive;
                }
            }
        }
    }

    void drawGrid() {
        for (int y = 0; y < this.grid.length; y++) {
            for (int x = 0; x < this.grid[y].length; x++) {
                this.grid[y][x].drawSquare();
            }
        }
    }

}