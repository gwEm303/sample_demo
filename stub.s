;
; Daft Punk Sample Demo
;
; 2026
; Gareth Morris / gwEm
;

        OUTPUT  .PRG
        comment HEAD=%111       ; bit0=ttram(mem) bit1=ttram(prg) bit2=fastload

        opt     o+              ; optimisations on
        opt     CHKPC           ; make sure PC relative code

;................................................................
        include main3buf.s
