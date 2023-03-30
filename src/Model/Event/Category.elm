module Model.Event.Category exposing (EventCategory(..), SelectedEventCategories, allSelected, eventCategories, isEventCategorySelected, set, view)

import Html exposing (Html, div, input, text)
import Html.Attributes exposing (checked, class, style, type_)
import Html.Events exposing (onCheck)


type EventCategory
    = Academic
    | Work
    | Project
    | Award


eventCategories =
    [ Academic, Work, Project, Award ]

fromEventCategoryToString : EventCategory -> String
fromEventCategoryToString e = case e of
                                Academic -> "Academic"
                                Work -> "Work"
                                Project -> "Project"
                                Award -> "Award"

{-| Type used to represent the state of the selected event categories
-}
type  SelectedEventCategories
    = SelectedEventCategories { 
        academic : Bool,
        work : Bool,
        project : Bool, 
        award : Bool
    }

getAcademic : SelectedEventCategories -> Bool
getAcademic (SelectedEventCategories selectedEvent) = selectedEvent.academic

getWork : SelectedEventCategories -> Bool
getWork (SelectedEventCategories selectedEvent) = selectedEvent.work


getProject : SelectedEventCategories -> Bool
getProject (SelectedEventCategories selectedEvent) = selectedEvent.project

getAward : SelectedEventCategories -> Bool
getAward (SelectedEventCategories selectedEvent) = selectedEvent.award



{-| Returns an instance of `SelectedEventCategories` with all categories selected

    isEventCategorySelected Academic allSelected --> True

-}
allSelected : SelectedEventCategories
allSelected = SelectedEventCategories{academic = True,work = True, project = True, award = True}
   
  --  Debug.todo "Implement Model.Event.Category.allSelected"

{-| Returns an instance of `SelectedEventCategories` with no categories selected

-- isEventCategorySelected Academic noneSelected --> False

-}
noneSelected : SelectedEventCategories
noneSelected =SelectedEventCategories{academic = False,work = False, project = False, award = False}
    
  --  Debug.todo "Implement Model.Event.Category.noneSelected"

{-| Given a the current state and a `category` it returns whether the `category` is selected.

    isEventCategorySelected Academic allSelected --> True

-}
isEventCategorySelected : EventCategory -> SelectedEventCategories -> Bool
isEventCategorySelected category current = case category of
                                            Academic ->  getAcademic current
                                            Work -> getWork current
                                            Project ->getProject current
                                            Award ->getAward current 
                                           
 
  --  Debug.todo "Implement Model.Event.Category.isEventCategorySelected"


{-| Given an `category`, a boolean `value` and the current state, it sets the given `category` in `current` to `value`.

    allSelected |> set Academic False |> isEventCategorySelected Academic --> False

    allSelected |> set Academic False |> isEventCategorySelected Work --> True

-}
set : EventCategory -> Bool -> SelectedEventCategories -> SelectedEventCategories
set category value current = case category of
                                    Academic -> SelectedEventCategories {academic = value, work = getWork current, project = getProject current, award = getAward current}
                                    Work -> SelectedEventCategories {academic = getAcademic current, work =  value, project = getProject current, award = getAward current}
                                    Project ->SelectedEventCategories {academic = getAcademic current, work = getWork current, project = value, award = getAward current}
                                    Award ->SelectedEventCategories {academic = getAcademic current, work = getWork current, project = getProject current, award =  value} 
   



checkbox : String -> Bool -> EventCategory -> Html ( EventCategory, Bool )
checkbox name state category =
    div [ style "display" "inline", class "category-checkbox" ]
        [ input [ type_ "checkbox", onCheck (\c -> ( category, c )), checked state ] []
        , text name
        ]


view : SelectedEventCategories -> Html ( EventCategory, Bool )
view model =
     div [] [
        div [] [checkbox (fromEventCategoryToString Academic) (getAcademic model) (Academic)],
        div [] [checkbox (fromEventCategoryToString Project ) (getProject model) (Project)],
        div [] [checkbox (fromEventCategoryToString Work) (getWork model) (Work)],
        div [] [checkbox (fromEventCategoryToString Award) (getAward model) (Award)]
     ]
   
