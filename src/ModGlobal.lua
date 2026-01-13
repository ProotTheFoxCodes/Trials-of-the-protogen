SMODS.current_mod.calculate = function(self, context)
    if context.setting_blind then
        G.GAME.totp_round_rerolls = 0
    end
end

function SMODS.current_mod.reset_game_globals(from_game_start)
    -- Win ante and other similar modifications moved to challenge apply functions 
end

-- function from https://github.com/Sleitnick/RbxCookbook/commit/8af205194e966fe4f669be6698ef0f558541837c#diff-e6c4df4b6ea6fbb38c6f397c9258081b499f687843f825a73f0df167d9d82787
-- currently unused
function Lerp(a,b,x)
	return a + ((b - a) * x)
end