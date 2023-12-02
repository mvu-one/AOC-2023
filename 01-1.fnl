(fn first-num [line]
    (for [i 1 (length line)]
        (let [num (tonumber (line:sub i i ))]
            (when num (lua "return num")))))

(fn get-num [line]
    (tonumber (.. 
        (first-num line)
        (first-num (string.reverse line))
    )))

(print (accumulate [sum 0
    line (io.lines "01.txt")]
    (+ sum (get-num line))))