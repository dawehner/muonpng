port module Todo exposing (..)

{-| TodoMVC implemented in Elm, using plain HTML and CSS for rendering.
This application is broken up into three key parts:
  1. Model  - a full definition of the application's state
  2. Update - a way to step the application state forward
  3. View   - a way to visualize our application state with HTML
This clean division of concerns is a core part of Elm. You can read more about
this in <http://guide.elm-lang.org/architecture/index.html>
-}

import Html exposing (..)
import Html.App as App
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Html.Lazy exposing (lazy, lazy2, lazy3)
import Json.Decode as Json exposing ((:=))
import String


main = text "hello world"

type alias DragEvent =
  {
    clientX: Int,
    clientY: Int,
    dataTransfer: DataTransfer
  }

type alias DataTransfer =
  {
    files: FileList
  }

type alias FileList =  List File

type alias File = {
  lastModified: Int,
  lastModifiedDate: String,
  name: String,
  size: Int,
  fileType: String
  }

dragEventDecoder : Json.Decoder (DragEvent)
dragEventDecoder = 
  Json.object3 DragEvent
    ("clientX" := Json.int) 
    ("clientY" := Json.int) 
    ("clientY" := dataTransferDecoder) 

dataTransferDecoder : Json.Decoder (DataTransfer)
dataTransferDecoder =
  Json.object1 DataTransfer
    ("files" := fileListDecoder)

fileListDecoder : Json.Decoder (FileList)
fileListDecoder = Json.list (fileDecoder)

fileDecoder : Json.Decoder (File)
fileDecoder =
  Json.object5 File
  ("lastModified" := Json.int)
  ("lastModifiedDate" := Json.string)
  ("name" := Json.string)
  ("size" := Json.int)
  ("type" := Json.string)
