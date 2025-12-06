ball = {}
ball.width = 20
ball.height = 20
ball.x = 0
ball.y = 0
ball.vitesse_x = 150
ball.vitesse_y = 150

pad = {}
pad.width = 20
pad.height = 100
pad.x = 0
pad.y = 0

score = {player = 0, computer = 0}

listeTrails = {}


function love.load()
    ball.x = love.graphics.getWidth() / 2 - ball.width / 2
    ball.y = love.graphics.getHeight() / 2 - ball.height / 2
end

function love.update(dt)
    if love.keyboard.isDown("up") then
        pad.y = pad.y - 200 * dt
        print("Up key is pressed")
    end
    
    if love.keyboard.isDown("down") then
        pad.y = pad.y + 200 * dt
        print("Down key is pressed")
    end

    local speed_increase = 5 * dt
    if ball.vitesse_x > 0 then
        ball.vitesse_x = ball.vitesse_x + speed_increase
    else
        ball.vitesse_x = ball.vitesse_x - speed_increase
    end
    if ball.vitesse_y > 0 then
        ball.vitesse_y = ball.vitesse_y + speed_increase
    else
        ball.vitesse_y = ball.vitesse_y - speed_increase
    end

    ball.x = ball.x + ball.vitesse_x * dt
    ball.y = ball.y + ball.vitesse_y * dt

    table.insert(listeTrails, {x = ball.x, y = ball.y, width = ball.width, height = ball.height})
    if #listeTrails > 50 then
        table.remove(listeTrails, 1)
    end

    if ball.y + ball.height > love.graphics.getHeight() or ball.y < 0 then
        ball.vitesse_y = -ball.vitesse_y
    end
    if ball.x + ball.width > love.graphics.getWidth() or ball.x < 0 then
        ball.vitesse_x = -ball.vitesse_x
    end
    if pad.y < 0 then
        pad.y = 0
    end
    if pad.y + pad.height > love.graphics.getHeight() then
        pad.y = love.graphics.getHeight() - pad.height
    end
    
    if ball.x < pad.x + pad.width and
       ball.x + ball.width > pad.x and
       ball.y < pad.y + pad.height and
       ball.y + ball.height > pad.y then
        ball.vitesse_x = -ball.vitesse_x
        score.player = score.player + 1
    end

    if ball.x < 0 then
        ball.x = love.graphics.getWidth() / 2 - ball.width / 2
        ball.y = love.graphics.getHeight() / 2 - ball.height / 2
        score.computer = score.computer + 1
    end
end

function love.draw()
    love.graphics.rectangle("fill", ball.x, ball.y, ball.width, ball.height)
    love.graphics.rectangle("fill", pad.x, pad.y, pad.width, pad.height)
    love.graphics.print("Player: " .. score.player .. "  Computer: " .. score.computer, 10, 10)

    for num, trail in ipairs(listeTrails) do 
        local alpha = num / #listeTrails
        love.graphics.setColor(1, 1, 1, alpha)
        love.graphics.rectangle("fill", trail.x, trail.y, trail.width, trail.height)
        love.graphics.setColor(1, 1, 1, 1)
    end
end
