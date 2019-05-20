{-# LANGUAGE EmptyCase #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE LambdaCase #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE TypeFamilies #-}
module Backend where

import Control.Monad.IO.Class

import Obelisk.Backend

import Common.Route
import Common.Types ()

import Backend.Store

backend :: Backend BackendRoute FrontendRoute
backend = Backend
  { _backend_run = \serve -> do
      liftIO demo
      serve $ const $ return ()
  , _backend_routeEncoder = backendRouteEncoder
  }
