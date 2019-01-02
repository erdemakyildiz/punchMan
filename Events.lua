local class = require("class")

local Events = class:derive("Events")

function Events:new(eventMustExist)
    self.handlers = {}
    self.eventMustExist = eventMustExist or false
end

local function indexOf(eventTable, callback)
    if eventTable == nil or callback == nil then
        return -1
    end

    for i = 0, #eventTable do
        if eventTable[i] == callback then
            return i
        end
    end

    return -1
end

function Events:add(eventType)
    assert(self.handlers[eventType] == nil, "event var zaten")
    self.handlers[eventType] = {}
end

function Events:remove(eventType)
    self.handlers[eventType] = nil
end

function Events:hook(eventType, callback)
    assert(type(callback) == "function", "callback parametresi function olmak zorunda")

    if self.eventMustExist then
        assert(self.handlers[eventType] ~= nil, "event type yok ki")
    elseif self.handlers[eventType] == nil then
        self:add(eventType)
    end

    assert(indexOf(self.handlers[eventType], callback) == -1, "callback var zaten")

    local tbl = self.handlers[eventType]
    tbl[#tbl + 1] = callback
end

function Events:unhook(eventType, callback)
    assert(type(callback) == "function", "callback parametresi function olmak zorunda")

    if self.handlers[eventType] == nil then
        return
    end

    local index = indexOf(self.handlers[eventType], callback)
    if index > -1 then
        table.remove(self.handlers[eventType], index)
    end
end

function Events:clear(eventType)
    if eventType == nil then
        for k, v in pairs(self.handlers) do
            self.handlers[k] = {}
        end
    elseif self.handlers[eventType] ~= nil then
        self.handlers[eventType] = {}
    end
end

function Events:invoke(eventType, ...)
    if self.handlers[type] == nil then
        return
    end

    local tbl = self.handlers[eventType]
    for i = 1, #tbl do
        tbl[i](...)
    end
end

return Events
