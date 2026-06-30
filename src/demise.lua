--[[

Chosen One's Demise


Small and Big Blind have passive modifiers based on the upcoming Boss Blind, unless otherwise specified



Non-Finishers
Suit bosses such as The Goad are excluded
The Mark is also excluded, in the interest of having a challenge that's not repetitive

The Hook                               |      Discards most modified card in every draw without triggering card effects. (Ehancements, seals, editions, etc)
The Ox                                 |      Subtract a dollar from maximum interest for the run when playing [most played hand].
The House                              |      Every hand costs $[floor(log1.3(Ante+4))]. Get any money lost this round back if you win in less than 3 hands.
The Wall                               |      Must reach within +20% of score requirement to beat the blind, stacking X2 blind requirements until either
                                              the condition is met or score is less than blind requirement.
The Wheel                              |      X0.75 - X1.15 Money when playing a hand.
The Arm                                |      Played hands permanently lose 5 chips-per-level.
The Fish                               |      Only hands that contain pairs are allowed.
The Psychic                            |      For the whole Ante: Debuff cards in hand when discarding less than 5 cards.
The Water                              |      Every odd numbered hand also costs a discard.
The Manacle                            |      Start with +3 hand size for the whole ante. Decrease by 1 for each hand played.
The Eye                                |      A random poker hand is selected after every played hand. [poker hand] is not allowed until a new one is chosen.
The Mouth                              |      Only hand types that are above your average hand level are allowed. The average is only calculated at the start of a blind.
The Plant                              |      If played hand contains a face card, destroy [number of cards in played hand] cards in full deck at random.
The Serpent                            |      Permanent -1 discard selection limit if played hand contains a [most common rank in deck].
The Pillar                             |      Cards cannot be drawn twice.
The Needle                             |      Every card played after the first hand is destroyed.
The Tooth                              |      All money gain is set to 0 during this Ante.
The Flint                              |      Played poker hand is set to level 1 after scoring if fire effects are triggered.


Finishers

Amber Acorn                            |      Your jokers are flipped and shuffled while in a shop. The colours on the backs of your jokers are based on their respective rarities.
Verdant Leaf                           |      Prevents selecting the next blind until 1 joker sold.
Violet Vessel                          |      +2 Win Ante, every blind in the next 2 antes is replaced with The Wall.
Crimson Heart                          |      One random card in played hand is debuffed before scoring.
Cerulean Bell                          |      Forcibly play drawn cards when discarding.



--]]


-- G.GAME.round_resets.blind_choices.Boss


-- store event data for "The Wall" modifier, second pass+
local wallEvent2
wallEvent2 = {
    trigger = 'after',
    delay = 0.3 * G.SETTINGS.GAMESPEED,
    no_delete = true,
    pause_force = true,
    blockable = false,
    blocking = false,
    func = function()
        if not (G.GAME.chips + SMODS.last_hand_score <= G.GAME.blind.chips * 1.2) then
            G.GAME.blind.chips = G.GAME.blind.chips * 2
            SMODS.juice_up_blind()
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.06 * G.SETTINGS.GAMESPEED,
                blockable = false,
                blocking = true,
                func = function()
                    play_sound('tarot2', 0.76, 0.4); return true
                end
            }))
            play_sound('tarot2', 1, 0.4)
            G.E_MANAGER:add_event(Event(wallEvent2))
        end
        return true
    end
}

--store event data for "The Wall" modifier, first pass
local wallEvent
wallEvent = {
    trigger = 'immediate',
    no_delete = true,
    pause_force = true,
    blockable = false,
    blocking = false,
    func = function()
        if not (G.GAME.chips + SMODS.last_hand_score <= G.GAME.blind.chips * 1.2) then
            G.GAME.blind.chips = G.GAME.blind.chips * 2
            SMODS.juice_up_blind()
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.06 * G.SETTINGS.GAMESPEED,
                blockable = false,
                blocking = true,
                func = function()
                    play_sound('tarot2', 0.76, 0.4); return true
                end
            }))
            play_sound('tarot2', 1, 0.4)
            G.E_MANAGER:add_event(Event(wallEvent2))
        end
        return true
    end
}

