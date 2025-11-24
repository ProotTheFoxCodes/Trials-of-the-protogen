SMODS.Joker { --dummy tooltip object
	key = "unwise_tooltip",
	no_collection = true,
	in_pool = function(self,args)
		return false
	end
}
SMODS.Challenge({
	key = "talents",
	rules = {
		custom = {
			{ id = "totp_talents1" },
            { id = "totp_talents2" },
			{ id = "totp_talents3" },
			{ id = "totp_talents4" },
			{ id = "totp_talents5" },
			{ id = "totp_talents6" },
		},
	},
    jokers = {
        {
            id = "j_triboulet",
            eternal = "true"
        }
    },
	restrictions = {
		banned_cards = {
			{ id = "c_cryptid" },
			{ id = "c_death" },
            { id = "c_ouija" },
            { id = "j_certificate" },
            { id = "j_marble" },
			{ id = "j_wee" },
            { id = 'p_standard_normal_1', ids = {
                'p_standard_normal_1', 'p_standard_normal_2',
                'p_standard_normal_3', 'p_standard_normal_4',
                'p_standard_jumbo_1', 'p_standard_jumbo_2',
                'p_standard_mega_1', 'p_standard_mega_2' }
            },

		},
		banned_tags = {
			{ id = "tag_standard" },
		}
	},
	deck = {
		type = "challenge_deck",
		cards = {
			{ s = "S", r = "2" },
			{ s = "S", r = "2" },
			{ s = "S", r = "2" },
			{ s = "S", r = "2" },
			{ s = "S", r = "2" },
			{ s = "S", r = "2" },
			{ s = "S", r = "2" },
			{ s = "S", r = "2" },
			{ s = "S", r = "2" },
			{ s = "S", r = "2" },
			{ s = "S", r = "2" },
			{ s = "S", r = "2" },
			{ s = "S", r = "2" },
			{ s = "H", r = "2" },
			{ s = "H", r = "2" },
			{ s = "H", r = "2" },
			{ s = "H", r = "2" },
			{ s = "H", r = "2" },
			{ s = "H", r = "2" },
			{ s = "H", r = "2" },
			{ s = "H", r = "2" },
			{ s = "H", r = "2" },
			{ s = "H", r = "2" },
			{ s = "H", r = "2" },
			{ s = "H", r = "2" },
			{ s = "H", r = "2" },
			{ s = "C", r = "2" },
			{ s = "C", r = "2" },
			{ s = "C", r = "2" },
			{ s = "C", r = "2" },
			{ s = "C", r = "2" },
			{ s = "C", r = "2" },
			{ s = "C", r = "2" },
			{ s = "C", r = "2" },
			{ s = "C", r = "2" },
			{ s = "C", r = "2" },
			{ s = "C", r = "2" },
			{ s = "C", r = "2" },
			{ s = "C", r = "2" },
			{ s = "D", r = "2" },
			{ s = "D", r = "2" },
			{ s = "D", r = "2" },
			{ s = "D", r = "2" },
			{ s = "D", r = "2" },
			{ s = "D", r = "2" },
			{ s = "D", r = "2" },
			{ s = "D", r = "2" },
			{ s = "D", r = "2" },
			{ s = "D", r = "2" },
			{ s = "D", r = "2" },
			{ s = "D", r = "2" },
			{ s = "D", r = "2" },
		},
		calculate = function(self, card, context)
			if context.individual and context.cardarea == G.play and not context.end_of_round then
				ret = {}
				G.GAME.totp_talent = G.GAME.totp_talent + 1
				local talent = G.GAME.totp_talent
				if talent == 1 then
					G.GAME.totp_talented_nominal = context.other_card:get_chip_bonus()
				end
				if talent == 1 or talent % 30 == 0 then
					totp_new_talented = context.other_card:get_chip_bonus()
					context.other_card.ability.perma_bonus = 0
					context.other_card.nominal = G.GAME.totp_talented_nominal
					G.GAME.totp_talented_nominal = totp_new_talented
				end
				table.insert(ret, { extra = {message = totp.talent .. " / 30" }})
				if not context.other_card.base.value == "King" and not context.other_card.base.value == "Queen" then
					if pseudorandom("shoutouts to gay foxgirls please draw yuri of them", 0, 1) then
						a = hand_chips * -0.1
						b = 1
					else
						a = 0
						b = 0.9
					end
						table.insert(ret, "chips = a")
						table.insert(ret, "xmult = b")
						table.insert(ret, "remove_default_message = true")
				end
				return ret
			end
    	end
	},
})