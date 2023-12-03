(fn str-coord [coord] (.. (. coord 1) "," (. coord 2)))
(fn symbol-coords [filename] 
    ;; Build a big ol' dictionary of x y coords of symbols
    ;; and numbers
    ;; Numbers are {[x y]: 'number'}
    ;; Symbols are {'x,y': 'symbol'}
    ;; We'll match em up later
    (let [symbols {} numbers {}]
        (var y 1)
        (each [line (io.lines filename)]
              ;; March through the line, find any numbers or symbols
              (var x 1)
              (while (< x (length line))
                (let [remain (line:sub x (length line))]
                    ;(print remain)
                    (let [num (remain:match "^%d+")]
                        (when (not= num nil)
                            (tset numbers [x y] num)
                            (set x (+ x (- (length num) 1)))
                        )
                        (when (= num nil)
                            (let [c (remain:sub 1 1)]
                                (when (not= "." c)
                                    (tset symbols (str-coord [x y]) c)
                                )
                            )
                        )
                    )
                )
                (set x (+ x 1))
              )
              (set y (+ y 1))
            )
        ;; Now let's get all the numbers and search for symbols around them
        (var total 0)
        (each [coord val (pairs numbers)]
            (let [nx (. coord 1) ny (. coord 2) search [[(- nx 1) ny] [(+ (length val) nx) ny]]]
                (var ok false)
                (for [i 0 (+ (length val) 1)]
                    (table.insert search [(+ (- nx 1) i) (- ny 1)])
                    (table.insert search [(+ (- nx 1) i) (+ ny 1)])
                )
                (print (str-coord coord) val)
                (each [_ check (ipairs search)]
                    (when (and (= ok false) (not= (. symbols (str-coord check)) nil))
                        (set total (+ total (tonumber val)))
                        (set ok true)
                    )
                )
            )
        )
        (print total)

    ))

(symbol-coords "03.txt")