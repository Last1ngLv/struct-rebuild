library PreConfi initializer Init requires GameState, InitialWaveMultiboard, AudioPreloadConfig, WaveOwnerConfig, AllianceConfig, InitialGoldConfig, MovementSpellTargetConfig

    function InitTrig_Vars takes nothing returns nothing
        call GameStateInitDefaults()
        call InitInitialWaveMultiboard()
        call PreloadMapResources()
        call InitDefaultWaveOwnerResearches()
        call InitHostileNeutralAlliances()
        call InitInitialPlayerGold()
        call InitMovementSpellTargetConfig()
        call EnablePreSelect(true, false)
        call InitPlayerBountyStates()
    endfunction

    private function Init takes nothing returns nothing
        call InitTrig_Vars()
    endfunction

endlibrary
