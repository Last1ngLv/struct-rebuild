library PlayerFixedCamera initializer Init requires TimerUtils, PlayerUtils, Camera, PlayerHeroState

    globals
        private constant real PLAYER_FIXED_CAMERA_TICK = 0.03
        private constant real PLAYER_FIXED_CAMERA_DISTANCE = 2000.00
        private constant real PLAYER_FIXED_CAMERA_Z_OFFSET = 500.00
        private constant real PLAYER_FIXED_CAMERA_OFFSET_RATIO = 0.25

        private timer PlayerFixedCameraTimer = null
        private boolean array PlayerFixedCameraDistanceApplied
    endglobals

    private function PlayerFixedCameraHeroValid takes unit hero returns boolean
        return hero != null and GetUnitTypeId(hero) != 0 and UnitAlive(hero)
    endfunction

    private function PlayerFixedCameraEnsure takes integer pid returns Camera
        if PlayerCamera[pid] == 0 then
            set PlayerCamera[pid] = Camera.create()
            set PlayerFixedCameraDistanceApplied[pid] = false
        endif
        if not PlayerFixedCameraDistanceApplied[pid] then
            set PlayerCamera[pid].distance = PLAYER_FIXED_CAMERA_DISTANCE
            call PlayerCamera[pid].setYawPitchRoll(PlayerCamera[pid].yaw, PlayerCamera[pid].pitch, PlayerCamera[pid].roll, false)
            set PlayerFixedCameraDistanceApplied[pid] = true
        endif
        return PlayerCamera[pid]
    endfunction

    function PlayerFixedCameraRefreshForPlayer takes integer pid returns nothing
        local unit hero
        local Camera cam
        local real x
        local real y
        local real z
        local real cameraOffset

        if pid < 0 or pid >= bj_MAX_PLAYER_SLOTS then
            return
        endif
        if not User.fromIndex(pid).isPlaying then
            return
        endif

        set hero = PlayerHero[pid]
        if not PlayerFixedCameraHeroValid(hero) then
            set hero = null
            return
        endif

        set cam = PlayerFixedCameraEnsure(pid)
        set x = GetUnitX(hero)
        set y = GetUnitY(hero)
        set z = GetTerrainZ(x, y) + PLAYER_FIXED_CAMERA_Z_OFFSET + GetUnitDefaultFlyHeight(hero)
        set cameraOffset = PLAYER_FIXED_CAMERA_DISTANCE*PLAYER_FIXED_CAMERA_OFFSET_RATIO

        call cam.setPosition(x, y - cameraOffset, z)
        call cam.applyCameraForPlayer(Player(pid), false)

        set hero = null
    endfunction

    function PlayerFixedCameraRefreshAll takes nothing returns nothing
        local integer i = 0
        local User u
        loop
            exitwhen i == User.AmountPlaying
            set u = User.fromPlaying(i)
            call PlayerFixedCameraRefreshForPlayer(u.id)
            set i = i + 1
        endloop
    endfunction

    private function PlayerFixedCameraOnTick takes nothing returns nothing
        call PlayerFixedCameraRefreshAll()
    endfunction

    function PlayerFixedCameraStart takes nothing returns nothing
        if PlayerFixedCameraTimer == null then
            set PlayerFixedCameraTimer = NewTimer()
            call SetTimerDebugTag(PlayerFixedCameraTimer, TIMER_DEBUG_TAG_OTHER)
        endif
        call TimerStart(PlayerFixedCameraTimer, PLAYER_FIXED_CAMERA_TICK, true, function PlayerFixedCameraOnTick)
    endfunction

    private function Init takes nothing returns nothing
        call PlayerFixedCameraStart()
    endfunction

endlibrary

