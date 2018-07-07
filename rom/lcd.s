                .setcpu "65816"

                .include "dp.inc.s"

                .export lcd_init
                .export lcd_clear
                .export lcd_printc
                .export lcd_prints

_LCD_INST = $800000
_LCD_DATA = $800001

                .code

; *** Wait for LCD busy bit to clear
; registers are preserved
lcd_busy:       pha
lcd_busy0:      lda _LCD_INST
                and #$80
                bne lcd_busy0
                pla
                rts

; *** LCD initialization
; registers are NOT preserved
lcd_init:       ldx #$04
lcd_init0:      lda #$38
                sta _LCD_INST
                jsr lcd_busy
                dex
                bne lcd_init0
                lda #$06
                sta _LCD_INST
                jsr lcd_busy
                lda #$0E
                sta _LCD_INST
                jsr lcd_busy
                lda #$01
                sta _LCD_INST
                jsr lcd_busy
                lda #$80
                sta _LCD_INST
                jsr lcd_busy
                rts

; *** Clear LCD display and return cursor to home
; registers are preserved
lcd_clear:      pha
                lda #$01
                sta _LCD_INST
                jsr lcd_busy
                lda #$80
                sta _LCD_INST
                jsr lcd_busy
                pla
                rts

; *** Print a character on LCD (40 character)
; registers are preserved
lcd_printc:     pha
                sta _LCD_DATA
                jsr lcd_busy
                lda _LCD_INST
                and #$7F
                cmp #$14
                bne lcd_printc0
                lda #$C0
                sta _LCD_INST
                jsr lcd_busy
lcd_printc0:    pla
                rts

; *** Prints a null-terminated string on LCD
; registers are NOT preserved
; lcd_arg0 - address of the string, 16bit
; requires .a8
lcd_prints:     ldy #$0
lcd_prints0:    lda (lcd_arg0),Y
                beq lcd_prints1
                jsr lcd_printc
                iny
                jmp lcd_prints0
lcd_prints1:    rts
