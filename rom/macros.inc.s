.macro          longa                   ;; enable 16-bit accumulator
                rep #%00100000
.endmacro

.macro          shorta                  ;; enable 8-bit accumulator
                sep #%00100000
.endmacro

.macro          longr                   ;; enable 16-bit accumulator and index registers
                rep #%00110000
.endmacro

.macro          shortr                  ;; enable 8-bit accumulator and index registers
                sep #%00110000
.endmacro
