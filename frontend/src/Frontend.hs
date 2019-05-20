{-# LANGUAGE DataKinds #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeApplications #-}
module Frontend where

import Reflex.Dom.Core

import Obelisk.Frontend
import Obelisk.Route

import Common.Route

frontend :: Frontend (R FrontendRoute)
frontend = Frontend
  { _frontend_head = el "title" $ text "Heed"
  , _frontend_body = do
      text "Welcome to Heed!"
  }
