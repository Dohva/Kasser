function love.load()
    WindowXPosition, WindowYPosition, WindowWidth, WindowHeight, Scale = 0, 0, 960, 540, 20

    DropInterval, DropSum = 1, 0

    love.window.setMode(WindowWidth, WindowHeight)

    Blocks = {}
    AddBlock(CreateTetrimino())

    SpawnBlock(Blocks[1]);
end

function love.draw()
    love.graphics.setColor(0, 0.4, 0.4)
    love.graphics.rectangle("fill", WindowXPosition, WindowYPosition, WindowWidth, WindowHeight)
    DrawBlocks()
end

function love.update(dt)
    DropSum = DropSum + dt
    if DropSum >= DropInterval then
        DropBlocks()
        DropSum = DropSum - DropInterval
    end
end

function DropBlocks()
    local function drop(block)
        block.positionY = block.positionY + Scale
    end
    for i = 1, #Blocks, 1 do
        local block = Blocks[i]
        if (not CollidesWithFloor(block)) then
            drop(Blocks[i])
        end
    end
end

function CollidesWithFloor(block)
    local lowestYCoordinate = GetBlocksLowestPoint(block)
    return lowestYCoordinate >= WindowHeight
end

function GetBlocksLowestPoint(block)
    local square = function(block) 
	    return block.positionY + Scale * 2
    end
    local switch = {
        ["2x2"] = square
    }

    local func = switch[block.id]

    return func(block)
end


function DrawBlocks()
    ApplyToBlocks(DrawBlock)
end

function DrawBlock(block)
    if block == nil or block.onScreen == false then
        return
    end
    love.graphics.setColor(0, 0, 0)
    love.graphics.rectangle("fill", block.positionX, block.positionY, block.width, block.heigth)

    love.graphics.setColor(block.color.r, block.color.g, block.color.b)
    love.graphics.rectangle("fill", block.positionX + (Scale / 10), block.positionY + (Scale / 10),
        block.width - (Scale / 5), block.heigth - (Scale / 5))
end

function CreateTetrimino()
    local squareBlock = {
        id = "2x2",
        onScreen = false
    }
    return squareBlock;
end

function AddBlock(block)
    table.insert(Blocks, block)
end

function SpawnBlock(block)
    block.width = 2 * Scale
    block.heigth = 2 * Scale
    block.color = {
        r = 234,
        g = 221,
        b = 202
    }

    block.positionX = WindowWidth / 2 - block.width
    block.positionY = 0 + block.heigth

    block.onScreen = true;
end

function ApplyToBlocks(callback)
    for i = 1, #Blocks, 1 do
        callback(Blocks[i])
    end
end
