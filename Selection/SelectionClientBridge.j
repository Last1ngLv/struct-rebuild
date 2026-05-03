library SelectionClientBridge requires PlayerUtils, PlayerHeroState

    function SelectionCreateClients takes nothing returns nothing
        // Phase 1 rebuild: MenuClient is intentionally not loaded.
        // Keep this API as a no-op so SelectionStartFlow stays stable.
    endfunction

    function SelectionShowClients takes nothing returns nothing
        local integer i = 0
        local User u
        local unit hero

        loop
            exitwhen i == User.AmountPlaying
            set u = User.fromPlaying(i)
            set hero = PlayerHero[u.id]

            if hero != null and GetUnitTypeId(hero) != 0 then
                if User.Local == u.handle then
                    call SelectUnit(hero, true)
                    call PanCameraToTimed(GetUnitX(hero), GetUnitY(hero), 0)
                endif
            endif

            set i = i + 1
        endloop

        set hero = null
    endfunction

endlibrary
