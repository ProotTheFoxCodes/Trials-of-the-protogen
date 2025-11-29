SMODS.current_mod.calculate = function(self, context)
    if context.setting_blind then
        G.GAME.totp_round_rerolls = 0
    end
end