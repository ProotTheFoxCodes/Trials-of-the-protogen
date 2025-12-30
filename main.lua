--[[
Code "inspired" (taken and then modified to fit my needs)
from ortalab, which was made by eremel
]]
local order = {
    "ModGlobal",
    "ahf2",
    "FoolOfManyTalents",
    --WIP
    --"WardenOfWine",
    "NotQuiteNepo",
    "Flawless4oak",
}
for _, key in ipairs(order) do
    assert(SMODS.load_file('src/'..key..'.lua'))()
end