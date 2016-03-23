-- vim: ts=2:sw=2:sts=2
module XMonad.Config.Amer.LogHook (myLogHook) where

-- SEE how to combine CopyWindow and DynamicLog in more modular way
--  https://bbs.archlinux.org/viewtopic.php?id=194863

import qualified Data.Map.Strict as M
import System.IO (hPutStrLn)

import XMonad                         (io)
import XMonad.Actions.CopyWindow      (wsContainingCopies)
import XMonad.Actions.GroupNavigation (historyHook)
import XMonad.Hooks.DynamicLog        (dynamicLogString, xmobarColor, defaultPP, PP(..))  -- pad, wrap, shorten,

import qualified XMonad.Config.Amer.Workspace as MyWksp


escape = concatMap f :: String -> String where
  f '`' = "$'\\x60'"
  f x   = [x]
mouse n cmd txt = "<action=`" ++ escape cmd ++ "` button=" ++ show n ++ ">" ++ txt ++ "</action>"
wmctrl = ("r.xmonad " ++)  -- ALT: $'\\x" ++ showHex (ord $ head i) "'"

-- mkMap = M.fromList MyWksp.keys
xsMap = M.fromList [("`", "grave"), ("-", "underscore"), ("=", "equal"), ("/", "slash")]
key2xsym ws = M.findWithDefault ws ws xsMap
xdokey = ("xdotool key --delay 150 super+" ++) . key2xsym


-- xmobar pretty printing source
myStateLoggger copies = dynamicLogString defaultPP
  { ppCurrent = xmobarColor "#fd971f" ""
  -- , ppVisible = wrap "(" ")" (xinerama only)
  , ppHidden  = clickws . predefined
  -- , ppHiddenNoWindows = const ""
  , ppUrgent  = xmobarColor "red" "yellow"
  -- , ppTitle   = xmobarColor "green"  "" . shorten 40
  -- , ppWsSep   = " "
  , ppSep     = xmobarColor "#fd971f" "" " \xe0b1 "           -- separator between elements
  , ppOrder   = \(ws:l:_) -> [l, ws]                          -- elems order (title ignored)
  -- , ppSort    = getSortByIndex
  -- , ppExtras  = []
  , ppLayout  = clickly . \nm -> case nm of
      "ResizableTall" -> "[|]"
      "Mirror ResizableTall" -> "[-]"
      "Tabbed Simplest" -> "=--"
      "Full" -> "[ ]"
      "Grid" -> "[#]"
      "IM Grid" -> "|##"
      "SimplestFloat" -> "( )"
      "Circle" -> "(O)"
      _ -> nm
  }
  where
    markcopy i = if i `elem` copies then xmobarColor "#8888ff" "green" i else i
    predefined i = if i `elem` MyWksp.all then i else ""
    -- ALT clickws i = mouse 1 (xdokey $ M.findWithDefault "0" i mkMap) i
    clickws i = mouse 1 (wmctrl i) (markcopy i)
    clickly ly = mouse 1 (xdokey "f") (mouse 3 (xdokey "n") ly)


myLogHook h = do
  historyHook
  copies <- wsContainingCopies
  io . hPutStrLn h =<< myStateLoggger copies
