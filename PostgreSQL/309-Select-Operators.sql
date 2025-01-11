


-- ====================
-- >
-- >=
-- > ALL
-- > ANY



-- ====================
-- <
-- <=
-- < ALL
-- < ANY


-- ====================
-- =


-- ====================
-- <> or !=


-- ====================
-- IN


-- ====================
-- NOT IN


-- ====================
-- LIKE


-- ====================
-- ~ (pattern matching)
-- https://www.postgresql.org/docs/current/functions-matching.html#FUNCTIONS-POSIX-REGEXP
-- 'abcd' ~ 'bc'     true
-- 'abcd' ~ 'a.c'    true — dot matches any character
-- 'abcd' ~ 'a.*d'   true — * repeats the preceding pattern item
-- 'abcd' ~ '(b|x)'  true — | means OR, parentheses group
-- 'abcd' ~ '^a'     true — ^ anchors to start of string
-- 'abcd' ~ '^(b|c)' false — would match except for anchoring


-- ====================
-- SIMILAR TO


