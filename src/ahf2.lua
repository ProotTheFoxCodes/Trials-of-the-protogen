--[[
Actors Have Feelings Too
]]
SMODS.Challenge({
	key = "ahf2",
	rules = {
		custom = {
			{ id = "totp_ahf21" },
			{ id = "totp_ahf22" },
			{ id = "totp_ahf23" },
			{ id = "totp_ahf24" },
			{ id = "totp_ahf25" },
			{ id = "totp_ahf26" },
			{ id = "totp_ahf27" },
			{ id = "totp_ahf28" },
			{ id = "totp_ahf29" },
			{ id = "totp_ahf210" },
			
		},
		modifiers = {
            { id = 'hands',  value = 5 },
			{ id = "discards", value = 4}
        }
	},
    jokers = {
		{
            id = "j_caino",
            eternal = "true"
        }
	},
	--[[
	restrictions = {
		banned_cards = {
			--{ id = " "},
            },

		},
		banned_tags = {
			--{ id = " },
		}
	},
	deck = {
		cards = {
			{ s = "S", r = "7" },

		}
	},
    ]]

	calculate = function(self, context)
		ret = {}
		if context.remove_playing_cards then --and context.remove_playing_cards.scoring_hand then
			for i=1, #context.removed do
				if context.removed[i]:is_face() then
					local comedy_card = pseudorandom_element(G.deck.cards, "non faces", {
					in_pool = function(v)
						return not v:is_face() and not v.totp_tragic
					end
					})
					comedy_card.totp_tragic = true
					SMODS.destroy_cards(comedy_card)
				end
			end
			ret.message = localize("comedy")
			return ret
		end
	end
})

local discard_old = G.FUNCS.discard_cards_from_highlighted
function G.FUNCS.discards_cards_from_highlighted(e,hook,from_canio)
	if from_canio or G.GAME.challenge ~= "c_totp_ahf2" or G.GAME.current_round.hands_left <= 0 then
		discard_old()
	else
		if SMODS.pseudorandom_probability(nil, "canio discard", 1, 4) then
			G.FUNCS.play_cards_from_highlighted(nil,true)
		else
			discard_old()
		end
	end
end

local play_old = G.FUNCS.play_cards_from_highlighted
function G.FUNCS.play_cards_from_highlighted(e,from_canio)
	if from_canio or G.GAME.challenge ~= "c_totp_ahf2" or G.GAME.current_round.discards_left <= 0 then
		play_old()
	else
		if SMODS.pseudorandom_probability(nil, "canio play", 1, 4) then
			G.FUNCS.discard_cards_from_highlighted(nil,nil,true)
		else
			play_old()
		end
	end
end