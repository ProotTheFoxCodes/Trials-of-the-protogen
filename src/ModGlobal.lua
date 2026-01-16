SMODS.current_mod.calculate = function(self, context)
    if context.setting_blind then
        G.GAME.totp_round_rerolls = 0
        if not G.GAME.totp_discarded then G.GAME.totp_discarded = {} end
        G.GAME.totp_discarded["round"] = false
    end

    if context.pre_discard then
        local discard = G.GAME.totp_discarded
        discard["round"], discard["run"] = true, true
    end

    if context.before and next(context.poker_hands['Flush Five']) and not G.GAME.selected_back.effect.config.randomize_rank_suit then
        if not G.GAME.totp_discarded["round"] then
            check_for_unlock({type = "pow5"})
        end
        if not G.GAME.totp_discarded["run"] then
            check_for_unlock({type = "oblivion"})
        end
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