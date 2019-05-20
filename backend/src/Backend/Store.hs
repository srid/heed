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

import Database.Beam
import Database.Beam.Postgres

import Common.Types

data HeedDb f = HeedDb
  { _heedNotes :: f (TableEntity NoteT)
  }
  deriving (Generic, Database be)

heedDb :: DatabaseSettings be HeedDb
heedDb = defaultDbSettings

demo :: IO ()
demo = do
  -- TODO: Put connection string in backend config file.
  conn <- connectPostgreSQL "postgresql://nixcloud:nixcloud@localhost/heeddev"
  putStrLn "Querying DB for test"
  runBeamPostgresDebug putStrLn conn $ do
    notes <- runSelectReturningList $ select $ all_ (_heedNotes heedDb)
    mapM_ (liftIO . putStrLn . show) notes
