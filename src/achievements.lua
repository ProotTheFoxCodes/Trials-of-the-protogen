SMODS.Achievement {
    key = "pow5",
    bypass_all_unlocked = true,
    hidden_name = false,
    hidden_text = false,
    unlock_condition = function(self,args)
        return(args.type == "pow5")
    end,
}

SMODS.Achievement {
    key = "oblivion",
    bypass_all_unlocked = true,
    hidden_name = false,
    hidden_text = false,
    unlock_condition = function(self,args)
        return(args.type == "oblivion")
    end,
}