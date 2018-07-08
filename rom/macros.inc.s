.macro          A16                     ;; enable 16-bit accumulator
                rep #%00100000
                .a16
.endmacro

.macro          A8                      ;; enable 8-bit accumulator
                sep #%00100000
                .a8
.endmacro

.macro          AX16                    ;; enable 16-bit accumulator and index registers
                rep #%00110000
                .a16
                .i16
.endmacro

.macro          AX8                     ;; enable 8-bit accumulator and index registers
                sep #%00110000
                .a8
                .i8
.endmacro
