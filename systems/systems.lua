
local systems = {}
local nodes = "input,output,gate"


-------------------------------------------------------------
systems.DrawSystem = Concord.system({
    pool = { "drawable"}
})

function systems.DrawSystem:draw()
    for _, e in ipairs(self.pool) do
        if string.find(nodes,e.type.type ) then
            love.graphics.setColor(1, 0, 0, 1)
            if e.logicValue.value then
                love.graphics.setColor(0, 1, 0, 1)
            end
            love.graphics.circle("fill", e.position.x, e.position.y, 5)
        elseif string.find("wire",e.type.type ) then
            love.graphics.setColor(1, 0, 0, 1)
            if e.logicValue.value then
                love.graphics.setColor(0, 1, 0, 1)
            end
            love.graphics.line(e.wire.x1, e.wire.y1, e.wire.x2, e.wire.y2)
        elseif string.find("AND",e.type.type ) then
            
            love.graphics.setColor(0, 0, 0.6, 1)
            love.graphics.rectangle("fill", e.position.x, e.position.y, 100, 100 )
        end
    end
end
function systems.DrawSystem:mousePressed(x, y, mbutton)
    for _, e in ipairs(self.pool) do
        if string.find(nodes,e.type.type ) then
            local dx,dy = math.abs(x-e.position.x),math.abs(y-e.position.y)
            if(math.sqrt(dx*dx+dy*dy) < 5) then
                e.logicValue.value = not e.logicValue.value
            end
        end
    end
end

-------------------------------
systems.UpdateSystem = Concord.system({
    pool = {"updateValue"}
})

function systems.UpdateSystem:update()
    for _, e in ipairs(self.pool) do
        if(e.line ~= nil) then
            if(e.type.type == 'input') then
                e:give("logicValue",e.line.value.logicValue.value)
                -- e.logicValue.value = e.line.value.logicValue.value
            end
            if(e.type.type == 'output') then
                e.line.value:give("logicValue",e.logicValue.value)
                -- e.line.value.logicValue.value = e.logicValue.value
            end
       end
    end
end






return systems
