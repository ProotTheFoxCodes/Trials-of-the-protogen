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
			{ id = "v_magic_trick"},
			{ id = "v_illusion" },
			{ id = "c_cryptid" },
			{ id = "c_death" },
            { id = "c_ouija" },
			{ id = "c_familiar"},
            { id = "j_certificate" },
            { id = "j_marble" },
			{ id = "j_wee" },
			{ id = "j_mail" },
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
			{ s = "S", r = "7" },
			{ s = "S", r = "7" },
			{ s = "S", r = "7" },
			{ s = "S", r = "7" },
			{ s = "S", r = "7" },
			{ s = "S", r = "7" },
			{ s = "S", r = "7" },
			{ s = "S", r = "7" },
			{ s = "S", r = "7" },
			{ s = "S", r = "7" },
			{ s = "S", r = "7" },
			{ s = "S", r = "7" },
			{ s = "S", r = "7" },
			{ s = "H", r = "7" },
			{ s = "H", r = "7" },
			{ s = "H", r = "7" },
			{ s = "H", r = "7" },
			{ s = "H", r = "7" },
			{ s = "H", r = "7" },
			{ s = "H", r = "7" },
			{ s = "H", r = "7" },
			{ s = "H", r = "7" },
			{ s = "H", r = "7" },
			{ s = "H", r = "7" },
			{ s = "H", r = "7" },
			{ s = "H", r = "7" },
			{ s = "C", r = "7" },
			{ s = "C", r = "7" },
			{ s = "C", r = "7" },
			{ s = "C", r = "7" },
			{ s = "C", r = "7" },
			{ s = "C", r = "7" },
			{ s = "C", r = "7" },
			{ s = "C", r = "7" },
			{ s = "C", r = "7" },
			{ s = "C", r = "7" },
			{ s = "C", r = "7" },
			{ s = "C", r = "7" },
			{ s = "C", r = "7" },
			{ s = "D", r = "7" },
			{ s = "D", r = "7" },
			{ s = "D", r = "7" },
			{ s = "D", r = "7" },
			{ s = "D", r = "7" },
			{ s = "D", r = "7" },
			{ s = "D", r = "7" },
			{ s = "D", r = "7" },
			{ s = "D", r = "7" },
			{ s = "D", r = "7" },
			{ s = "D", r = "7" },
			{ s = "D", r = "7" },
			{ s = "D", r = "7" },
		}
	},
	calculate = function(self, context)
		if context.individual and context.cardarea == G.play and not context.end_of_round then
			ret = {}
			G.GAME.totp_talent = (G.GAME.totp_talent or 0) + 1
			local talent = G.GAME.totp_talent
			--print(talent)
			if talent == 1 then
				G.GAME.totp_talented_nominal = context.other_card:get_chip_bonus()
			end
			if talent == 1 or talent % 30 == 0 then
				totp_new_talented = context.other_card:get_chip_bonus()
				context.other_card.ability.perma_bonus = 0
				context.other_card.nominal = G.GAME.totp_talented_nominal
				G.GAME.totp_talented_nominal = totp_new_talented
			end
			extra = true
			if context.other_card:get_id() ~= "King" and context.other_card:get_id() ~= "Queen" then
				if pseudorandom("shoutouts to gay foxgirls please draw yuri of them", 0, 1) then
					a = hand_chips * -0.3
					b = 0
				else
					a = 0
					b = hand_mult * -0.3
				end
				ret.chips = a
				ret.mult = b
				--[[
					table.insert(ret, "chips = a")
					table.insert(ret, "xmult = b")
					table.insert(ret, "remove_default_message = true")
				]]
			end
			if (extra or 0) then
				ret.extra = {message = talent % 30 .. " / 30" }
			end
			--print(ret)
			return ret
		end
	end
})