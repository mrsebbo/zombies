MAPS = {
    {
        You,
        Crate {address = {5,5}},
        Crate {address = {5,4}},
        Crate {address = {5,3}},
        Crate {address = {5,2}},
        Zomb {address = {1,3}, player = You},
        Zomb {address = {1,5}, player = You}
    },
    -- PROBLEM: zombies contain a reference to the player. That appears to be impossible in a 
    -- pure table definition with no variable names. Define the player in Main and pass him on maybe?
    {
        You,
    }
}