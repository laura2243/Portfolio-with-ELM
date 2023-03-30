module Model.Event exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Model.Event.Category exposing (EventCategory(..))
import Model.Interval as Interval exposing (Interval)


type alias Event =
    { title : String
    , interval : Interval
    , description : Html Never
    , category : EventCategory
    , url : Maybe String
    , tags : List String
    , important : Bool
    }

takeInterval : Event -> Interval
takeInterval e = e.interval

categoryView : EventCategory -> Html Never
categoryView category =
    case category of
        Academic ->
            text "Academic"

        Work ->
            text "Work"

        Project ->
            text "Project"

        Award ->
            text "Award"

compareInterval: Event -> Event -> Order
compareInterval e1 e2 = Interval.compare e1.interval e2.interval

sortByInterval : List Event -> List Event
sortByInterval events = List.sortWith compareInterval events
   

eventToString : EventCategory -> String
eventToString event = case event of
                         Academic -> "Academic" 
                         Work -> "Work"
                         Project -> "Project"
                         Award -> "Award"



                            
view : Event -> Html Never
view event =
    div [classList
            [ ( "event-important", event.important == True )
            , ( "event", True )
            ]
        ]
        [ 
        h1 [class "event-title",style "background-color" "lavender", style "text-align" "center"] [text event.title],
        p [class "event-description"][ event.description],
        p [class "event-category"][text (eventToString event.category)],
        p [class "event-interval"][Interval.view event.interval],
        p [class "event-url"][  a [ href (Maybe.withDefault "" event.url) ] [text (Maybe.withDefault "" event.url)]]

    ]
   -- Debug.todo "Implement the Model.Event.view function"
