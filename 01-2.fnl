(local nums [
    "one" "two" "three" "four" "five"
    "six" "seven" "eight" "nine"
])

(fn first-num [line nums]
    (for [i 1 (length line)]
        (let [num (tonumber (line:sub i i ))]
            (when num (lua "return num")))
        (each [n val (ipairs nums)]
            (when (= val (line:sub i (+ i (- (length val) 1))))
                (lua "return n")
            ))))

(fn get-num [line]
    (tonumber (.. 
        (first-num line nums)
        (first-num 
            (string.reverse line)
            (icollect [_ s (ipairs nums)] (string.reverse s))
        )
    )))

(print (accumulate [sum 0
    line (io.lines "01.txt")]
    (+ sum (get-num line))))