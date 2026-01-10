SMODS.Challenge({
	key = "wine_warden",
	rules = {
		custom = {
			{ id = "totp_wine1" },
			{ id = "totp_wine2" },
			{ id = "totp_wine3" },
			{ id = "totp_wine4" },
        },
--[[
		modifiers = {
            { id = 'dollars',  value = 0 },
        }
]]
	},
    jokers = {
    {
        id = "j_perkeo", 
        eternal = "true"
    },
    },
	restrictions = {
		banned_cards = {
			--{ id = " "},
        },
	},
	deck = {
		type = "Challenge Deck",
	},
    apply = function(self)
        G.GAME.spectral_rate = 4
    end,
	calculate = function(self, context)
        local ret = {}
		if context.setting_blind and G.GAME.round_resets.ante >= 3 then
            local totp_ban_consumable = pseudorandom_element(get_current_pool("Consumeables"), "ban it", {
				in_pool = function(v)
                    return G.P_CENTERS[v] and not next(SMODS.find_card(v))
                end
			})
            --[[
            SMODS.poll_object({type = 'Consumeables',
                in_pool = function(v)
                    return not next(SMODS.find_card(v))
                end
            })
            ]]
            ret.message = localize{
                type = "name_text",
                set = G.P_CENTERS[totp_ban_consumable].set,
                key = totp_ban_consumable
            }.. localize("totp_banned")
            ret.func = function()
                G.GAME.banned_keys[totp_ban_consumable] = true
            end
            return ret
        end
	end
})

