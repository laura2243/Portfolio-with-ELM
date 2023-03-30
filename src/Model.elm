module Model exposing (..)

import Html exposing (b, div, p, text)
import Model.Date as Date
import Model.Event as Event exposing (Event)
import Model.Event.Category exposing (EventCategory(..), SelectedEventCategories, allSelected)
import Model.Interval as Interval
import Model.PersonalDetails exposing (DetailWithName, PersonalDetails)
import Model.Repo exposing (Repo)


type alias Model =
    { personalDetails : PersonalDetails
    , events : List Event
    , selectedEventCategories : SelectedEventCategories
    , repos : List Repo
    }


academicEvents : List Event
academicEvents =
    [ { title = "Studied at the 'Mihai Eminescu' National College"
      , interval = Interval.withDurationYears (Date.onlyYear 2016) 4
      , description = p [] [ text "I obtained ", b [] [ text "very" ], text " good grades." ]
      , category = Academic
      , url = Nothing
      , tags = []
      , important = False
      }
    , { title = "Technical University of Cluj-Napoca"
      , interval = Interval.open(Date.onlyYear 2020) 
      , description = div [] []
      , category = Academic
      , url = Nothing
      , tags = []
      , important = False
      }
    ]


workEvents : List Event
workEvents =[
    -- [ { title = "Work event 1"
    --   , interval = Interval.withDurationMonths 2021 Date.Jun 3
    --   , description = text "Internship"
    --   , category = Work
    --   , url = Nothing
    --   , tags = []
    --   , important = False
    --   }
    -- , { title = "Work event 2"
    --   , interval = Interval.open (Date.full 2021 Date.Sep)
    --   , description = text "Junior position"
    --   , category = Work
    --   , url = Nothing
    --   , tags = []
    --   , important = False
    --   }
    ]


projectEvens : List Event
projectEvens =
    [ { title = "Personal project 1: Polynomial-Calculator"
      , interval = Interval.oneYear 2020
      , description = text "Polynomial calculator app designed and implemented in Java, with a dedicated graphical interface through which the user can insert polynomials, select the mathematical operation (i.e., addition, subtraction,multiplication, division, derivative, integration) to be performed and view the result."
      , category = Project
      , url = Just "https://gitlab.com/pt2022_30227_laura_ailinca/pt2022_30227_laura_ailinca_assignment_1"
      , tags = []
      , important = False
      }
    , { title = "Personal project 2: Queues-Managament-Application"
      , interval = Interval.oneYear 2020
      , description = text "A queues management application designed and implemented in Java, which assigns clients to queues such that the waiting time is minimized using threads. "
      , category = Project
      , url = Just "https://gitlab.com/pt2022_30227_laura_ailinca/pt2022_30227_laura_ailinca_assignment_2/-/tree/master"
      , tags = []
      , important = False
      }
    , { title = "Personal project 3: Orders-Management"
      , interval = Interval.oneYear 2020
      , description = text "An Orders Management application designed and implemented in Java for processing client orders for a warehouse using a relational databases to store the products, the clients, and the orders."
      , category = Project
      , url = Just "https://gitlab.com/pt2022_30227_laura_ailinca_assignment_3/pt2022_30227_laura_ailinca_assignment_3/-/tree/master"
      , tags = []
      , important = False
      }
    ]


personalDetails : PersonalDetails
personalDetails =
    { name = "Ailinca Laura"
    , intro = "There are 10 types of people in the world: those who understand binary, and those who don't."
    , contacts = [ DetailWithName "email" "laura_2243@yahoo.com" ]
    , socials = [ DetailWithName "github" "https://github.com/laura2243" ]
    }



initModel : Model
initModel =
    { personalDetails = personalDetails
    , events = Event.sortByInterval <| academicEvents ++ workEvents ++ projectEvens
    , selectedEventCategories = allSelected
    , repos = []
    }
