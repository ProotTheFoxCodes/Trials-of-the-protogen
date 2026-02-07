start_old = Game.start_run
function Game.start_run(args)
    local ret = start_old(args)
    G.GAME.totp_oml = true
    G.GAME.totp_blackjack = true
    G.GAME.totp_nostalgic = true
    G.GAME.totp_discarded = {}
    return ret
end

SMODS.current_mod.calculate = function(self, context)
    if context.setting_blind then
        if G.GAME.blind.config.blind.key == "bl_final_leaf" then
            G.GAME.totp_leafsell = false
        end
        if not G.GAME.blind.boss then
            G.GAME.totp_nostalgic = false
        end
        G.GAME.totp_round_rerolls = 0
        G.GAME.totp_discarded["round"] = false
        if G.GAME.round_resets.ante >= 6 then
            G.GAME.totp_oml = false
        end
    end

    if context.pre_discard then
        local discard = G.GAME.totp_discarded
        discard["round"], discard["run"] = true, true
    end

    if context.before and next(context.poker_hands['Flush Five']) and not G.GAME.selected_back.effect.config.randomize_rank_suit and not G.GAME.challenge then
        if not G.GAME.totp_discarded["round"] then
            check_for_unlock({type = "pow5"})
        end
        if not G.GAME.totp_discarded["run"] then
            check_for_unlock({type = "oblivion"})
        end
    end

    if context.before then
        local total = 0
        for _, icard in pairs(G.play.cards) do
            total = total + icard:get_id()
        end
        if total > 21 then G.GAME.totp_blackjack = false end
	end

    if context.card_added then
        local card_jokers = {
            "j_joker",
            "j_baseball",
            "j_trading",
            "j_loyalty_card",
            "j_ticket",
            "j_business",
            "j_credit_card",
            "j_drivers_license",
        }
        G.GAME.totp_has_cj = {}
        local cj_amt = 0
        for _, key in pairs(card_jokers) do
            G.GAME.totp_has_cj[key] = not not next(SMODS.find_card(key))
        end
        for key in pairs(G.GAME.totp_has_cj) do
            if G.GAME.totp_has_cj[key] then  cj_amt = cj_amt + 1 end
        end
        if G.GAME.totp_has_cj["j_baseball"] and G.GAME.totp_has_cj["j_trading"] then
            check_for_unlock({type = "collector1"})
        end
        if cj_amt >= 4 then
            check_for_unlock({type = "collector2"})
        end
    end

    if context.selling_card and context.card.config.set == "Joker" and G.GAME.blind.config.blind.key == "bl_final_leaf" then
        G.GAME.totp_leafsell = true
    end
end

function SMODS.current_mod.reset_game_globals(from_game_start)
    -- Win ante and other similar modifications moved to challenge apply functions 
end

