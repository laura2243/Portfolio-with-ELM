module Model.Date exposing (..)

import Html exposing (Html, div, text)
import Html.Attributes exposing (hidden)
import Maybe exposing (Maybe)
import Model.Util exposing (chainCompare)


type Date
    = Date { year : Int, month : Maybe Month }


year : Date -> Int
year (Date d) =
    d.year


month : Date -> Maybe Month
month (Date d) =
    d.month


full : Int -> Month -> Date
full y m =
    Date { year = y, month = Just m }


onlyYear : Int -> Date
onlyYear y =
    Date { year = y, month = Nothing }


{-| Given two `Date`s it returns the number of months between the two dates as an *absolute* value.
The month fields are handled as follows:

  - If both are present (`Just`), they are included normally in the calculation
  - If both are missing (`Nothing`), the number of years between the two dates is calculated
  - Otherwise the result is undefined (`Nothing`)


    monthsBetween (full 2020 Jan) (full 2020 Feb) --> Just 1
    monthsBetween (full 2020 Mar) (full 2020 Jan) --> Just 2
    monthsBetween (full 2020 Jan) (full 2020 Dec) --> Just 11

    monthsBetween (full 2020 Jan) (full 2021 Feb) --> Just 13
    monthsBetween (full 2021 Jan) (full 2020 Feb) --> Just 11

    monthsBetween (onlyYear 2020) (full 2021 Jan) --> Nothing
    monthsBetween (full 2020 Jan) (onlyYear 2021) --> Nothing

    monthsBetween (full 2020 Dec) (full 2021 Jan) --> Just 1

    monthsBetween (onlyYear 2020) (onlyYear 2021) --> Just 12
    monthsBetween (onlyYear 2020) (onlyYear 2022) --> Just 24


-}
monthsBetween : Date -> Date -> Maybe Int
monthsBetween dA dB = case (month dA,month dB) of
                    (Nothing,Nothing) -> Just (12*(abs(year dA - year dB)))  
                    (Just _, Just _) -> Just (abs (12 * (year dA - year dB) + monthToInt (Maybe.withDefault Jan (month dA)) - monthToInt (Maybe.withDefault Jan (month dB))))
                    _ -> Nothing


{-| Compares two dates.
First, dates are compared by the year field. If it's equal, the month fields are used as follows:

  - If both are present (`Just`), they are compared the result is returned
  - If both are missing (`Nothing`), the dates are equal
  - Otherwise the date without month is greater


    Model.Date.compare (full 2020 Jan) (full 2021 Jan) --> LT
    Model.Date.compare (full 2021 Dec) (full 2021 Jan) --> GT

    Model.Date.compare (full 2020 Jan) (full 2020 Dec) --> LT
    Model.Date.compare (onlyYear 2020) (onlyYear 2021) --> LT

    Model.Date.compare (onlyYear 2020) (full 2020 Dec) --> GT
    Model.Date.compare (onlyYear 2019) (full 2020 Dec) --> LT


-}
compare : Date -> Date -> Order
compare (Date d1) (Date d2) = 
                let
                        equalYear = case (d1.month, d2.month) of
                                    (Just monthA, Just monthB) -> compareMonth monthA monthB
                                    (Just _, Nothing) -> LT
                                    (Nothing, Just _) -> GT
                                    (Nothing,Nothing) -> EQ
                        


                in  Model.Util.chainCompare equalYear (Basics.compare d1.year d2.year)
 

--                                  if  d1.year ==  d2.year then 
--                                 if d1.month /= Nothing && d2.month /= Nothing then
--                                    if monthToInt (Maybe.withDefault Jan d1.month) > monthToInt (Maybe.withDefault Jan d2.month) then GT
--                                      else if  monthToInt (Maybe.withDefault Jan d1.month) < monthToInt (Maybe.withDefault Jan d2.month) then LT
--                                      else if monthToInt (Maybe.withDefault Jan d1.month) == monthToInt (Maybe.withDefault Jan d2.month) then LT
--                                      else if   d1.year > d1.year then GT else LT
                                    
                                     
     
   -- Debug.todo "Implement Model.Date.compare"



-- Debug.todo "Implement Model.Date.compare"


{-| Given a current date and the number of months, it returns a new date with the given number of months passed.
-}
offsetMonths : Int -> Date -> Date
offsetMonths months (Date d) =
    let
        addMonths =
            modBy 12 months

        addedMonths =
            d.month
                |> Maybe.map monthToInt
                |> Maybe.map ((+) addMonths)

        newMonth =
            addedMonths
                |> Maybe.map (modBy 12)
                |> Maybe.andThen intToMonth

        addYears =
            months // 12

        extraYear =
            if Maybe.withDefault 0 addedMonths >= 12 then
                1

            else
                0
    in
    Date { year = d.year + addYears + extraYear, month = newMonth }


view : Date -> Html msg
view (Date d) = div [] [

    div [][if d.month == Nothing then text  ( String.fromInt d.year ) 
            else text  (monthToString  (Maybe.withDefault Jan d.month) ++ "-" ++ String.fromInt d.year ) ]]
   -- Debug.todo "Implement Model.Date.view"


-- Debug.todo "Implement Model.Date.view"
-- MONTH


type Month
    = Jan
    | Feb
    | Mar
    | Apr
    | May
    | Jun
    | Jul
    | Aug
    | Sep
    | Oct
    | Nov
    | Dec


intToMonth : Int -> Maybe Month
intToMonth idx =
    case idx of
        0 ->
            Just Jan

        1 ->
            Just Feb

        2 ->
            Just Mar

        3 ->
            Just Apr

        4 ->
            Just May

        5 ->
            Just Jun

        6 ->
            Just Jul

        7 ->
            Just Aug

        8 ->
            Just Sep

        9 ->
            Just Oct

        10 ->
            Just Nov

        11 ->
            Just Dec

        _ ->
            Nothing


monthToInt : Month -> Int
monthToInt m =
    case m of
        Jan ->
            0

        Feb ->
            1

        Mar ->
            2

        Apr ->
            3

        May ->
            4

        Jun ->
            5

        Jul ->
            6

        Aug ->
            7

        Sep ->
            8

        Oct ->
            9

        Nov ->
            10

        Dec ->
            11


monthToString : Month -> String
monthToString m =
    case m of
        Jan ->
            "January"

        Feb ->
            "February"

        Mar ->
            "March"

        Apr ->
            "April"

        May ->
            "May"

        Jun ->
            "June"

        Jul ->
            "July"

        Aug ->
            "August"

        Sep ->
            "September"

        Oct ->
            "October"

        Nov ->
            "November"

        Dec ->
            "December"


compareMonth : Month -> Month -> Order
compareMonth m1 m2 =
    Basics.compare (monthToInt m1) (monthToInt m2)


{-| Returns the number of months between two months as an *absolute* value.

    monthsBetweenMonths Jan Jan --> 0

    monthsBetweenMonths Jan Apr --> 3

    monthsBetweenMonths Apr Jan --> 3

-}
monthsBetweenMonths : Month -> Month -> Int
monthsBetweenMonths m1 m2 = abs((monthToInt  m1 - monthToInt  m2))