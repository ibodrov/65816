                .setcpu "65816"

                .include "dp.inc.s"

                .export lcd_init
                .export lcd_clear
                .export lcd_prints

LCD_INST = $800000
LCD_DATA = $800001

                .code

; *** Wait for LCD busy bit to clear
; registers preserved
lcd_busy:       pha
lcd_busy0:      lda LCD_INST
                and #$80
                bne lcd_busy0
                pla
                rts

; *** LCD initialization
lcd_init:       ldx #$04
lcd_init0:      lda #$38
                sta LCD_INST
                jsr lcd_busy
                dex
                bne lcd_init0
                lda #$06
                sta LCD_INST
                jsr lcd_busy
                lda #$0E
                sta LCD_INST
                jsr lcd_busy
                lda #$01
                sta LCD_INST
                jsr lcd_busy
                lda #$80
                sta LCD_INST
                jsr lcd_busy
                rts

; *** Clear LCD display and return cursor to home
; registers preserved
lcd_clear:      pha
                lda #$01
                sta LCD_INST
                jsr lcd_busy
                lda #$80
                sta LCD_INST
                jsr lcd_busy
                pla
                rts

; *** Print a character on LCD (40 character)
; registers preserved
lcd_print:      pha
                sta LCD_DATA
                jsr lcd_busy
                lda LCD_INST
                and #$7F
                cmp #$14
                bne lcd_print0
                lda #$C0
                sta LCD_INST
                jsr lcd_busy
lcd_print0:     pla
                rts

; *** Prints a null-terminated string on LCD
; registers are NOT preserved
; lcd_arg0 - address of the string, 16bit
; requires .a8
lcd_prints:     ldy #$0
lcd_prints0:    lda (lcd_arg0),Y
                beq lcd_prints1
                jsr lcd_print
                iny
                jmp lcd_prints0
lcd_prints1:    rts
