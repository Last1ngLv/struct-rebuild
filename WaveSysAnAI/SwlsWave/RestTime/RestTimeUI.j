library RestTimeUI requires PlayerUtils, PreConfi, RestTimeState

    function RestTimeSetBoardTitle takes string title returns nothing
        if SwlsMultiboard != null then
            call MultiboardSetTitleText(SwlsMultiboard, title)
            call MultiboardDisplay(SwlsMultiboard, true)
        endif
    endfunction

    function RestTimeSetStatusForActivePlayers takes string statusText returns nothing
        set RestStatusText = statusText
    endfunction

    function RestTimeCloseTenderForActivePlayers takes nothing returns nothing
        // Phase 1 rebuild: no Tender/MenuClient UI to close.
    endfunction

    function RestTimeShowClientsForActivePlayers takes nothing returns nothing
        // Phase 1 rebuild: multiboard is the only rest-time UI.
    endfunction

endlibrary
