local cube_count = {red=12, blue=14, green=13}
local function parseGame(line)
    -- Returns 0 or Game ID if the game was possible
    local game, vals = line:match("(.*): (.*)")
    game = game:match("%d+")
    for round in (vals .. ";"):gmatch("([^;]+)") do
        print(round)
        for cube in (round .. ','):gmatch("([^,]+)") do
            local number, color = cube:match("(%d+) (%w+)")
            if cube_count[color] < tonumber(number) then
                print('impossible: ' .. line)
                return 0
            end
        end
    end
    return tonumber(game)
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