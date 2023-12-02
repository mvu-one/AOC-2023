local nums = {
    'one', 'two', 'three', 'four',
    'five', 'six','seven', 'eight',
    'nine',
}

local reverse_nums = {}
for _, v in ipairs(nums) do
    table.insert(reverse_nums, v:reverse())
end

local function getFirstDigit(line, nums)
    for i = 1, #line do
        local is_num = tonumber(line:sub(i, i))
        if is_num then
            return is_num
        end
        for n, val in ipairs(nums) do
            if line:sub(i, i + #val - 1) == val then
                return n
            end
        end
    end
end

local file = io.open("01.txt", "r")
local num2 = 0
if file == nil then
    error("file not found")
end
for line in file:lines() do
    num2 = num2 + tonumber(
        getFirstDigit(line, nums) ..
        getFirstDigit(line:reverse(), reverse_nums))
end
file:close()

print(num2)
