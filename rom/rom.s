                .setcpu "65816"

                .segment "VECTORS"

                .word   main
                .word   main
                .word   main

LCD_INST = $800000
LCD_DATA = $800001

                .code

main:           clc
                xce                     ;; enable the native mode
                jsr lcdinit
main0:          ldx #$0
print:          lda _hello,x
                jsr lcdprint
                inx
                cpx #12  
                bne print                
                jsr lcdclear              
                jmp main0

; *** Wait for LCD busy bit to clear
; registers preserved
lcdbusy:        pha
lcdbusy0:       lda LCD_INST
                and #$80
                bne lcdbusy0
                pla
                rts

; *** LCD initialization
lcdinit:        ldx #$04
lcdinit0:       lda #$38
                sta LCD_INST
                jsr lcdbusy
                dex
                bne lcdinit0
                lda #$06
                sta LCD_INST
                jsr lcdbusy
                lda #$0E
                sta LCD_INST
                jsr lcdbusy
                lda #$01
                sta LCD_INST
                jsr lcdbusy
                lda #$80
                sta LCD_INST
                jsr lcdbusy
                rts

; *** Clear LCD display and return cursor to home
; registers preserved
lcdclear:       pha
                lda #$01
                sta LCD_INST
                jsr lcdbusy
                lda #$80
                sta LCD_INST
                jsr lcdbusy
                pla
                rts

; *** Print character on LCD (40 character)
; registers preserved
lcdprint:       pha
                sta LCD_DATA
                jsr lcdbusy
                lda LCD_INST
                and #$7F
                cmp #$14
                bne lcdprint0
                lda #$C0
                sta LCD_INST
                jsr lcdbusy
lcdprint0:      pla
                rts

_hello:         .byte "Hello World!"
