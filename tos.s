;
; Daft Punk Sample Demo
;
; 2026
; Gareth Morris / gwEm
;

;................................................................
tosInit:    move.l  4(sp),a5                ; address to basepage
            move.l  $0c(a5),d0              ; length of text segment
            add.l   $14(a5),d0              ; length of data segment
            add.l   $1c(a5),d0              ; length of bss segment
            add.l   #$1000,d0               ; length of stackpointer
            add.l   #$100,d0                ; length of basepage
            move.l  a5,d1                   ; address to basepage
            add.l   d0,d1                   ; end of program
            and.l   #-2,d1                  ; make address even
            move.l  d1,sp                   ; new stackspace

            move.l  d0,-(sp)                ;
            move.l  a5,-(sp)                ;
            move.w  d0,-(sp)                ;
            move.w  #$4a,-(sp)              ; mshrink()
            trap    #1                      ; GEMDOS
            lea     12(sp),sp               ; fix stack

            move.l  #0,-(sp)                ;
            move.w  #$20,-(sp)              ; super()
            trap    #1                      ; GEMDOS
            addq.l  #6,sp                   ; fix stack
            lea     oldUsp(pc),a0           ;
            move.l  d0,(a0)                 ; store old user stack pointer

            move.b  #0,$ffff8901.w          ; DMA replay off (DMA control)

            lea     oldConterm(pc),a0       ; store old keyclick
            move.b  $484.w,(a0)             ;
            move.b  #0,$484.w               ; turn off keyclick
            bra.s   top

tosDeinit:  move.b  #0,$ffff8901.w          ; DMA replay off (DMA control)
            move.b  oldConterm(pc),$484.w   ; restore keyclick

            move.l  oldUsp(pc),-(sp)        ; switch back to user mode
            move.w  #$20,-(sp)              ; super()
            trap    #1                      ; GEMDOS
            addq.l  #6,sp                   ; fix stack

            move.w  #0,-(sp)                ;
            move.w  #$4c,-(sp)              ; pterm()
            trap    #1                      ; GEMDOS

oldUsp:     ds.l    1
oldConterm: ds.b    1
            even

;................................................................
cconout:    movem.l d0-d2/a0-a2,-(sp)
            move.w  d0,-(sp)                ; push character
            move.w  #2,-(sp)                ; cconout()
            trap    #1                      ; GEMDOS
            addq.l  #4,sp                   ; fix stack
    		movem.l	(sp)+,d0-d2/a0-a2
            rts

cconws:     movem.l d0-d2/a0-a2,-(sp)
            move.l  a0,-(sp)                ; push address of string
            move.w  #9,-(sp)                ; cconws()
            trap    #1                      ; GEMDOS
            addq.l  #6,sp                   ; fix stack
    		movem.l	(sp)+,d0-d2/a0-a2
            rts

;................................................................
; returns 0 in d0.l if no key pressed
crawio:     movem.l d1-d2/a0-a2,-(sp)
            move.w  #$00FF,-(sp)            ; wait for a key
            move.w  #6,-(sp)                ; crawio()
            trap    #1                      ; GEMDOS
            addq.l  #4,sp                   ; fix stack
    		movem.l	(sp)+,d1-d2/a0-a2
            rts

;................................................................
error:      illegal                         ; 4 bombs if something went wrong
