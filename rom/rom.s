                .setcpu "65816"
                .include "dp.inc.s"
                .include "lcd.inc.s"

                .segment "VECTORS"

                .word   main
                .word   main
                .word   main

                .code

                .smart

main:           clc
                xce                     ;; enable the native mode
                jsr lcd_init

                rep #$20
                lda #_hello
                sta LCD_ARG0
                sep #$20
main0:          jsr lcd_prints
                jsr lcd_clear
                jmp main0

_hello:         .byte "Hello World!", $0
