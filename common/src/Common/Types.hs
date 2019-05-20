{-# LANGUAGE DeriveAnyClass #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE StandaloneDeriving #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE TypeSynonymInstances #-}
{-# LANGUAGE UndecidableInstances #-}

module Common.Types where

import Data.Text (Text)
import Data.Time.Clock

import Database.Beam

data NoteT f = Note
  { _noteTime :: Columnar f UTCTime
  , _noteContent :: Columnar f Text
  }
  deriving Generic

type Note = NoteT Identity
type NoteId = PrimaryKey NoteT Identity

deriving instance Show Note
deriving instance Eq Note
instance Beamable NoteT

instance Table NoteT where
 data PrimaryKey NoteT f = NoteId (Columnar f UTCTime) deriving (Generic, Beamable)
 primaryKey = NoteId . _noteTime
