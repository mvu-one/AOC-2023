local function combineDigits(line)
    local words = {}
    for w in line:gmatch("%d") do
        table.insert(words, w)
    end
    if #words == 1 then
        table.insert(words, words[1])
    end
    return tonumber(words[1] .. words[#words])
end

local file = io.open("01.txt", "r")
local num1 = 0
if file == nil then
    error("file not found")
end
for line in file:lines() do
    num1 = num1 + combineDigits(line)
end
file:close()

print(num1)