-- Scuffed attempt at reverse ante, kept for record-keeping only
SMODS.Challenge({
	key = "shitcot",
    --[[not intended to be played --> ]]no_collection = true,
	rules = {
		custom = {
			{ id = "totp_chicot1" },
			{ id = "totp_chicot2" },
			{ id = "totp_chicot3" },
			{ id = "totp_chicot4" },
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
				ease_ante(7)
                G.GAME.starting_params.ante_scaling = 0.006
                G.GAME.win_ante = 1
				return true 
			end
		}))
		
    end,
	calculate = function(self, context)
        local ret = {}
        if context.end_of_round and context.main_eval then
            local blind_type = G.GAME.blind:get_type()
            if blind_type == "Small" or blind_type == "Big" then
            else
                G.GAME.win_ante = 9
            end

            if G.GAME.round_resets.ante == 1 then
                if blind_type == "Small" or blind_type == "Big" then
                else
                    win_game()
				    G.GAME.won = true
                end
            end
        end

		if context.modify_ante and G.GAME.round ~= 0 then
            G.GAME.win_ante = 1
            return {modify = -1}
        end

        if context.ante_change then
            G.GAME.starting_params.ante_scaling = math.max(Lerp(0.006,166,0.125*G.GAME.round_resets.ante-0.125,0.006))
        end
	end
})

