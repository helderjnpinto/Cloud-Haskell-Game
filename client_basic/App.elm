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
    | Move Coords
    | SendName
    | SetColor String
    | NewMessage String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SendName ->
            let
                moveCmd =
                    JE.object
                        [ ( "tag", JE.string "SetName" )
                        , ( "contents", JE.string model.input )
                        ]

                wsCmd =
                    JE.encode 0 moveCmd
                    |> WebSocket.send haskellServer
            in
              (!) model [wsCmd]
        Input newInput ->
            (!) { model | input = newInput } []

        SetColor color ->
          let
              moveCmd =
                  JE.object
                      [ ( "tag", JE.string "SetColor" )
                      , ( "contents", JE.string color )
                      ]

              wsCmd =
                  JE.encode 0 moveCmd
                  |> WebSocket.send haskellServer
          in
            (!) model [wsCmd]

        Move coords ->
            -- (Model "" messages, WebSocket.send echoServer input)
            let
                moveCoords =
                    JE.object
                        [ ( "x", JE.float coords.x )
                        , ( "y", JE.float coords.y )
                        ]

                moveCmd =
                    JE.object
                        [ ( "tag", JE.string "Move" )
                        , ( "contents", moveCoords )
                        ]

                wsCmd =
                    JE.encode 0 moveCmd
                    |> WebSocket.send haskellServer
            in
                (!) model [ wsCmd ]

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
colorPicker : Html Msg
colorPicker =
  input
    [ type_ "color", name "favcolor", value "#ff0000", onInput SetColor ]
    []

view : Model -> Html Msg
view model =
    div []
        [ input [ onInput Input, value model.input ] []
        , button [ onClick (Move <| Coords -1.0 0.0 ) ] [ text "Left" ]
        , button [ onClick (Move <| Coords 1.0 0.0 ) ] [ text "Right" ]
        , button [ onClick (Move <| Coords 0.0 1.0 ) ] [ text "Down" ]
        , button [ onClick (Move <| Coords 0.0 -1.0 ) ] [ text "UP" ]
        , button [ onClick (SendName) ] [ text "Sent name" ]
        , colorPicker
        ]
