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
top:        lea     state(pc),a0                ; load the start address of the sample sequence
            lea     top(pc),a1                  ;
            add.l   #sequence-top,a1            ;
            move.l  a1,seqAddr(a0)              ;

            bsr     adpcmInitTables             ; initialise Kalms ADPCM

            ; first sample
            lea     sampleInfo(pc),a3           ; load and unpack first sample so we can get going
            lea     packedBuf(pc),a4            ;
            add.l   #unpackedBuf-packedBuf,a4   ;
            bsr.s   loadSample                  ; returns unpacked length in d0.l
            add.l   d0,a4                       ; increment unpacked buffer location
            lea     samInfoLen(a3),a3           ;

            ; install interrupt
            lea     stealingStr(pc),a0
            bsr.s   cconws
            lea     oldTc(pc),a0                ; store old timer C vector
            move.l  $114.w,(a0)                 ;
            lea     timerC(pc),a0               ; steal timer C
            move.l  a0,$114.w                   ;

            ; remaining samples
            moveq   #NUMSAMPLES-2,d3            ; unpack other samples
.unpack:    bsr.s   crawio                      ; leave early if we have a key press
            tst.l   d0                          ;
            bne.s   .deinit                     ;

            bsr.s   loadSample
            add.l   d0,a4                       ; increment unpacked buffer location
            lea     samInfoLen(a3),a3           ;
            dbra    d3,.unpack

            lea     loadedAllStr(pc),a0
            bsr     cconws

            ; wait
            lea     state(pc),a0
.waitKey:   bsr.s   crawio                      ; unpacking done so just wait for key press
            tst.l   d0                          ;
            bne.s   .deinit                     ;
            tst.w   finished(a0)                ; we also exit if the sequence is finished
            beq.s   .waitKey                    ;

            ; deinitialisation
.deinit:    lea     exitingStr(pc),a0
            bsr     cconws
            move.l  oldTc(pc),$114.w            ; restore timer C
            bra     tosDeinit

oldTc:      ds.l    1

;................................................................
; load packed sample and unpack
; a3 = sample info (assume file name is first item, samFileName=0)
; a4 = unpacked buffer
;
; returns unpacked size in d0.l
loadSample: movem.l d1-d3/a0-a2,-(sp)

            move.l  samFileSiz(a3),d3           ; d3 holds file size

            lea     loadingStr(pc),a0           ; print debug output to console
            bsr     cconws                      ;
            lea     3+samFileName(a3),a0        ;
            bsr     cconws                      ;
            lea     newlineStr(pc),a0           ;
            bsr     cconws                      ;

            move.w  #0,-(sp)                    ; read only access
            move.l  a3,-(sp)                    ;
            move.w  #$3d,-(sp)                  ; GEMDOS fopen()
            trap    #1                          ;
            addq.l  #8,sp                       ; fix stack
            lea     fileHandle(pc),a1           ;
            move.w  d0,(a1)                     ;
            bmi     error                       ; if some kind of error exit

            pea     packedBuf(pc)               ;
            move.l	d3,-(sp)                    ;
            move.w	fileHandle(pc),-(sp)        ;
            move.w	#$3f,-(sp)                  ; GEMDOS fread()
            trap	#1                          ;
            lea     12(sp),sp                   ; fix stack
            tst.l   d0                          ; error?
            bmi     error                       ;

            move.w  fileHandle(pc),-(sp)        ;
            move.w  #$3e,-(sp)                  ; GEMDOS fclose()
            trap    #1                          ;
            addq.l  #4,sp                       ; fix stack

            move.l  a4,samAddr(a3)              ; store sample address

            lea     packedBuf(pc),a0            ; packed buffer
            move.l  a4,a1                       ; unpacked buffer
            move.l  d3,d0                       ;
            add.l   d0,d0                       ; we double in size after unpacking
            bsr.s   adpcmDecoder                ;

.end		movem.l	(sp)+,d1-d3/a0-a2
            rts

fileHandle: ds.w    1

;................................................................
            include adpcm.s                     ; Kalms ADPCM
            include interupt.s


            section data
;................................................................
stealingStr:dc.b    "stealing timer C",13,10,0
exitingStr: dc.b    "exiting",13,10,0
loadedAllStr:
            dc.b    "loaded all samples",13,10,0
loadingStr: dc.b    "loading file ",0
newlineStr: dc.b    13,10,0
            even

            include sampinfo.s
            include samplens.s
            include sequence.s


            section bss
;................................................................
packedBuf:  ds.b    BIGGESTLEN/2
            even

unpackedBuf:ds.b    SAMPLE0LEN
            ds.b    SAMPLE1LEN
            ds.b    SAMPLE2LEN
            ds.b    SAMPLE3LEN
            ds.b    SAMPLE4LEN
            ds.b    SAMPLE5LEN
            ds.b    SAMPLE6LEN
            ds.b    SAMPLE7LEN
            ds.b    SAMPLE8LEN
            ds.b    SAMPLE9LEN
            ds.b    SAMPLE10LEN
            ds.b    SAMPLE11LEN
            ds.b    SAMPLE12LEN
            ds.b    SAMPLE13LEN
            ds.b    SAMPLE14LEN
            ds.b    SAMPLE15LEN
            ds.b    SAMPLE16LEN
            ds.b    SAMPLE17LEN
            ds.b    SAMPLE18LEN
            ds.b    SAMPLE19LEN
            ds.b    SAMPLE20LEN
            ds.b    SAMPLE21LEN
            ds.b    SAMPLE22LEN
            ds.b    SAMPLE23LEN
            ds.b    SAMPLE24LEN
            ds.b    SAMPLE25LEN
            ds.b    SAMPLE26LEN
            ds.b    SAMPLE27LEN

;................................................................
            end
