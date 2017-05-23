module App exposing (..)

{-| The entry point for the app.

@docs main

-}

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import WebSocket
import Types exposing (..)
import Json.Encode as JE
import Json.Decode as JD exposing (Decoder, float, int)
import Data exposing (..)

main : Program Never Model Msg
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


haskellServer : String
haskellServer =
    "ws://localhost:8000"



-- MODEL


type alias Model =
    { input : String
    , board : Board
    }

initModel : Model
initModel =
    { input = ""
    , board = Board [] []
    }


init : ( Model, Cmd Msg )
init =
    ( initModel, Cmd.none )



-- UPDATE


type Msg
    = Input String
    | Send
    | NewMessage String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Input newInput ->
            (!) model []

        Send ->
            -- (Model "" messages, WebSocket.send echoServer input)
            (!) model []

        NewMessage v ->
          case (JD.decodeString decodeBoard v) of
            -- ok correct decoded data
              Ok boardData ->
                  (!) { model | board = boardData } []
            -- Error
              _ ->
                  (!) model []



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ WebSocket.listen haskellServer NewMessage
        , WebSocket.keepAlive haskellServer
        ]



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ input [ onInput Input, value model.input ] []
        , button [ onClick Send ] [ text "Send" ]
        ]


viewMessage : String -> Html msg
viewMessage msg =
    div [] [ text msg ]


-- Decoders
