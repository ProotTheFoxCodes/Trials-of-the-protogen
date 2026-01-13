SMODS.Challenge({
	key = "chicot",
	rules = {
		custom = {
			{ id = "totp_chicot1" },
			{ id = "totp_chicot2" },
			{ id = "totp_chicot3" },
			
        },
		modifiers = {
            --{ id = 'dollars',  value = -4 },
        }
	},
    jokers = {
    {
        id = "j_chicot", 
        eternal = "true"
    },
    },
	restrictions = {
        --[[
		banned_cards = {
			{ id = "j_invisible"},
			{ id = "c_soul"},
			{ id = "c_ankh" },
        },
		banned_other = {
			{ id = "bl_water", type = "blind" }
		}
        ]]
	},
	deck = {
		type = "Challenge Deck",
	},
    apply = function(self)
        G.E_MANAGER:add_event(Event({
			trigger = "immediate",
			blocking = false,
			func = function() 
                -- Ante number UI
                local ghtac = G.hand_text_area.ante.config.object.config.string[1]
                ghtac.ref_table.fake_ante = 9 - G.GAME.round_resets.ante
                ghtac.ref_value = "fake_ante"
                -- Ante win number UI (patched ID, see lovely.toml)
                local win_UI = G.HUD:get_UIE_by_ID("ante_UI_win").config
                win_UI.ref_table.fake_win = 1
                win_UI.ref_value = "fake_win"
                -- Dollars left UI
                --driving in my car right after a beer hey that bump is shaped like a deer
                local dui = G.HUD:get_UIE_by_ID('dollar_text_UI').config.object.config.string[1]
                dui.ref_table.fake_dollars = G.GAME.dollars * -1
                dui.ref_value = "fake_dollars"
                -- Hands left UI
                local hands = G.HUD:get_UIE_by_ID('hand_UI_count').config.object.config.string[1]
                hands.ref_table.fake_hands = G.GAME.current_round.hands_left * -1
                hands.ref_value = "fake_hands"
                -- Discards left UI
                local discards = G.HUD:get_UIE_by_ID('discard_UI_count').config.object.config.string[1]
                discards.ref_table.fake_discards = G.GAME.current_round.discards_left * -1
                discards.ref_value = "fake_discards"
                -- Round number UI
                local kround = G.HUD:get_UIE_by_ID('round_UI_count').config.object.config.string[1]
                kround.ref_table.fake_round = G.GAME.round * -1
                kround.ref_value = "fake_round"

                UI_update_allowed = true

				return true 
			end
		}))
        
    end,
	calculate = function(self, context)
        local ret = {}
        if context.ante_change then
            local ghtac = G.hand_text_area.ante.config.object.config.string[1]
            ghtac.ref_table.fake_ante = 9 - G.GAME.round_resets.ante
        end
	end
})

update_old = Game.update

function Game:update(args)

    local ret = update_old(self,args)

    if UI_update_allowed then
        local win_UI = G.HUD:get_UIE_by_ID("ante_UI_win").config
        win_UI.ref_table.fake_win = 1

        local dui = G.HUD:get_UIE_by_ID('dollar_text_UI').config.object.config.string[1]
        dui.ref_table.fake_dollars = G.GAME.dollars * -1

        local hands = G.HUD:get_UIE_by_ID('hand_UI_count').config.object.config.string[1]
        hands.ref_table.fake_hands = G.GAME.current_round.hands_left * -1

        local discards = G.HUD:get_UIE_by_ID('discard_UI_count').config.object.config.string[1]
        discards.ref_table.fake_discards = G.GAME.current_round.discards_left * -1

        local kround = G.HUD:get_UIE_by_ID('round_UI_count').config.object.config.string[1]
        kround.ref_table.fake_round = G.GAME.round * -1
    end

    if G.STATE == G.STATES.GAME_OVER and UI_update_allowed then
        UI_update_allowed = false
    end

    return ret

end