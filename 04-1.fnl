
(fn parse-card [line]
    ; (print (line:match "Card%s+(%d+):(.*) | (.*)"))
    (let [win_nums {} (_card win_str have_str) (line:match "Card%s+(%d+):(.*) | (.*)")]
        (each [num (win_str:gmatch "%d+")]
            (tset win_nums num true)
        )
        (var out 0)
        (each [num (have_str:gmatch "%d+")]
            (let [have (. win_nums num)]
                (when (= have true)
                    (print num)
                    (if 
                        (= out 0) (set out 1)
                        (set out (* out 2))
                    )
                )
            )
        )
        (print _card out)
        out
    )
)

(print (accumulate [sum 0 line (io.lines "04.txt")] (+ sum (parse-card line))))