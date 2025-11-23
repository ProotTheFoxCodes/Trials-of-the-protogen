-- In your main file.
-- This will load any file in the `src/` subfolder
-- Note: Load order is not guaranteed
local src = NFS.getDirectoryItems(SMODS.current_mod.path .. "src")
for _, file in ipairs(src) do
    assert(SMODS.load_file("src/" .. file))()
end