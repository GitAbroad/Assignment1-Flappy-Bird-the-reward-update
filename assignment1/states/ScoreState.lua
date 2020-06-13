--[[
    ScoreState Class
    Author: Colton Ogden
    cogden@cs50.harvard.edu

    A simple state used to display the player's score before they
    transition back into the play state. Transitioned to from the
    PlayState when they collide with a Pipe.
]]

ScoreState = Class{__includes = BaseState}

--[[
    When we enter the score state, we expect to receive the score
    from the play state so we know what to render to the State.
]]
function ScoreState:enter(params)
    self.score = params.score

    self.goldMedal = love.graphics.newImage('goldMedal.jpg')
    self.silverMedal = love.graphics.newImage('silverMedal.jpg')
    self.bronzeMedal = love.graphics.newImage('bronzeMedal.jpg')
end
function ScoreState:update(dt)
    -- go back to play if enter is pressed
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('countdown')
    end
end

function ScoreState:render()
    -- simply render the score to the middle of the screen
    love.graphics.setFont(flappyFont)
    love.graphics.printf('Oof! You lost!', 0, 30, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(mediumFont)
    love.graphics.printf('Score: ' .. tostring(self.score), 0, 70, VIRTUAL_WIDTH, 'center')

    local recieveMedal = nil
    local medalType = nil
    if self.score >= 15 then
        recievedMedal = self.goldMedal
        medalType = 'gold'
    elseif self.score >= 10 then
        recievedMedal = self.silverMedal
        medalType = 'silver'
    elseif self.score >= 5 then
        recievedMedal = self.bronzeMedal
        medalType = 'bronze'
    end

    if recievedMedal ~= nil then
        love.graphics.printf('Congratulations! You earned a ' .. medalType .. ' medal!', 0, 90, VIRTUAL_WIDTH, 'center')
        love.graphics.draw(recievedMedal, VIRTUAL_WIDTH / 2 - recievedMedal:getWidth() / 2, 120)
    end

    love.graphics.printf('Press Enter to Play Again!', 0, 210, VIRTUAL_WIDTH, 'center')
end