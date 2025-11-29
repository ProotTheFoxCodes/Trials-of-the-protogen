--[[
Nepotism?

- Can have an unlimited amount of debt
- Money can't go above $0
- Every dollar of debt reduces starting score by 5% of blind requirements
- 5 rerolls per shop
]]
SMODS.Challenge({
	key = "nepo",
	rules = {
		custom = {
			{ id = "totp_nepo1" },
			{ id = "totp_nepo2" },
			{ id = "totp_nepo3" },
			{ id = "totp_nepo4" },
		},
		modifiers = {
            { id = 'dollars',  value = 0 },
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
		if context.setting_blind then
			G.GAME.chips = G.GAME.dollars * (G.GAME.blind.chips * 0.025)
		end
	end
})

old_money = ease_dollars
function ease_dollars(mod)
    if mod > 0 and G.GAME.challenge == "c_totp_nepo" then
        mod = 0
    else
        old_money(mod)
    end
    return (ret or 0)
end

old_shop_reroll = G.FUNCS.reroll_shop
function G.FUNCS.reroll_shop(e)
	G.GAME.totp_round_rerolls = (G.GAME.totp_round_rerolls or 0) + 1
	if G.GAME.challenge == "c_totp_nepo" then
		if G.GAME.totp_round_rerolls < 6 then
			old_shop_reroll(e)
		end
	else
		old_shop_reroll(e)
	end
	return (ret or 0)
end