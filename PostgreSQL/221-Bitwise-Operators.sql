-- Bitwise Operators

SELECT
    6 & 3   AS bit_and,     -- 110 & 011 = 010 → 2
    6 | 3   AS bit_or,      -- 110 | 011 = 111 → 7
    6 # 3   AS bit_xor,     -- 110 ^ 011 = 101 → 5
    ~6      AS bit_not,     -- ~110 = ...11111111111111111111111111111001 → -7
    6 << 1  AS shift_left,  -- 110 becomes 1100 → 12
    6 >> 1  AS shift_right; -- 110 becomes 011 → 3
