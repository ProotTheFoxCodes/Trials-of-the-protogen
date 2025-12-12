SMODS.current_mod.calculate = function(self, context)
    if context.setting_blind then
        G.GAME.totp_round_rerolls = 0
    end
end

function SMODS.current_mod.reset_game_globals(from_game_start)
    if G.GAME.challenge == "c_totp_nepo" and from_game_start then
        G.GAME.bankrupt_at = -1.7e308
    end
    if G.GAME.challenge == "c_totp_flawless4oak" and from_game_start then
        G.GAME.win_ante = 1.8e308
    end
end