;
; Daft Punk Sample Demo
;
; 2026
; Gareth Morris / gwEm
;

            section text
;................................................................
            include tos.s

            ; initialisation
top:        lea     state(pc),a2                ; load the start address of the sample sequence
            lea     top(pc),a1                  ;
            add.l   #sequence-top,a1            ;
            move.l  a1,seqAddr(a2)              ;

            bsr     adpcmInitTables             ; initialise Kalms ADPCM

            ; load and unpack first sample so we can get going
            lea     sequence(pc),a1             ; a1 points to song sequence
            move.w  sampleNum(a1),d0            ; d0 holds the first sample number
            mulu.w  #samInfoLen,d0              ; get offset into sample info table
            lea     sampleInfo(pc),a3           ;
            add.w   d0,a3                       ; a3 points to the first sample in the sample info table

            moveq.w #0,d7                       ; d7.w holds buffer number
            lea     packedBuf(pc),a4            ;
            add.l   #unpackBuf0-packedBuf,a4    ; a4 points to position in unpack buffer
            lea     packedBuf(pc),a5            ;
            add.l   #unpackBuf0end-packedBuf,a5 ; a5 points to end of unpack buffer

            bsr     loadSample                  ; returns unpacked length in d0.l
            add.l   d0,a4                       ; increment unpacked buffer location
            lea     seqLineLen(a1),a1           ; increment song postition

            ; install interrupt
            lea     stealingStr(pc),a0
            bsr.s   cconws
            lea     oldTc(pc),a0                ; store old timer C vector
            move.l  $114.w,(a0)                 ;
            lea     timerC(pc),a0               ; steal timer C
            move.l  a0,$114.w                   ;

            ; remaining samples
            lea     sequenceEnd(pc),a0          ; a0 holds sequence end point
                                                ; a1 holds current sequence address
                                                ; a2 points to playback state
.unpack:    bsr     checkExit                   ; leave early if we have a key press
            tst.l   d0                          ;
            bne     .deinit                     ;

            move.w  sampleNum(a1),d0            ; d0 holds the sample number
            mulu.w  #samInfoLen,d0              ; get offset into sample info table
            lea     sampleInfo(pc),a3           ;
            add.w   d0,a3                       ; a3 points to the sample info table entry

            ; d7.w = buffer number
            ; a3   = sample info
            ; a4   = unpacked buffer position
            ; a5   = unpacked buffer end
            bsr     loadSample
            tst.l   d0
            bge     .noBufSwap

.doBufSwap: tst.w   d7
            bne.s   .oneToZero

.zeroToOne: move.l  endOfBuf1(pc),d3
            cmp.l   seqAddr(a2),d3
            ble.s   .buf1Load

            move.l  a0,-(sp)
            lea     waitPlayBuffer1Str(pc),a0
            bsr     cconws
            move.l  (sp)+,a0

.wait1:     bsr     checkExit                   ; leave early if we have a key press
            tst.l   d0                          ;
            bne     .deinit                     ;
            cmp.l   seqAddr(a2),d3
            bge.s   .wait1

.buf1Load:  lea     endOfBuf0(pc),a3
            move.l  a1,(a3)

            moveq.w #1,d7
            bsr     clearBuf
            lea     packedBuf(pc),a4            ;
            add.l   #unpackBuf1-packedBuf,a4    ; a4 points to position in unpack buffer
            lea     packedBuf(pc),a5            ;
            add.l   #unpackBuf1end-packedBuf,a5 ; a5 points to end of unpack buffer
            bra.s   .unpack

.oneToZero: move.l  endOfBuf0(pc),d3
            cmp.l   seqAddr(a2),d3
            ble.s   .buf0Load

            move.l  a0,-(sp)
            lea     waitPlayBuffer0Str(pc),a0
            bsr     cconws
            move.l  (sp)+,a0

.wait0:     bsr.s   checkExit                   ; leave early if we have a key press
            tst.l   d0                          ;
            bne.s   .deinit                     ;
            cmp.l   seqAddr(a2),d3
            bge.s   .wait0

.buf0Load:  lea     endOfBuf1(pc),a3
            move.l  a1,(a3)

            moveq.w #0,d7
            bsr.s   clearBuf
            lea     packedBuf(pc),a4            ;
            add.l   #unpackBuf0-packedBuf,a4    ; a4 points to position in unpack buffer
            lea     packedBuf(pc),a5            ;
            add.l   #unpackBuf0end-packedBuf,a5 ; a5 points to end of unpack buffer
            bra     .unpack

.noBufSwap: add.l   d0,a4                       ; increment unpacked buffer location
            lea     seqLineLen(a1),a1           ; increment song postition
            cmpa.l  a0,a1
            blt     .unpack

            ; loaded all the samples
            lea     loadedAllStr(pc),a0
            bsr     cconws

            ; wait for end of track
            lea     state(pc),a0
.waitKey:   bsr.s   checkExit                   ; unpacking done so just wait for key press
            tst.l   d0                          ;
            beq.s   .waitKey                    ;

            ; deinitialisation
.deinit:    lea     exitingStr(pc),a0
            bsr     cconws
            move.l  oldTc(pc),$114.w            ; restore timer C
            bra     tosDeinit

oldTc:      ds.l    1
endOfBuf0:  ds.l    1
endOfBuf1:  ds.l    1

