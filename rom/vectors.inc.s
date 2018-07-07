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
                
irq:            rti

reset:          jmp main
