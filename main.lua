--[[
Code "inspired" (taken and then modified to fit my needs)
from ortalab, which was made by eremel
https://github.com/EremelMods/Ortalab/blob/5a10f033ec29ed72c78bed64e448c18ae1a5ca2f/main.lua
]]
local order = {
    "achievements",
    "ModGlobal",
    "ahf2",
    "FoolOfManyTalents",
    "jest",
    "chicot",
    "WardenOfWine",
    "premonitions",
    "NotQuiteNepo",
    "ChinaShop",
    "Flawless4oak",
}
for _, key in ipairs(order) do
    assert(SMODS.load_file('src/'..key..'.lua'))()
end

UI_update_allowed = false