;................................................................
; returns 0 in d0.l if we continue
checkExit:  movem.l d1-d2/a0-a2,-(sp)
            moveq.l #0,d0
            lea     state(pc),a0
            tst.w   finished(a0)                ; we also exit if the sequence is finished
            beq.s   .checkKey                   ;
            moveq.w #-1,d0
    		movem.l	(sp)+,d1-d2/a0-a2
            rts

.checkKey   movem.l	(sp)+,d1-d2/a0-a2
            bra     crawio

;................................................................
; d7.w = buffer number (0 or 1)
clearBuf:   movem.l d0/a0,-(sp)
            lea     sampleInfo(pc),a0

            move.w  #NUMSAMPLES-1,d0
.loop       cmp.w   samBuffer(a0),d7
            bne.s   .end

            move.w  #-1,samBuffer(a0)

.end        lea     samInfoLen(a0),a0
            dbra    d0,.loop

            movem.l (sp)+,d0/a0
            rts

;................................................................
; load packed sample and unpack
; d7.w = buffer number (0 or 1)
; a3   = sample info (assume file name is first item, samFileName=0)
; a4   = unpacked buffer start
; a5   = unpacked buffer end
;
; returns unpacked size in d0.l
loadSample: movem.l d1-d4/a0-a6,-(sp)

            cmp.w   samBuffer(a3),d7
            beq     .alreadyLoaded

            move.l  samFileSiz(a3),d3       ; d3 holds file size
            move.l  d3,d4
            add.l   d4,d4                   ; d4 unpacked sample size
            move.l  a4,a6
            add.l   d4,a6                   ; a6 contains potential end of buffer after unpacking
            cmpa.l  a5,a6                   ; could we unpack this sample?
            bgt     .bufferfull

            lea     loadingStr(pc),a0       ; print debug output to console
            bsr     cconws                  ;
            lea     3+samFileName(a3),a0    ;
            bsr     cconws                  ;
            lea     intoBufferStr(pc),a0    ;
            bsr     cconws                  ;
            move.w  d7,d0                   ;
            add.w   #'0',d0                 ;
            bsr     cconout                 ;
            lea     newlineStr(pc),a0       ;
            bsr     cconws                  ;

            move.w  #0,-(sp)                ; read only access
            move.l  a3,-(sp)                ;
            move.w  #$3d,-(sp)              ; GEMDOS fopen()
            trap    #1                      ;
            addq.l  #8,sp                   ; fix stack
            lea     fileHandle(pc),a1       ;
            move.w  d0,(a1)                 ;
            bmi     error                   ; if some kind of error exit

            pea     packedBuf(pc)           ;
            move.l	d3,-(sp)                ;
            move.w	fileHandle(pc),-(sp)    ;
            move.w	#$3f,-(sp)              ; GEMDOS fread()
            trap	#1                      ;
            lea     12(sp),sp               ; fix stack
            tst.l   d0                      ; error?
            bmi     error                   ;

            move.w  fileHandle(pc),-(sp)    ;
            move.w  #$3e,-(sp)              ; GEMDOS fclose()
            trap    #1                      ;
            addq.l  #4,sp                   ; fix stack

            lea     packedBuf(pc),a0        ; packed buffer
            move.l  a4,a1                   ; unpacked buffer
            move.l  d4,d0                   ;
            bsr     adpcmDecoder            ;

            move.l  a4,samAddr(a3)          ; store sample address
            move.w  d7,samBuffer(a3)        ; store sample buffer

.end        movem.l (sp)+,d1-d4/a0-a6
            rts

.alreadyLoaded
;            lea     alreadyLoadedStr(pc),a0 ; print debug output to console
;            bsr     cconws                  ;
;            lea     3+samFileName(a3),a0    ;
;            bsr     cconws                  ;
;            lea     newlineStr(pc),a0       ;
;            bsr     cconws                  ;
            moveq   #0,d0                   ; nothing unpacked
            bra.s   .end

.bufferfull lea     bufferFullStr(pc),a0    ; print debug output to console
            bsr     cconws                  ;
            lea     3+samFileName(a3),a0    ;
            bsr     cconws                  ;
            lea     newlineStr(pc),a0       ;
            bsr     cconws                  ;
            moveq   #-1,d0                  ; switch buffer
            bra.s   .end

fileHandle: ds.w    1

;................................................................
            include adpcm.s                 ; Kalms ADPCM
            include interupt.s


            section data
;................................................................
stealingStr:dc.b    "stealing timer C",13,10,0
exitingStr: dc.b    "exiting",13,10,0
loadedAllStr:
            dc.b    "finished loading samples",13,10,0
alreadyLoadedStr:
            dc.b    "already loaded ",0
bufferFullStr:
            dc.b    "buffer too full to load ",0
waitPlayBuffer0Str:
            dc.b    "waiting for buffer 0 to finish playing",13,10,0
waitPlayBuffer1Str:
            dc.b    "waiting for buffer 1 to finish playing",13,10,0
loadingStr: dc.b    "loading ",0
intoBufferStr:
            dc.b    " into buffer ",0
newlineStr: dc.b    13,10,0
            even

            include sampinfo.s
            include samplens.s
            include sequence.s


            section bss
;................................................................
packedBuf:  ds.b    BIGGESTLEN/2
            even

unpackBuf0: ds.b    452356                  ; assembles to ~962946 bytes which runs on a 1MB TOS1.62 machine in the auto folder
unpackBuf0end:

unpackBuf1: ds.b    unpackBuf0end-unpackBuf0
unpackBuf1end:

;................................................................
            end
