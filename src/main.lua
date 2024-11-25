function love.load()
    WindowXPosition, WindowYPosition, WindowWidth, WindowHeight, Scale = 0, 0, 960, 540, 20

    DropInterval, DropSum = 1, 0

    love.window.setMode(WindowWidth, WindowHeight)

    Tetraminos = {}
    AddTetramino(CreateTetrimino())

    SpawnTetramino(Tetraminos[1]);
end

function love.draw()
    love.graphics.setColor(0, 0.4, 0.4)
    love.graphics.rectangle("fill", WindowXPosition, WindowYPosition, WindowWidth, WindowHeight)
    DrawTetraminos()
end

function love.update(dt)
    DropSum = DropSum + dt
    if DropSum >= DropInterval then
        DropTetraminos()
        DropSum = DropSum - DropInterval
    end
end

function DropTetraminos()
    local function drop(tetramino)
        tetramino.positionY = tetramino.positionY + Scale
    end

    ApplyToTetraminos(drop)
end

function DrawTetraminos()
    ApplyToTetraminos(DrawTetramino)
end

function DrawTetramino(tetramino)
    if tetramino == nil or tetramino.onScreen == false then
        return
    end
    love.graphics.setColor(0, 0, 0)
    love.graphics.rectangle("fill", tetramino.positionX, tetramino.positionY, tetramino.width, tetramino.heigth)

    love.graphics.setColor(tetramino.color.r, tetramino.color.g, tetramino.color.b)
    love.graphics.rectangle("fill", tetramino.positionX + (Scale / 10), tetramino.positionY + (Scale / 10),
        tetramino.width - (Scale / 5), tetramino.heigth - (Scale / 5))
end

function CreateTetrimino()
    local squareBlock = {
        id = "2x2",
        onScreen = false
    }
    return squareBlock;
end

function AddTetramino(tetramino)
    table.insert(Tetraminos, tetramino)
end

function SpawnTetramino(tetramino)
    tetramino.width = 2 * Scale
    tetramino.heigth = 2 * Scale
    tetramino.color = {
        r = 234,
        g = 221,
        b = 202
    }

    tetramino.positionX = WindowWidth / 2 - tetramino.width
    tetramino.positionY = 0 + tetramino.heigth

    tetramino.onScreen = true;
end

function ApplyToTetraminos(callback)
    for i = 1, #Tetraminos, 1 do
        callback(Tetraminos[i])
    end
end
