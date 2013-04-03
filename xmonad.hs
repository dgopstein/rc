import XMonad.Layout.IM
import XMonad.Layout.Reflect
import Data.Ratio ((%))
import XMonad.Layout.PerWorkspace
import XMonad hiding (Tall)
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.UrgencyHook
import XMonad.Layout.LayoutHints
import XMonad.Layout.ResizableTile
import XMonad.Prompt
import XMonad.Config.Gnome
import XMonad.Prompt.Shell
import XMonad.Util.Run(spawnPipe)
import XMonad.Actions.CycleWS
 
import System.Exit
import System.IO
import Data.Monoid
 
import qualified XMonad.StackSet as W
import qualified Data.Map        as M

web     = "1:Web"
eclipse = "2:Eclipse"
email   = "3:Email"
extra   = "4:Extra"
 
main = do
    xmproc <- spawnPipe "xmobar"
    xmonad $ withUrgencyHook NoUrgencyHook
           $ gnomeConfig {
                terminal           = "urxvt",
                workspaces         = [web, eclipse, email, extra, "5", "6", "7", "8", "9"],
                normalBorderColor  = "#333333",
                focusedBorderColor = "#3399cc",
                borderWidth        = 2,
                --manageHook         = myManageHook,
                --modMask            = mod4Mask,
                keys               = myKeys,
                mouseBindings      = myMouseBindings,
                layoutHook         = myLayout,
                logHook            = dynamicLogWithPP $ xmobarPP {   -- maybe cuasing lockups?
                                         ppOutput = hPutStrLn xmproc,
                                         ppTitle = xmobarColor "#BEED5F" "" 
                                     }
    }
 
myKeys conf@(XConfig {XMonad.modMask = modMask}) = M.fromList $
 
    [ ((modMask              , xK_Return   ), spawn $ XMonad.terminal conf)
    , ((modMask .|. shiftMask, xK_c        ), kill)
    , ((modMask              , xK_space    ), sendMessage NextLayout)
    , ((modMask .|. shiftMask, xK_space    ), setLayout $ XMonad.layoutHook conf)
    , ((modMask              , xK_n        ), refresh)
    , ((modMask              , xK_Tab      ), windows W.focusDown)
    , ((modMask              , xK_j        ), windows W.focusDown)
    , ((modMask              , xK_k        ), windows W.focusUp)
    , ((modMask              , xK_m        ), windows W.focusMaster)
    , ((modMask .|. shiftMask, xK_Return   ), windows W.swapMaster)
    , ((modMask .|. shiftMask, xK_j        ), windows W.swapDown)
    , ((modMask .|. shiftMask, xK_k        ), windows W.swapUp)
    , ((modMask              , xK_h        ), sendMessage Shrink)
    , ((modMask              , xK_l        ), sendMessage Expand)
    , ((modMask .|. shiftMask, xK_h        ), sendMessage MirrorShrink)
    , ((modMask .|. shiftMask, xK_l        ), sendMessage MirrorExpand)
    , ((modMask              , xK_t        ), withFocused $ windows . W.sink)
    , ((modMask              , xK_comma    ), sendMessage (IncMasterN 1))
    , ((modMask              , xK_period   ), sendMessage (IncMasterN (-1)))
    , ((modMask .|. shiftMask, xK_q        ), io (exitWith ExitSuccess))
    , ((modMask              , xK_q        ), spawn "xmonad --recompile; xmonad --restart")
    , ((modMask              , xK_Page_Down), nextWS)
    , ((modMask              , xK_Page_Up  ), prevWS)
    , ((modMask .|. shiftMask, xK_Down     ), shiftToNext)
    , ((modMask .|. shiftMask, xK_Up       ), shiftToPrev)
    , ((modMask              , xK_F2       ), shellPrompt defaultXPConfig)
    , ((0                    , 0x1008ff13  ), spawn "amixer -q set Master 2dB+")
    , ((0                    , 0x1008ff11  ), spawn "amixer -q set Master 2dB-")
    , ((0                    , 0x1008ff12  ), spawn "amixer -q set Master toggle")
    , ((0                    , 0x1008ff16  ), spawn "mocp --prev")
    , ((0                    , 0x1008ff17  ), spawn "mocp --next")
    , ((0                    , 0x1008ff14  ), spawn "mocp --toggle-pause")
    , ((modMask              , xK_Print    ), spawn "scrot -e 'mv $f ~/Screenshots'")
    ]
    ++
 
    [((m .|. modMask, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
 
    ++
 
    [((m .|. modMask, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]
 
myMouseBindings (XConfig {XMonad.modMask = modMask}) = M.fromList $
    [ ((modMask, button1), (\w -> focus w >> mouseMoveWindow w
                                          >> windows W.shiftMaster))
    , ((modMask, button2), (\w -> focus w >> windows W.shiftMaster))
    , ((modMask, button3), (\w -> focus w >> mouseResizeWindow w
                                          >> windows W.shiftMaster))
    ]
 
myLayout = avoidStruts $
           onWorkspace email (pidgin) $
           tall ||| Mirror tall ||| Full
  where
     pidgin = --reflectHoriz $
              --reflectVert $
              withIM (1%10) (ClassName "Pidgin") $
              Mirror $
              ResizableTall nmaster delta pRatio []
     tall = ResizableTall nmaster delta ratio []
     nmaster = 1
     delta   = 1/100
     ratio   = 1/2
     pRatio   = 4/5
 
--myManageHook :: ManageHook
--myManageHook = composeAll
  --  [ className =? "Pidgin"    --> doShift email
  --, className =? "Firefox" --> doShift "6:Web"
  --, className =? "Eclipse" --> doShift eclipse]
