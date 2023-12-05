
(fn parse-card [line]
    ; (print (line:match "Card%s+(%d+):(.*) | (.*)"))
    (let [win_nums {} (card win_str have_str) (line:match "Card%s+(%d+):(.*) | (.*)")]
        (each [num (win_str:gmatch "%d+")]
            (tset win_nums num true)
        )
        (var total 0)
        (each [num (have_str:gmatch "%d+")]
            (let [have (. win_nums num)]
                (when (= have true)
                    (set total (+ total 1))
                )
            )
        )
        total
    )
)
(local cards [])
(local point_cache {})
; Load up # wins / card
(each [line (io.lines "04.txt")] (table.insert cards (parse-card line)))
(fn ccollect [index]
    (let [cached (. point_cache index)]
        (if (not= cached nil) cached
        (let [num_wins (. cards index)]
            (if 
                (= num_wins nil) 0
                ( let []  ;Don't now how to do multi statement elses lol no curly braces
                    (var total 1)
                    (for [i index (+ index (- num_wins 1))]
                        (set total (+ total (ccollect (+ 1 i))))
                    )
                    (tset point_cache index total)
                    total
                )
            )
        )
    )
))
(print (accumulate [sum 0 i j (ipairs cards)] (+ sum (ccollect i))))

;; In hindsight, going backwards through the file lines would have made this likely
;; easier. But I got my answer and it's almost midnight, so marking as DONE