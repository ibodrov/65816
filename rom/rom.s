                .setcpu "65816"

                .include "macros.inc.s"
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

                .smart

                .code

irq:            longa
                pha                
                lda #_bye
                sta lcd_arg0            ;; save the pointer to _bye into lcd_arg0                
                pla
                rti

reset:          jmp main

main:           sei                     ;; disable interrupts during init

                clc
                xce                     ;; enable the native mode

                jsr lcd_init

                longa
                lda #_hello
                sta lcd_arg0            ;; save the pointer to _hello into lcd_arg0
                shorta

                cli                     ;; enable interrupts

main0:          jsr lcd_clear
                jsr lcd_prints
                jmp main0

_hello:         .byte "Hello!", $0
_bye:           .byte "Bye!", $0