local blindSound = function()
    G.E_MANAGER:add_event(Event({
        trigger = 'immediate',
        func = (function()
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.06 * G.SETTINGS.GAMESPEED,
                blockable = false,
                blocking = false,
                func = function()
                    play_sound('tarot2', 0.76, 0.4); return true
                end
            }))
            play_sound('tarot2', 1, 0.4)
            return true
        end)
    }))
end

SMODS.Challenge({
	key = "demise",
	rules = {
		custom = {
            { id = "totp_demise1" },

        },
		modifiers = {
            --{ id = 'joker_slots', value = 1 },
        },
        vouchers = {
            { id = "v_seed_money" }
        }
    },
    restrictions = {
        banned_cards = {
            { id = "v_money_tree"}
        },
        banned_tags = {

        },
        banned_other = {
            { id = "bl_club", type = "blind" },
            { id = "bl_goad", type = "blind" },
            { id = "bl_window", type = "blind" },
            { id = "bl_head", type = "blind" },
            { id = "bl_mark", type = "blind" },
            
        }
	},
    jokers = {

    },
	deck = {
		type = "Challenge Deck",
	},
    apply = function(self)
        --G.GAME.starting_params.ante_scaling = 4
        G.GAME.totp_demise_penalty = {}
        for pHand,_ in pairs(G.GAME.hands) do
            G.GAME.totp_demise_penalty[pHand] = 0
        end
    end,
	calculate = function(self, context)

        -- Prevent nil value crash
        G.GAME.totp_eye_poker_hand = G.GAME.totp_eye_poker_hand or " "

        -- The Hook
        if context.hand_drawn and G.GAME.round_resets.blind_choices.Boss == "bl_hook" and totp.demisePassiveCheck() then
            local cardToDiscard = nil
            local modCount = -1
            for _, card in ipairs(context.hand_drawn) do
                card.totp_cardmod = 0
                if card.seal then
                    card.totp_cardmod = card.totp_cardmod + 1
                end
                if card.edition then
                    card.totp_cardmod = card.totp_cardmod + 1
                end
                if next(SMODS.get_enhancements(card)) then
                    card.totp_cardmod = card.totp_cardmod + 1
                end
                if card.totp_cardmod > modCount then
                    cardToDiscard,modCount = card,card.totp_cardmod
                end
                card.totp_cardmod = nil
            end
            G.hand:add_to_highlighted(cardToDiscard, true)
            G.FUNCS.discard_cards_from_highlighted(nil, true)
            blindSound()
        end

        -- The Ox
        if context.debuff_hand and G.GAME.round_resets.blind_choices.Boss == "bl_ox" and totp.demisePassiveCheck() then
            if context.scoring_name == G.GAME.current_round.most_played_poker_hand then
                if not context.check then
                    G.GAME.interest_cap = G.GAME.interest_cap - 5
                    blindSound()
                end
            end
        end

        -- The House
        if context.before and G.GAME.round_resets.blind_choices.Boss == "bl_house" and totp.demisePassiveCheck() then
            if not G.GAME.totp_penalty then
                G.GAME.totp_penalty = 0
            end
            G.GAME.totp_penalty = G.GAME.totp_penalty - math.floor(math.log(G.GAME.round_resets.ante + 4, 1.3))
            ease_dollars(- math.floor(math.log(G.GAME.round_resets.ante + 4, 1.3)))
        end
    
        if context.end_of_round and context.main_eval and G.GAME.round_resets.blind_choices.Boss == "bl_house" and totp.demisePassiveCheck() then
            if G.GAME.current_round.hands_played <= 3 then
                ease_dollars(-G.GAME.totp_penalty)
            end
            G.GAME.totp_penalty = 0
        end

        -- The Wall
        if context.after and G.GAME.round_resets.blind_choices.Boss == "bl_wall" and totp.demisePassiveCheck() then
            if G.GAME.chips + SMODS.last_hand_score >= G.GAME.blind.chips then
                if not (G.GAME.chips + SMODS.last_hand_score <= G.GAME.blind.chips * 1.2) then
                    G.GAME.totp_wall = true
                    G.E_MANAGER:add_event(Event(wallEvent))
                else
                    end_round()
                end
            end

            -- Manually handle losing @_@
            if G.GAME.current_round.hands_left < 1 and G.GAME.chips + SMODS.last_hand_score < G.GAME.blind.chips then
                G.STATE = G.STATES.GAME_OVER
				G.FILE_HANDLER.force = true
				G.STATE_COMPLETE = false
            end

        end

        -- The Wheel
        if context.before and G.GAME.round_resets.blind_choices.Boss == "bl_wheel" and totp.demisePassiveCheck() then
            ease_dollars((G.GAME.dollars * (pseudorandom("eat the rich",75,115)/100)) - G.GAME.dollars)
            blindSound()
        end

        -- The Arm
        if context.before and G.GAME.round_resets.blind_choices.Boss == "bl_arm" and totp.demisePassiveCheck() then
            G.GAME.hands[context.scoring_name].l_chips = G.GAME.hands[context.scoring_name].l_chips - 5
            G.GAME.hands[context.scoring_name].l_chips = math.max(G.GAME.hands[context.scoring_name].l_chips, 1)
            SMODS.upgrade_poker_hands {
                hands = context.scoring_name,
                level_up = 0,
                func = function(base, hand, parameter, level_up)
                    level_up = 0

                    if parameter == "chips" then
                        return math.max(G.GAME.hands[context.scoring_name].l_chips * G.GAME.hands[context.scoring_name].level ,1)
                    end
                    if parameter == "mult" then
                        return base
                    end
                end,
                instant = context.instant
            }
            blindSound()
        end

        -- The Fish
        if context.debuff_hand and G.GAME.round_resets.blind_choices.Boss == "bl_fish" and totp.demisePassiveCheck() then
            if not next(context.poker_hands["Pair"]) then
                blindSound()
                return{debuff = true}
            end
        end
        
        -- The Psychic
        if context.pre_discard and G.GAME.round_resets.blind_choices.Boss == "bl_psychic" then
            if #context.full_hand < 5 then
                for _,card in pairs(G.hand.cards) do
                    SMODS.debuff_card(card,true,"totp_demise")
                end
                blindSound()
            end
        end

        if context.ante_change then
            for _,card in pairs(G.deck.cards) do
                SMODS.debuff_card(card,false,"totp_demise")
            end
        end

        -- The Water
        if G.GAME.round_resets.blind_choices.Boss == "bl_water" and context.before and G.GAME.current_round.hands_played % 2 == 0 and totp.demisePassiveCheck() then
            ease_discard(-1,true,nil)
            blindSound()
        end
        
        -- The Manacle
        if G.GAME.round_resets.blind_choices.Boss == "bl_manacle" then
            if context.setting_blind and not G.GAME.totp_demise_m_active then
                G.GAME.totp_handsize = 3
                G.hand:change_size(G.GAME.totp_handsize)
                G.GAME.totp_demise_m_active = true
            end
            if context.before then
                G.hand:change_size(-1)
                G.GAME.totp_handsize = G.GAME.totp_handsize - 1
                blindSound()
            end
        end

        if (context.ante_change or context.totp_boss_change) and G.GAME.totp_demise_m_active then
            G.hand:change_size(-G.GAME.totp_handsize)
            G.GAME.totp_handsize = 0
            G.GAME.totp_demise_m_active = nil
        end

        -- The Eye
        if G.GAME.round_resets.blind_choices.Boss == "bl_eye" and context.after and totp.demisePassiveCheck() then
            local _poker_hands = {}
            for handname, _ in pairs(G.GAME.hands) do
                if SMODS.is_poker_hand_visible(handname) then
                    _poker_hands[#_poker_hands + 1] = handname
                end
            end
            G.GAME.totp_eye_poker_hand = pseudorandom_element(_poker_hands, 'totp_demise_eye')
        end

        if context.debuff_hand and G.GAME.totp_eye_poker_hand == context.scoring_name and G.GAME.round_resets.blind_choices.Boss == "bl_eye" and totp.demisePassiveCheck() then
            blindSound()
            return{
                debuff = true
            }
        end
        
        -- The Mouth
        if G.GAME.round_resets.blind_choices.Boss == "bl_mouth" and context.debuff_hand and G.GAME.totp_avg_lvl and totp.demisePassiveCheck() then
            if not (G.GAME.hands[context.scoring_name].level > G.GAME.totp_avg_lvl) then
                blindSound()
                return{
                    debuff = true
                }
            end
        end

        if G.GAME.round_resets.blind_choices.Boss == "bl_mouth" and context.setting_blind and totp.demisePassiveCheck() then
            local _poker_hands = {}
            G.GAME.totp_avg_lvl = 0
            for handname, hand_details in pairs(G.GAME.hands) do
                if SMODS.is_poker_hand_visible(handname) then
                    _poker_hands[#_poker_hands + 1] = handname
                    G.GAME.totp_avg_lvl = G.GAME.totp_avg_lvl + hand_details.level
                end
            end
            G.GAME.totp_avg_lvl = G.GAME.totp_avg_lvl / #_poker_hands
        end

        -- The Plant
        if G.GAME.round_resets.blind_choices.Boss == "bl_plant" and context.before and totp.demisePassiveCheck() then
            if (function()
                local hand_faces = 0
                for _,card in pairs(G.play.cards) do
                    if card:is_face() then hand_faces = hand_faces + 1 end
                return hand_faces > 1
                end
            end
            ) then
              	for i=1, #G.play.cards do
                    local plant_card = pseudorandom_element(G.deck.cards, "that_fucking_plant_that_i_hate-_that_fucking_plant_that_i_hate_t__h__a__t____f__u__c__k__i__n__g____p__l__a__n__t____t__h__a__t____i____h__a__t__e-_WHAAAAT?!", {
                    in_pool = function(v)
                        return not v.totp_tragic
                    end
                    })
                    plant_card.totp_tragic = true
                    SMODS.destroy_cards(plant_card)
                    blindSound()
                end
			end
        end

        -- The Serpent
        if G.GAME.round_resets.blind_choices.Boss == "bl_serpent" and context.before and totp.demisePassiveCheck() then
            -- ThunderEdge most common rank
            local ranks = {}
            for _, playing_card in ipairs(G.playing_cards) do
            if not SMODS.has_no_rank(playing_card) then
                ranks[playing_card:get_id()] = (ranks[playing_card:get_id()] or 0) + 1
            end
            end
            local most_common_id = nil
            local count = 0
            for _, rank_key in pairs(SMODS.Rank.obj_buffer) do
                if (ranks[SMODS.Ranks[rank_key].id] or 0) >= count then
                    most_common_id = SMODS.Ranks[rank_key].id
                    count = ranks[SMODS.Ranks[rank_key].id]
                end
            end
            --
            most_common_id = most_common_id or 1
            local mostplayeds = 0
            for _,card in pairs(context.scoring_hand) do
                if card:get_id() == most_common_id then
                    mostplayeds = mostplayeds + 1
                end
            end
            if mostplayeds > 0 then
                SMODS.change_discard_limit(-1)
                blindSound()
            end
        end

        -- The Pillar
        if (context.after or context.pre_discard) and G.GAME.round_resets.blind_choices.Boss == "bl_pillar" and totp.demisePassiveCheck() then
            for _,card in pairs(context.full_hand) do
                card.totp_demise_drawn = true
            end
        end

        if context.hand_drawn and G.GAME.round_resets.blind_choices.Boss == "bl_pillar" and totp.demisePassiveCheck() then
            for _,card in pairs(G.hand.cards) do
                if card.totp_demise_drawn then
                    G.hand:add_to_highlighted(card, true)
                    G.FUNCS.discard_cards_from_highlighted(nil, true)
                    blindSound()
                end
            end
        end

        -- The Needle
        if context.destroy_card and G.GAME.current_round.hands_played ~= 0 and G.GAME.round_resets.blind_choices.Boss == "bl_needle" and totp.demisePassiveCheck() then
            for _,card in pairs(G.play.cards) do
                blindSound()
            end
            return{
                remove = true
            }
        end

        -- The Tooth can be found at src/ModGlobal.lua:99

        -- The Flint
        if context.after and SMODS.last_hand_oneshot and G.GAME.round_resets.blind_choices.Boss == "bl_flint" and totp.demisePassiveCheck() then
            blindSound()
            return{
                level_up = -(G.GAME.hands[context.scoring_name].level - 1)
            }
        end


        -- FINISHERS

        -- Amber Acorn
        if context.starting_shop and G.GAME.round_resets.blind_choices.Boss == "bl_final_acorn" and totp.demisePassiveCheck() then
            totp.setBacks({rarity = true})
            if #G.jokers.cards > 0 then
                G.jokers:unhighlight_all()
                for _, joker in ipairs(G.jokers.cards) do
                    joker:flip()
                end
                if #G.jokers.cards > 1 then
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.2,
                        func = function()
                            G.E_MANAGER:add_event(Event({
                                func = function()
                                    G.jokers:shuffle('aajk')
                                    play_sound('cardSlide1', 0.85)
                                    return true
                                end,
                            }))
                            delay(0.15)
                            G.E_MANAGER:add_event(Event({
                                func = function()
                                    G.jokers:shuffle('aajk')
                                    play_sound('cardSlide1', 1.15)
                                    return true
                                end
                            }))
                            delay(0.15)
                            G.E_MANAGER:add_event(Event({
                                func = function()
                                    G.jokers:shuffle('aajk')
                                    play_sound('cardSlide1', 1)
                                    return true
                                end
                            }))
                            delay(0.5)
                            return true
                        end
                    }))
                end
            end
        end

        if context.ending_shop and G.GAME.round_resets.blind_choices.Boss == "bl_final_acorn" and totp.demisePassiveCheck() then
            totp.setBacks({pos={x=0,y=4}})
            G.jokers:unhighlight_all()
            for _, card in ipairs(G.jokers.cards) do
                if card.facing == "back" then card:flip() end
            end
        end

        -- Verdant Leaf
        if context.selling_card and context.card.ability.set == "Joker" and G.GAME.round_resets.blind_choices.Boss == "bl_final_leaf" then
            G.GAME.totp_sold = true
        end

        if context.hand_drawn and G.GAME.round_resets.blind_choices.Boss == "bl_final_leaf" and totp.demisePassiveCheck() then
            G.GAME.totp_sold = nil
        end


        -- Violet Vessel
        if context.end_of_round and context.beat_boss and G.GAME.round_resets.blind_choices.Boss == "bl_final_vessel" then
            G.GAME.win_ante = G.GAME.win_ante + 2
            G.GAME.totp_vessel = true
        end

        if context.totp_selecting_blind and G.GAME.totp_vessel and G.GAME.round_resets.ante > G.GAME.win_ante - 3 and G.GAME.round_resets.ante <= G.GAME.win_ante then
            blindSound()
            G.GAME.totp_wall = G.GAME.totp_wall or {}
            if not G.GAME.totp_wall["Ante"..G.GAME.round_resets.ante] then
                for _,bl in ipairs{"Small","Big","Boss"} do
                    G.GAME.round_resets.blind_choices[bl] = "bl_wall"   
                    G.blind_select:remove()
                    G.blind_prompt_box:remove()
                end
                G.STATE_COMPLETE = false
                G.GAME.totp_wall["Ante"..G.GAME.round_resets.ante] = true
            end
        end

        -- Crimson Heart
        if context.before and G.GAME.round_resets.blind_choices.Boss == "bl_final_heart" and totp.demisePassiveCheck() then
            SMODS.debuff_card(pseudorandom_element(G.play.cards,"totp_demise_shart"),true,"totp_shart")
            blindSound()
        end

        if context.end_of_round then
            for _,card in pairs(G.deck.cards) do
                SMODS.debuff_card(card,false,"totp_shart")
            end
        end
        
        -- Cerulean Bell
        if context.discard and G.GAME.round_resets.blind_choices.Boss == "bl_final_bell" and totp.demisePassiveCheck() then
            G.GAME.totp_demise_discard = true
        end

        if context.hand_drawn and G.GAME.totp_demise_discard then
            for _,card in ipairs(context.hand_drawn) do
                G.hand:add_to_highlighted(card)
            end
            G.FUNCS.play_cards_from_highlighted()
            G.GAME.totp_demise_discard = nil
            blindSound()
        end
    end
    
})


