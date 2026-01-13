SMODS.Challenge({
	key = "ss",
	rules = {
		custom = {
			{ id = "totp_ss1" },
			{ id = "totp_ss2" },
			{ id = "totp_ss3" },
			{ id = "totp_ss4" },
			
        },
		modifiers = {
            --{ id = 'dollars',  value = 14 },
        }
	},
    jokers = {
    {
        id = "j_sixth_sense", 
		eternal = true,
    },
	{
		id = "j_ice_cream"
	}
    },
	restrictions = {
		banned_cards = {
	        { id = "c_strength" },
			{ id = "c_strength" },	
			{ id = "c_tower" },	
			{ id = "c_familiar" },
			{ id = "c_grim" },
			{ id = "c_incantation" },
			{ id = "c_ouija" },
			{ id = "v_magic_trick" },
			{ id = "j_marble" },
			{ id = "j_certificate" },
			{ id = 'p_standard_normal_1', ids = {
                'p_standard_normal_1', 'p_standard_normal_2',
                'p_standard_normal_3', 'p_standard_normal_4',
                'p_standard_jumbo_1', 'p_standard_jumbo_2',
                'p_standard_mega_1', 'p_standard_mega_2' }
            },
			
--[[
			{ id = "j_"},
            { id = "c_" },
            { id = "v_"},
]]
        },
		banned_tags = {
			{ id = "tag_standard" },
		},
		banned_other = {
			--{ id = "bl_", type = "blind" }
		}
	},
	deck = {
		type = "Challenge Deck",
		cards = {
			{ s = "S", r = "6" },
			{ s = "S", r = "6" },
			{ s = "S", r = "6" },
			{ s = "S", r = "6" },
			{ s = "S", r = "6" },
			{ s = "S", r = "6" },
			{ s = "S", r = "6" },
			{ s = "S", r = "6" },
			{ s = "S", r = "6" },
			{ s = "S", r = "6" },
			{ s = "S", r = "6" },
			{ s = "S", r = "6" },
			{ s = "S", r = "6" },
			{ s = "H", r = "6" },
			{ s = "H", r = "6" },
			{ s = "H", r = "6" },
			{ s = "H", r = "6" },
			{ s = "H", r = "6" },
			{ s = "H", r = "6" },
			{ s = "H", r = "6" },
			{ s = "H", r = "6" },
			{ s = "H", r = "6" },
			{ s = "H", r = "6" },
			{ s = "H", r = "6" },
			{ s = "H", r = "6" },
			{ s = "H", r = "6" },
			{ s = "C", r = "6" },
			{ s = "C", r = "6" },
			{ s = "C", r = "6" },
			{ s = "C", r = "6" },
			{ s = "C", r = "6" },
			{ s = "C", r = "6" },
			{ s = "C", r = "6" },
			{ s = "C", r = "6" },
			{ s = "C", r = "6" },
			{ s = "C", r = "6" },
			{ s = "C", r = "6" },
			{ s = "C", r = "6" },
			{ s = "C", r = "6" },
			{ s = "D", r = "6" },
			{ s = "D", r = "6" },
			{ s = "D", r = "6" },
			{ s = "D", r = "6" },
			{ s = "D", r = "6" },
			{ s = "D", r = "6" },
			{ s = "D", r = "6" },
			{ s = "D", r = "6" },
			{ s = "D", r = "6" },
			{ s = "D", r = "6" },
			{ s = "D", r = "6" },
			{ s = "D", r = "6" },
			{ s = "D", r = "6" },
		}
	},
    apply = function(self)
        G.GAME.starting_params.play_limit = 1
        return true
    end,
	calculate = function(self, context)
        local ret = {}
	end
})

