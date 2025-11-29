--[[
Code "inspired" (taken and then modified to fit my needs)
from ortlab, which was made by eremel
]]
local order = {
    "ModCalc",
    "FoolOfManyTalents",
    "NotQuiteNepo",
}
for _, key in ipairs(order) do
    SMODS.load_file('src/'..key..'.lua')()
end