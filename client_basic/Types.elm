module Types exposing (..)

{-| All types for app
-}


type alias Coords =
    { x : Float
    , y : Float
    }


type alias Gps =
    { distance : Float
    , position : Coords
    }


type alias Player =
    { name : String
    , score : Int
    , position : Coords
    , color : Maybe String
    }


type alias Board =
    { gpss : List Gps
    , players : List Player
    }
