local Class = {}
Class.__index = Class

function Class:new()
end

function Class:derive(type)
    local cls = {}
    cls.type = type
    cls.__index = cls
    cls.super = self
    setmetatable(cls, self)

    return cls
end

function Class:__call(...)
    local instance = setmetatable({}, self)
    instance:new(...)
    
    return instance
end

function Class:getType()
    return self.type
end

return Class