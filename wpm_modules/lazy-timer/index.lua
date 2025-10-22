local env = select(2, ...)
local package = env.WPM:New("wpm_modules/lazy-timer")

local SET_SCRIPT_FUNC = getmetatable(CreateFrame("Frame")).__index.SetScript




local function handleOnUpdate(self, elapsed)
    self.__elapsed = self.__elapsed + elapsed
    if self.__elapsed >= self.__delay then
        self.__elapsed = 0

        SET_SCRIPT_FUNC(self, "OnUpdate", nil)
        self.__action(self)
    end
end





local methods = {}

function methods.SetAction(self, action)
    self.__action = action
end

function methods.Start(self, delay)
    self.__delay = delay
    SET_SCRIPT_FUNC(self, "OnUpdate", handleOnUpdate)
end

local meta = {
    __index = function(tbl, k)
        if methods[k] then
            return methods[k]
        end
        return rawget(tbl, k)
    end
}





function package:New()
    local timer = CreateFrame("Frame")
    setmetatable(timer, meta)
    timer.__elapsed = 0
    timer.__action = nil
    timer.__delay = 0

    return timer
end
