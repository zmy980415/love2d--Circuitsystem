Concord.component("position", function(c, x, y)
    c.x = x or 0
    c.y = y or 0
end)

Concord.component("wire", function(c, x1, y1, x2, y2)
    c.x1 = x1 or 0
    c.y1 = y1 or 0
    c.x2 = x2 or 0
    c.y2 = y2 or 0
end)
Concord.component("line", function(c, line)
    c.value = line
end)

Concord.component("logicValue", function(c, v)
    c.value = v or false
end)

Concord.component("drawable", function(c)

end)

Concord.component("type", function(c, type)
    c.type = type
end)

Concord.component("updateValue", function(c)

end)
-- 多输入
Concord.component("inputs", function(c,v)
    c.value = v
end)
Concord.component("logic_and", function(c,v)

end)

-- 鼠标点击选择原件
Concord.component("select_state", function(c,v)
    c.value = v
end)

Concord.component("rect", function(c,width,height)
    c.width = width
    c.height = height
end)

