SMODS.Challenge({
	key = "flawless4oak",
	rules = {
		custom = {
			{ id = "totp_4oak1" },
			{ id = "totp_4oak2" },
			{ id = "totp_4oak3" },
			{ id = "totp_4oak4" },
			{ id = "totp_4oak5" },
			{ id = "totp_4oak6" }
		},
		modifiers = {
            { id = 'hands',  value = 2 },
			{ id = "discards", value = 1 },
			{ id = "hand_size", value = 12 }
        }
	},
	--[[
    jokers = {},
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
		if context.main_scoring and context.cardarea == G.play then
			aces = 0
			if #G.play.cards >= 4 then
				for i=1, #G.play.cards do
					if G.play.cards[i]:get_() == 14 then
						aces = aces + 1
					end
				end
				if aces == 4 then
					win_game()
					G.GAME.won = true
				end
			end
		end
	end
})