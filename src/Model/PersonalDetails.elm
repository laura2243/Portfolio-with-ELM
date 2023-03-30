module Model.PersonalDetails exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)


type alias DetailWithName =
    { name : String
    , detail : String
    }


type alias PersonalDetails =
    { name : String
    , contacts : List DetailWithName
    , intro : String
    , socials : List DetailWithName
    }


view : PersonalDetails -> Html msg
view details = div [] [
     h1 [id "name",style "background-color" "lavender",style "text-align" "center"] [text (details.name)],
     em [id "intro",style "padding-left" "13cm", style "font" "italic"] [text details.intro],
     ul [style "padding-left" "17cm"] (List.map (\i -> li [class "contact-detail"] [text i]) (List.map (\x -> x.detail) details.contacts)),
     ul [style "padding-left" "17cm"] (List.map (\i -> li [class "social-link"] [ a [ href i ] [ text i] ]) (List.map (\x -> x.detail) details.socials))]


