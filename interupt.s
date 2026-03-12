;
; Daft Punk Sample Demo
;
; 2026
; Gareth Morris / gwEm
;

;................................................................
timerC:     movem.l d0-d7/a0-a6,-(sp)
            lea     state(pc),a0            ; a0 points to our state
            tst.w   count200(a0)            ; do we need to parse the next sequence line?
            bne.s   .end

            move.l  seqAddr(a0),a1          ; a1 points to the next sequence line
            cmpi.w  #-1,ticks(a1)           ; final line?
            beq.s   .stop

            cmpi.w  #-2,ticks(a1)           ; repeat?
            bne.s   .playSample
            move.l  sampleOff(a1),a1

.playSample:bsr.s   playSample

            move.w  ticks(a1),count200(a0)  ; how many ticks do we need to wait for the next line?
            lea     seqLineLen(a1),a1       ; find and store address of next sequence line
            move.l  a1,seqAddr(a0)
            bra.s  .end

.stop:      move.b  #0,$ffff8901.w
            move.w  #1,finished(a0)
.end:       subq.w  #1,count200(a0)
            movem.l (sp)+,d0-d7/a0-a6
            move.l  oldTc(pc),-(sp)         ; go to old vector (system friendly ;) )
            rts

            RSRESET
count200:   rs.w    1
seqAddr:    rs.l    1
finished:   rs.w    1
stateLen:   rs.w    0

state:      ds.b    stateLen

;................................................................
; a1 = pointer to sequence line
playSample: move.w  sampleNum(a1),d1
            mulu.w  #samInfoLen,d1
            lea     sampleInfo(pc),a2
            lea     (a2,d1.w),a2
            move.l  samAddr(a2),a2
            add.l   sampleOff(a1),a2

            move.l  a2,d0                   ; buffer start
            move.b  d0,$ffff8907.w
            lsr.w   #8,d0
            move.b  d0,$ffff8905.w
            swap    d0
            move.b  d0,$ffff8903.w

            add.l   sampleLen(a1),a2        ; buffer end
            move.l  a2,d0
            move.b  d0,$ffff8913.w
            lsr.w   #8,d0
            move.b  d0,$ffff8911.w
            swap    d0
            move.b  d0,$ffff890f.w

            move.b  soundMode(a1),$ffff8921.w
            move.b  #0,$ffff8901.w          ; toggle replay (DMA control)
            move.b  dmaControl(a1),$ffff8901.w
            rts
