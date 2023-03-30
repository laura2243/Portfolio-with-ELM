module Model.Repo exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, href)
import Json.Decode as De
import Json.Decode exposing (string)
import Http exposing(..)


type alias Repo =
    { name : String
    , description : Maybe String
    , url : String
    , pushedAt : String
    , stars : Int
    }
getStarts: Repo -> Int
getStarts r = r.stars

view : Repo -> Html msg
view repo =
     div [class "repo"] [
        div [class "repo-name"] [text repo.name],
        div [class "repo-description"][text (Maybe.withDefault "" repo.description)],
        div [class "repo-url"][ a [ href repo.url ] [ text repo.url ]],
        div [class "repo-stars"][text (String.fromInt repo.stars)]


     ]

compareStar: Repo -> Repo -> Order
compareStar r1 r2 = if getStarts r1 > getStarts r2 then GT
                    else if getStarts r1 < getStarts r2 then LT
                    else EQ
                    

sortByStars : List Repo -> List Repo
sortByStars repos = List.sortWith compareStar repos
     



{-| Deserializes a JSON object to a `Repo`.
Field mapping (JSON -> Elm):

  - name -> name
  - description -> description
  - html\_url -> url
  - pushed\_at -> pushedAt
  - stargazers\_count -> stars

-}
decodeRepo : De.Decoder Repo
decodeRepo = De.map5 Repo
            ( De.field "name" De.string )
            ( De.field "description" (De.maybe De.string))
            ( De.field "html_url" De.string)
            ( De.field "pushed_at" De.string)
            ( De.field "stargazers_count" De.int)

  
   -- Debug.todo "Implement Model.Repo.decodeRepo"
