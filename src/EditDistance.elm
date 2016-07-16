module EditDistance exposing ( Change, edits, levenshtein )

{-|  The EditDistance module allows for calculating the Levenshtein distance
between two lists.

# Edit Distance
@docs Change, edits, levenshtein
-}

{-| Describes an edit step used to go from one list to another. -}
type Change a
  = Insertion a Int
  | Deletion a Int
  | Move a Int Int

{-| Calculate the minimal steps (insertions, deletions and moves) required to
turn one given list into another.

    edits (toList "preterit") (toList "zeitgeist") ==
      [ Delete "g" 0
      , Move "r" 2 0
      ]
-}

edits : List a -> List a -> List Change
edits source target =
  []

{-| Calculate the Levenshtein distance between two lists, i.e. how many
insertions, deletions or substitutions are required to turn one given list into
another.

    levenshtein (toList "kitten") (toList "sitting") == 3
    levenshtein (toList "preterit") (toList "zeitgeist") == 6
    levenshtein (toList "garvey") (toList "avery") == 3
-}
levenshtein : List a -> List a -> Int
levenshtein source target =
  case (source, target) of
    (source, []) -> List.length source
    ([], target) -> List.length target
    (src_hd::src_rest, tgt_hd::tgt_rest) ->
      if src_hd == tgt_hd then
        levenshtein src_rest tgt_rest
      else
        Maybe.withDefault 0 (List.minimum
          [ (levenshtein src_rest target) + 1
          , (levenshtein source tgt_rest) + 1
          , (levenshtein src_rest tgt_rest) + 1
          ])
