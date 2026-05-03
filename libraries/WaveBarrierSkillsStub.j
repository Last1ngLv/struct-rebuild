library WaveBarrierSkills

    globals
        constant integer WAVE_BARRIER_PROJECTILE_KIND_NORMAL = 0
        constant integer WAVE_BARRIER_PROJECTILE_KIND_WIND = 1
        constant integer WAVE_BARRIER_PROJECTILE_KIND_RAY = 2

        constant integer WAVE_BARRIER_INTERACTION_NONE = 0
        constant integer WAVE_BARRIER_INTERACTION_BLOCK = 1
        constant integer WAVE_BARRIER_INTERACTION_WIND = 2
        constant integer WAVE_BARRIER_INTERACTION_RAY = 3
    endglobals

    function WaveBarrierCheckPlayerProjectile takes Missile missile, player owner, real x, real y, integer projectileKind returns integer
        // Phase 1 rebuild: enemy barrier spell interactions are disabled.
        return WAVE_BARRIER_INTERACTION_NONE
    endfunction

    function WaveBarrierClearProjectileTrace takes Missile missile returns nothing
        // Phase 1 rebuild: no barrier traces are tracked.
    endfunction

    function WaveBarrierSkillsTryExecute takes unit caster, unit target, integer clockMs returns boolean
        // Phase 1 rebuild: enemy barrier skills are disabled.
        return false
    endfunction

endlibrary
