get_ints(str) = map(x -> parse(Int64, match(r"[[:digit:]]+", x).match), str)


get_ints(str) = [parse(Int64,str[l]) for l in findall(r"[[:digit:]]+", str)]


get_ints("432,708 -> 432,160")
