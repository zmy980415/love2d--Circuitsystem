Concord = require("concord")
require 'components.components'
local systems = require 'systems.systems'
Node = require 'entitys.node'

local world = Concord.world()

local in1 = Node.input(world,{x=100,y=5})

local wire1 = Node.wire(world,{x1=110,y1=100,x2=200,y2=300})
in1:addWire(wire1)

local out1 = Node.output(world,{x=11,y=60})
local wire2 = Node.wire(world,{x1=200,y1=400,x2=200,y2=300})
out1:addWire(wire2)
Node.AND(world,{x=500,y=60})


world:addSystems(systems.DrawSystem)
world:addSystems(systems.UpdateSystem)

-- Emit the events
function love.update(dt)
    world:emit("update", dt)
end

function love.draw()
    world:emit("draw")
end

function love.keypressed(key, code, isRepeat)

end

function love.mousepressed(x, y, mbutton)
    world:emit("mousePressed",x, y, mbutton)
end



