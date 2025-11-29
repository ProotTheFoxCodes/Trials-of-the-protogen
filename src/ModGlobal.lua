SMODS.current_mod.calculate = function(self, context)
    if context.setting_blind then
        G.GAME.totp_round_rerolls = 0
    end
end

function SMODS.current_mod.reset_game_globals(from_game_start: boolean)
    if G.GAME.challenge == "c_totp_nepo" then
        G.GAME.bankrupt_at = -1.7e308
    end
end