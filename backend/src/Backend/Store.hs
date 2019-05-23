{-# LANGUAGE DeriveAnyClass #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE LambdaCase #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE TypeApplications #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE TypeSynonymInstances #-}
{-# LANGUAGE UndecidableInstances #-}

module Backend.Store where

import Database.PostgreSQL.Simple (Query, execute_)

import Database.Beam
import Database.Beam.Postgres

import Gargoyle (withGargoyle)
import Gargoyle.PostgreSQL.Nix (postgresNix)

import Common.Types

data HeedDb f = HeedDb
  { _heedNotes :: f (TableEntity NoteT)
  }
  deriving (Generic, Database be)

heedDb :: DatabaseSettings be HeedDb
heedDb = defaultDbSettings

schema :: Query
schema = "CREATE TABLE IF NOT EXISTS notes (created_at TIMESTAMPTZ NOT NULL, content VARCHAR NOT NULL);"

demo :: IO ()
demo = do
  g <- postgresNix
  withGargoyle g "db" $ \uri -> do
    conn <- connectPostgreSQL uri
    _ <- execute_ conn schema
    runBeamPostgresDebug putStrLn conn $ do
      notes <- runSelectReturningList $ select $ all_ (_heedNotes heedDb)
      mapM_ (liftIO . putStrLn . show) notes
