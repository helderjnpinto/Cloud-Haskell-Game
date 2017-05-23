module Data exposing (..)
import Types exposing (..)
import Json.Decode as JD exposing (Decoder, float, int)
import Json.Decode.Pipeline exposing (decode, required)


decodeCoords : Decoder Coords
decodeCoords =
    decode Coords
        |> required "x" JD.float
        |> required "y" JD.float


decodeGps : Decoder Gps
decodeGps =
    decode Gps
        |> required "distance" JD.float
        |> required "position" decodeCoords


decodePlayer : Decoder Player
decodePlayer =
    decode Player
        |> required "name" JD.string
        |> required "score" JD.int
        |> required "position" decodeCoords
        |> required "color" (JD.maybe JD.string)


decodeBoard : Decoder Board
decodeBoard =
    decode Board
        |> required "gpss" (JD.list decodeGps)
        |> required "players" (JD.list decodePlayer)
