                .setcpu "65816"

                .include "vectors.inc.s"

                .code

main:           sei                     ;; disable interrupts during init

                clc
                xce                     ;; enable the native mode

                cli                     ;; enable interrupts

main0:          jmp main0
