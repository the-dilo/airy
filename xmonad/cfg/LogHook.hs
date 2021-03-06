-- vim: ts=2:sw=2:sts=2
module XMonad.Config.Amer.LogHook (myLogHook) where

-- SEE how to combine CopyWindow and DynamicLog in more modular way
--  https://bbs.archlinux.org/viewtopic.php?id=194863

import qualified Data.Map.Strict as M
import System.IO (hPutStrLn)
import Data.Default  (def)
import Text.Regex    (mkRegex, subRegex)

import XMonad                         (io)
import XMonad.Actions.CopyWindow      (wsContainingCopies)
import XMonad.Actions.GroupNavigation (historyHook)
import XMonad.Hooks.DynamicLog        (dynamicLogString, xmobarColor, PP(..))  -- pad, wrap, shorten,

import qualified XMonad.Config.Amer.Workspace as MyWksp


escape = concatMap f :: String -> String where
  f '`' = "$'\\x60'"
  f x   = [x]
mouse b cmd s = "<action=`" ++ escape cmd ++ "` button=" ++ show b ++ ">" ++ s ++ "</action>"
wmctrl = ("r.wm -w " ++)  -- ALT: $'\\x" ++ showHex (ord $ head i) "'"
-- ADD: wmctrl -r :ACTIVE: -b toggle,fullscreen -- Toggle fullscreen for current window only (not layout)

-- mkMap = M.fromList MyWksp.keys
xsMap = M.fromList [("`", "grave"), ("-", "underscore"), ("=", "equal"), ("/", "slash")]
key2xsym ws = M.findWithDefault ws ws xsMap
xdokey = ("xdotool key --delay 150 super+" ++) . key2xsym


-- xmobar pretty printing source
myStateLogger copies = dynamicLogString def
  { ppCurrent = xmobarColor "#fd971f" "" . mouse 1 "r.wm M-a"
  -- { ppCurrent = \t -> "<fc=#fd971f,#ffffff>" ++ t ++ "</fc>"
  -- , ppVisible = wrap "(" ")" (xinerama only)
  , ppHidden  = pHidden
  -- , ppHiddenNoWindows = const ""
  , ppUrgent  = \i -> xmobarColor "red" "yellow" (clickws i i)
  -- , ppTitle   = xmobarColor "green"  "" . shorten 40
  -- , ppWsSep   = " "
  , ppSep     = xmobarColor "#fd971f" "" (scrollws " \xe0b1 ") -- separator between elements
  , ppOrder   = \(ws:l:_) -> [l, ws]                          -- elems order (title ignored)
  -- , ppSort    = getSortByIndex
  -- , ppExtras  = []
  , ppLayout  = clickly . \nm -> case nmFilter nm of
      "ResizableTall" -> "[|]"
      "ReflectX ResizableTall" -> "]|["
      "Mirror ResizableTall" -> "[-]"
      "Mirror ReflectX ResizableTall" -> "]-["
      "TwoPane" -> "|="
      "ReflectX TwoPane" -> "=|"
      "Mirror TwoPane" -> "/="
      "Mirror ReflectX TwoPane" -> "=/"
      "Tabbed Simplest" -> "=--"
      "ReflectX Tabbed Simplest" -> "--="
      "Full" -> "[ ]"
      "Grid" -> "[#]"
      "IM Grid" -> "|##"
      "ReflectX IM Grid" -> "##|"
      "Mirror IM Grid" -> "/##"
      "Mirror ReflectX IM Grid" -> "##/"
      "SimplestFloat" -> "( )"
      "Circle" -> "(O)"
      _ -> nm
  }
  where
    -- ALT clickws i = mouse 1 (xdokey $ M.findWithDefault "0" i mkMap) i
    clickws i  = mouse 1 ("r.wm -w " ++ i)
    clickly ly = mouse 1 "r.wm M-n" (mouse 3 "r.wm M-S-n" ly)
    scrollws s = mouse 4 "r.wm 'M-<Tab>'" (mouse 5 "r.wm 'M-<Tab>'" s)
    -- clickly ly = mouse 1 (xdokey "f") (mouse 3 (xdokey "n") ly)
    cHidden i s | i `elem` copies = xmobarColor "#8888ff" "green" s
                | i `elem` MyWksp.named = xmobarColor "#aa9988" "" s
                | otherwise = s
    pHidden i | i `elem` MyWksp.all = cHidden i (clickws i i)
              | otherwise = ""
    nmFilter nm = subRegex (mkRegex "(SmartSpacing\\s+[0-9]+|Maximize|Minimize)\\s*") nm ""


myLogHook h = do
  historyHook
  copies <- wsContainingCopies
  io . hPutStrLn h =<< myStateLogger copies
  -- USE: to disable writing status when xmobar not launched
  -- io . hPutStrLn h =<< myStateLogger { ppOutput = \s -> return () } copies
