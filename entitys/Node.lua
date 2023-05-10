-- node.lua


local Node = {}

function Node.input(world, args)
  local input = Concord.entity(world)
    :give("position", args.x, args.y)
    :give("logicValue", false)
    :give("updateValue")
    :give("drawable")
    :give("type","input")
  function input:addWire(line)
    self:give("line",line)
  end
  return input
end

function Node.output(world, args)
  local output = Concord.entity(world)
    :give("position", args.x, args.y)
    :give("logicValue", false)
    :give("updateValue")
    :give("drawable")
    :give("type","output")
    function output:addWire(line)
      self:give("line",line)
    end
  return output
end

function Node.gate(world, args)
  local gate = Concord.entity(world)
    :give("position", args.x, args.y)
    :give("logicValue", false)
    :give("drawable")
    :give("updateValue")
    :give("type","gate")
    function gate:addWire(line)
      self:give("line",line)
    end
    return gate
end

function Node.wire(world,args)
  return Concord.entity(world)
    :give("wire", args.x1, args.y1,args.x2, args.y2)
    :give("logicValue", false)
    :give("drawable")
    :give("updateValue")
    :give("type","wire")
end


function Node.AND(world,args)
  local ANDEntity = Concord.entity(world)
    :give("position", args.x, args.y)
    :give("logicValue", false)
    :give("inputs",{})
    :give("logic_and")
    :give("drawable")
    :give("updateValue")
    :give("type","AND")
  function ANDEntity:setInput1(input)
    local inputs =self:get("inputs")
    inputs.value[1] = input
    self:give("inputs",inputs)
  end
  function ANDEntity:setInput2(input)
    local inputs =self:get("inputs")
    inputs.value[2] = input
    self:give("inputs",inputs)
  end

  ANDEntity:setInput1(Node.input(world,{x=args.x+20,y=args.y - 3}))
  ANDEntity:setInput1(Node.input(world,{x=args.x+60,y=args.y - 3}))

  return ANDEntity
end



return Node
