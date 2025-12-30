SMODS.Challenge({
	key = "wine_warden",
	rules = {
		custom = {
			{ id = "totp_wine1" },
			{ id = "totp_wine2" },
			{ id = "totp_wine3" },
			{ id = "totp_wine4" },
--[[
        },
		modifiers = {
            { id = 'dollars',  value = 0 },
        }
]]
	},
    jokers = {
        { id = "j_perkeo", eternal = true}
    },
	restrictions = {
		banned_cards = {
			--{ id = " "},
            },

		},
	},
	deck = {
		type = "Challenge Deck",
	},
    apply = function(self)
        G.GAME.spectral_rate = 4
    end,
	calculate = function(self, context)
		
	end
})

