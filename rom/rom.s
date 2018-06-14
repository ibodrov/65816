        .setcpu "65816"

        .segment "VECTORS"

        .word   main
        .word   main
        .word   main

        .code

main:   clc
        xce                     ;; enable the native mode
        lda #%00000000

loop:   sta $800000
        inc
        jmp loop
