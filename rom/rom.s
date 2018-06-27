                .setcpu "65816"

                .include "dp.inc.s"
                .include "lcd.inc.s"

                .segment "VECTORS"

                .word   nmi
                .word   reset
                .word   irq

                .code

nmi:            jmp nmi_handler
reset:          jmp main
irq:            jmp irq_handler

main:           clc
                xce                     ;; enable the native mode

                cli                     ;; enable interrupts

                jsr lcd_init
                
check_int:      lda irq_hit
                bne do_int

                jsr lcd_clear                
                rep #$20
                .a16
                lda #_ok
                sta lcd_arg0
                sep #$20
                .a8
                jsr lcd_prints

                jmp check_int

do_int:         jsr lcd_clear                
                rep #$20
                .a16
                lda #_interrupt
                sta lcd_arg0
                sep #$20
                .a8
                jsr lcd_prints

                stz irq_hit             ;; reset the irq hit counter

                jmp check_int

nmi_handler:    rti

irq_handler:    pha
                lda #$01
                sta irq_hit
                pla
                rti

_ok:            .byte "..", $0
_interrupt:     .byte "!!", $0
