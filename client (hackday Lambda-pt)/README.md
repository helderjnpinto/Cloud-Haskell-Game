# Hackday LambdaPT


# Client 'Elm' for haskell cloud game

## Install dependencies

### Install Elm compiler via npm

https://www.npmjs.com/package/elm

- npm install -g elm

### Elm live for development
https://www.npmjs.com/package/elm-live

- npm install --global elm elm-live


## Install elm packages
Root project run (Linux):

elm-packages install

## Run demo using elm-live

Root project run (Linux):

`elm-live ./src/App.elm --output ./js/main.js --port=8001 --open`

## Proto Json

```Json
{
   "gpss" : [
      {
         "distance" : 18.6010752377383,
         "position" : {
            "x" : -10,
            "y" : -8
         }
      },
      {
         "position" : {
            "x" : 12,
            "y" : -5
         },
         "distance" : 10.6301458127346
      },
      {
         "distance" : 10.816653826392,
         "position" : {
            "x" : -4,
            "y" : 9
         }
      }
   ],
   "players" : [
      {
         "score" : 0,
         "name" : "<Your Name Here>",
         "color" : null,
         "position" : {
            "y" : 0,
            "x" : 0
         }
      },
      {
         "score" : 0,
         "color" : null,
         "position" : {
            "x" : 0,
            "y" : 0
         },
         "name" : "<Your Name Here>"
      }
   ],
   "sampleCommands" : [
      {
         "contents" : "LambdaPT",
         "tag" : "SetName"
      },
      {
         "contents" : "#ff0000",
         "tag" : "SetColor"
      },
      {
         "contents" : {
            "x" : 1,
            "y" : -2
         },
         "tag" : "Move"
      }
   ]
}

```


### Editor Atom * Not required!

Packages for Atom:
  -https://atom.io/packages/elm-format
  -https://atom.io/packages/language-elm
  -https://atom.io/packages/html-to-elm


### Tutorials & Docs
  -http://elm-lang.org/
  -http://elm-lang.org/docs
  -http://elm-lang.org/examples
  -http://package.elm-lang.org/
  -https://github.com/isRuslan/awesome-elm
