
local systems = {}
local nodes = "input,output,gate"


------------------------------绘制系统，不同的type需要新增判断和绘制-------------------------------
systems.DrawSystem = Concord.system({
    pool = { "drawable"}
})

function systems.DrawSystem:draw()
    for _, e in ipairs(self.pool) do
        local select_state = e:get("select_state")
        local state = false
        if select_state ~= nil then
            state = select_state.value
        end
        
        if string.find(nodes,e.type.type ) then
            if state then
                love.graphics.setColor(0.2, 0.9, 0.1, 1)
                love.graphics.circle("line", e.position.x, e.position.y, 7)
            end
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
            if state then
                love.graphics.setColor(0.2, 0.9, 0.1, 1)
            end
            love.graphics.line(e.wire.x1, e.wire.y1, e.wire.x2, e.wire.y2)
        elseif string.find("AND",e.type.type ) then
            
            if state then
                love.graphics.setColor(0.2, 0.9, 0.1, 1)
                love.graphics.rectangle("fill", e.position.x -2, e.position.y -2, 100+4, 100+4 )
            end
            love.graphics.setColor(0, 0, 0.6, 1)
            
            love.graphics.rectangle("fill", e.position.x, e.position.y, 100, 100 )
        end
    end
end
function systems.DrawSystem:mousePressed(x, y, mbutton)
    for _, e in ipairs(self.pool) do
        if mbutton == 1 then
            if string.find(nodes,e.type.type ) then
                local dx,dy = math.abs(x-e.position.x),math.abs(y-e.position.y)
                if(math.sqrt(dx*dx+dy*dy) < 5) then
                    e.logicValue.value = not e.logicValue.value
                end
            end
        end
    end
end

------------------------需要更新值的使用此系统-----------------------------
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
function systems.UpdateSystem:mousePressed(x, y, mbutton)
    for _, e in ipairs(self.pool) do
        if mbutton == 2 then
            if string.find(nodes,e.type.type ) then
                local dx,dy = math.abs(x-e.position.x),math.abs(y-e.position.y)
                if(math.sqrt(dx*dx+dy*dy) < 5) then
                    e.select_state.value = not e.select_state.value
                end
            end
            if e.type.type == "AND" then
                local dx = math.abs(e.position.x + e.rect.width/2  - x)
                local dy = math.abs(e.position.y + e.rect.height/2 - y)
                print(dx,dy)
                if dx < e.rect.width/2 and dy < e.rect.height/2  then
                    print("---",e.select_state.value)
                    e.select_state.value = not e.select_state.value
                end
            end
        end
    end
end





return systems
