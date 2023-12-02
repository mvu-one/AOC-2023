local function parseGame(line)
    -- Returns "power" of a game
    -- defined as the minimum number of each
    -- colored cube needed to make each game possible
    -- multiplied together
    local game, vals = line:match("(.*): (.*)")
    game = game:match("%d+")
    local mins = {
        red=0,
        green=0,
        blue=0,
    }
    for round in (vals .. ";"):gmatch("([^;]+)") do
        for cube in (round .. ','):gmatch("([^,]+)") do
            local number, color = cube:match("(%d+) (%w+)")
                mins[color] = math.max(mins[color], tonumber(number))
            end
        end
    local pow = 1
    for k, v in pairs(mins) do
        pow = pow * v
    end
    return pow
end

local file = io.open("02.txt", "r")
local num = 0
if file == nil then
    error("file not found")
end
for line in file:lines() do
    num = num + parseGame(line)
end
file:close()
print(num)