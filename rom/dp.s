                .setcpu "65816"

                .include "dp.inc.s"

                .zeropage

lcd_arg0:       .res 2
irq_hit:        .res 1