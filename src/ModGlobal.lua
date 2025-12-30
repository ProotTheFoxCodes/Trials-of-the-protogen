SMODS.current_mod.calculate = function(self, context)
    if context.setting_blind then
        G.GAME.totp_round_rerolls = 0
    end
end

function SMODS.current_mod.reset_game_globals(from_game_start)
    -- Win ante and other similar modifications moved to challenge apply functions 
end