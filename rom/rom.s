                .setcpu "65816"

                .include "dp.inc.s"
                .include "lcd.inc.s"

                .segment "NATIVE_VECTORS"

                .res    2               ;; reserved
                .res    2               ;; reserved
                .res    2               ;; COP
                .res    2               ;; BRK
                .res    2               ;; ABORTB
                .res    2               ;; NMIB
                .res    2               ;; reserved
                .word   irq             ;; native mode IRQB

                .segment "EMU_VECTORS"

                .res    2               ;; reserved
                .res    2               ;; reserved
                .res    2               ;; COP
                .res    2               ;; reserved
                .res    2               ;; ABORTB
                .res    2               ;; NMIB
                .word   reset           ;; emulation mode RESETB
                .res    2               ;; emulation mode IRQB

                .code

irq:            pha
                lda #'b'
                sta lcd_arg0
                pla
                rti

reset:          jmp main

main:           sei                     ;; disable interrupts during init

                clc
                xce                     ;; enable the native mode

                jsr lcd_init
                lda #'a'
                sta lcd_arg0

                cli                     ;; enable interrupts

main0:          jsr lcd_clear
                lda lcd_arg0
                jsr lcd_printc
                jmp main0
