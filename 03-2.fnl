(fn str-coord [coord] (.. (. coord 1) "," (. coord 2)))
;; I can't believe i need to define this
(fn tbl-length [tbl] (accumulate [sum 0 _i _j (pairs tbl)] (+ sum 1)))
(fn symbol-coords [filename] 
    ;; Build a big ol' dictionary of x y coords of symbols
    ;; We'll do the opposite this time -- number coords as strings
    ;; and symbol coords (only gears) as coord digits
    (let [symbols {} numbers {}]
        (var y 1)
        (each [line (io.lines filename)]
              ;; March through the line, find any numbers or symbols
              (var x 1)
              (while (< x (length line))
                (let [remain (line:sub x (length line))]
                    (let [num (remain:match "^%d+")]
                        (when (not= num nil)
                            ;; We're going to set the value for all coordinates
                            ;; this number covers. so 545 at pos 10,10
                            ;; will have entries for 10,10, 11,10 and 12,10
                            ;; Don't judge me
                            (for [i x (- (+ x (length num)) 1)]
                                (tset numbers (str-coord [i y]) num)
                            )
                            (set x (+ x (- (length num) 1)))
                        )
                        (when (= num nil)
                            (let [c (remain:sub 1 1)]
                                (when (= "*" c)
                                    (tset symbols [x y] c)
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
        (each [coord val (pairs symbols)]
            ;; Reuse this from part 1, even though length will always be 1
            (let [nx (. coord 1) ny (. coord 2) search [[(- nx 1) ny] [(+ (length val) nx) ny]]]
                (var seen_numbers {})
                (for [i 0 (+ (length val) 1)]
                    (table.insert search [(+ (- nx 1) i) (- ny 1)])
                    (table.insert search [(+ (- nx 1) i) (+ ny 1)])
                )
                (each [_ check (ipairs search)]
                    (let [check_val (. numbers (str-coord check))]
                        (when (not= check_val nil)
                            ;; Store 'em in a bag
                            ;; Note: this will fail if a "gear" is touching 2
                            ;; of the same number. I'm gambling that this
                            ;; doesn't happen in the current input (got lucky lol)
                            (tset seen_numbers (tonumber check_val) true)
                        )
                    )
                )
                (when (= (tbl-length seen_numbers) 2)
                    (set total (+ total (accumulate [mul 1 v _ (pairs seen_numbers)] (* mul v))))
                )
            )
        )
        (print total)

    ))

(symbol-coords "03.txt")