
function love.load()
    x, y, w, h = 0, 0, 960, 540
    love.window.setMode(w, h)

    tetraminos = {}
    addTetramino(createTetrimino())
end

function love.draw()
    love.graphics.setColor(0,0.4,0.4)
    love.graphics.rectangle("fill", x, y ,w ,h)
end

function love.update()
    for i=1, #tetraminos, 1 do
        print(i, tetraminos[i].id)
    end
end

function createTetrimino()
    local squareBlock = {
        id = "2x2"
    }
    return squareBlock;
end

function addTetramino(tetramino)
    table.insert(tetraminos, tetramino)
end