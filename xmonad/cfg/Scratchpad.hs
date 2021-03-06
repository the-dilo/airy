-- vim: ts=2:sw=2:sts=2
module XMonad.Config.Amer.Scratchpad (myScratchpads) where

import XMonad.ManageHook            (appName, (=?))
import XMonad.StackSet              (RationalRect(..))
import XMonad.Util.NamedScratchpad  (NamedScratchpad(NS), nonFloating, defaultFloating, customFloating)

term s c = NS s ("r.t -n " ++ s ++ " -e " ++ c) (appName =? s)
vim s a = term s ("$EDITOR " ++ a)

myScratchpads :: [NamedScratchpad]
myScratchpads =
  [ term s s m | (s, m) <-
    [ ("htop"   , defaultFloating)
    , ("ncmpcpp", defaultFloating)
    , ("ipython", customFloating $ RationalRect (1/4) (2/3) 1 (1/3))
    ]
  ] ++
  [ term s c m | (s, c, m) <-
    [ ("agenda", "r.gcalcli-agenda", nonFloating)
    , ("todo", "r.airy-todo", nonFloating)
    , ("j8", "j8 -c", bottom_l14b3)
    ]
  ] ++
  [ vim "lyrics" "~/aura/lyfa/lists/music/anime.nou" nonFloating
  , vim "help" "~/aura/airy/cfg/xorg/xmonad/doc/LIOR.nou" defaultFloating
  ]
  where
    bottom_l14b3 = customFloating $ RationalRect 0 (2/3) (1/4) (1/3)
