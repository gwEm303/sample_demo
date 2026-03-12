;
; Daft Punk Sample Demo
;
; 2026
; Gareth Morris / gwEm
;

;................................................................
            RSRESET
ticks:      rs.w    1
sampleNum:  rs.w    1
sampleOff:  rs.l    1
sampleLen:  rs.l    1
dmaControl: rs.b    1
soundMode:  rs.b    1
seqLineLen: rs.w    0

sequence:   ;.... FILTERED INTRO
            dc.w    BARTICKS
            dc.w    0
            dc.l    0, SAMPLE0LEN/2
            dc.b    3, %10000001                ; loop, mono, 12517Hz

            dc.w    BARTICKS
            dc.w    0
            dc.l    0, SAMPLE0LEN
            dc.b    1, %10000001                ; one-shot, mono, 12517Hz

            dc.w    BARTICKS
            dc.w    0
            dc.l    0, SAMPLE0LEN/2
            dc.b    3, %10000001

            dc.w    BARTICKS
            dc.w    0
            dc.l    0, SAMPLE0LEN
            dc.b    1, %10000001

            dc.w    BARTICKS
            dc.w    0
            dc.l    0, SAMPLE0LEN/2
            dc.b    3, %10000001

            dc.w    BARTICKS
            dc.w    0
            dc.l    0, SAMPLE0LEN
            dc.b    1, %10000001

            dc.w    BARTICKS+(5*BARTICKS/8)
            dc.w    1
            dc.l    0, SAMPLE1LEN
            dc.b    3, %10000001

            dc.w    3*BARTICKS/8
            dc.w    0
            dc.l    5*SAMPLE0LEN/8, 3*SAMPLE0LEN/8
            dc.b    1, %10000001

            dc.w    BARTICKS
            dc.w    0
            dc.l    0, SAMPLE0LEN/2
            dc.b    3, %10000001

            dc.w    BARTICKS
            dc.w    0
            dc.l    0, SAMPLE0LEN
            dc.b    1, %10000001

            dc.w    BARTICKS
            dc.w    0
            dc.l    0, SAMPLE0LEN/2
            dc.b    3, %10000001

            dc.w    BARTICKS
            dc.w    0
            dc.l    0, SAMPLE0LEN
            dc.b    1, %10000001

            dc.w    BARTICKS
            dc.w    0
            dc.l    0, SAMPLE0LEN/2
            dc.b    3, %10000001

            dc.w    BARTICKS
            dc.w    0
            dc.l    0, SAMPLE0LEN
            dc.b    1, %10000001

            dc.w    BARTICKS+(BARTICKS/2)
            dc.w    1
            dc.l    0, SAMPLE1LEN
            dc.b    3, %10000001

            dc.w    BARTICKS/2                  ; "one more t..."
            dc.w    2
            dc.l    0, SAMPLE2LEN
            dc.b    1, %10000001

            ;.... MEDIUM BEAT
            dc.w    BARTICKS/2                  ; "...ime" (medium beat starts)
            dc.w    3
            dc.l    0, SAMPLE3LEN
            dc.b    1, %10000010                ; one-shot, mono, 25033Hz

            dc.w    BARTICKS/2
            dc.w    4
            dc.l    0, SAMPLE4LEN
            dc.b    1, %10000010

            dc.w    BARTICKS
            dc.w    4
            dc.l    0, SAMPLE4LEN
            dc.b    1, %10000010

            dc.w    BARTICKS
            dc.w    4
            dc.l    0, SAMPLE4LEN/2
            dc.b    3, %10000010

            dc.w    BARTICKS
            dc.w    4
            dc.l    0, SAMPLE4LEN
            dc.b    1, %10000010

            dc.w    BARTICKS
            dc.w    4
            dc.l    0, SAMPLE4LEN/2
            dc.b    3, %10000010

            dc.w    BARTICKS
            dc.w    4
            dc.l    0, SAMPLE4LEN
            dc.b    1, %10000010

            dc.w    BARTICKS+(BARTICKS/2)
            dc.w    5
            dc.l    0, SAMPLE5LEN
            dc.b    3, %10000010

            dc.w    BARTICKS/2                  ; "one more t..."
            dc.w    6
            dc.l    0, SAMPLE6LEN
            dc.b    1, %10000010

            ;.... BIG BEAT
            dc.w    BARTICKS/2                  ; "...ime" (big beat)
            dc.w    7
            dc.l    0, SAMPLE7LEN
            dc.b    1, %10000010

            dc.w    BARTICKS/2
            dc.w    8
            dc.l    0, SAMPLE8LEN
            dc.b    1, %10000010

            dc.w    BARTICKS
            dc.w    8
            dc.l    0, SAMPLE8LEN
            dc.b    1, %10000010

            dc.w    BARTICKS
            dc.w    8
            dc.l    0, SAMPLE8LEN/2
            dc.b    3, %10000010

            dc.w    BARTICKS
            dc.w    8
            dc.l    0, SAMPLE8LEN
            dc.b    1, %10000010

            dc.w    BARTICKS
            dc.w    8
            dc.l    0, SAMPLE8LEN/2
            dc.b    3, %10000010

            dc.w    BARTICKS
            dc.w    8
            dc.l    0, SAMPLE8LEN
            dc.b    1, %10000010

            dc.w    BARTICKS+(5*BARTICKS/8)
            dc.w    1
            dc.l    0, SAMPLE1LEN
            dc.b    3, %10000001

            dc.w    3*BARTICKS/8
            dc.w    0
            dc.l    5*SAMPLE0LEN/8, 3*SAMPLE0LEN/8
            dc.b    1, %10000001

            ;.... SINGING
            dc.w    BARTICKS/4                  ; 1/4 of a bar to cover up vocal overspill
            dc.w    8
            dc.l    0, SAMPLE8LEN
            dc.b    1, %10000010

            dc.w    (BARTICKS*2)-(BARTICKS/4)   ; singing starts
            dc.w    9
            dc.l    SAMPLE8LEN/4, SAMPLE9LEN
            dc.b    1, %10000010

            dc.w    BARTICKS*2
            dc.w    10
            dc.l    0, SAMPLE10LEN
            dc.b    1, %10000010

            dc.w    BARTICKS*2
            dc.w    9
            dc.l    0, SAMPLE9LEN
            dc.b    1, %10000010

            dc.w    BARTICKS*2
            dc.w    10
            dc.l    0, SAMPLE10LEN
            dc.b    1, %10000010

            dc.w    BARTICKS*2
            dc.w    9
            dc.l    0, SAMPLE9LEN
            dc.b    1, %10000010

            dc.w    BARTICKS*2
            dc.w    10
            dc.l    0, SAMPLE10LEN
            dc.b    1, %10000010

            dc.w    BARTICKS*2
            dc.w    9
            dc.l    0, SAMPLE9LEN
            dc.b    1, %10000010

            dc.w    BARTICKS*2                  ; "oh yeah one more t..." (beat stops)
            dc.w    11
            dc.l    0, SAMPLE11LEN
            dc.b    1, %10000010

            dc.w    BARTICKS/2                  ; "...ime"
            dc.w    7
            dc.l    0, SAMPLE7LEN
            dc.b    1, %10000010

            dc.w    BARTICKS/2
            dc.w    8
            dc.l    0, SAMPLE8LEN
            dc.b    1, %10000010

            dc.w    BARTICKS
            dc.w    8
            dc.l    0, SAMPLE8LEN
            dc.b    1, %10000010

            dc.w    BARTICKS
            dc.w    8
            dc.l    0, SAMPLE8LEN/2
            dc.b    3, %10000010

            dc.w    BARTICKS
            dc.w    8
            dc.l    0, SAMPLE8LEN
            dc.b    1, %10000010

            dc.w    BARTICKS
            dc.w    8
            dc.l    0, SAMPLE8LEN/2
            dc.b    3, %10000010

            dc.w    BARTICKS
            dc.w    8
            dc.l    0, SAMPLE8LEN
            dc.b    1, %10000010

            dc.w    BARTICKS+(5*BARTICKS/8)
            dc.w    12
            dc.l    0, SAMPLE12LEN
            dc.b    3, %10000010

            dc.w    3*BARTICKS/8
            dc.w    8
            dc.l    5*SAMPLE8LEN/8, 3*SAMPLE8LEN/8
            dc.b    1, %10000010

            ;.... THIN BEAT
            dc.w    BARTICKS*2                  ; "one more time we're going to celebrate"
            dc.w    13
            dc.l    0, SAMPLE13LEN
            dc.b    1, %10000010

            dc.w    BARTICKS*2
            dc.w    14
            dc.l    0, SAMPLE14LEN
            dc.b    1, %10000010

            dc.w    BARTICKS/2
            dc.w    15
            dc.l    0, SAMPLE15LEN
            dc.b    1, %10000010

            dc.w    BARTICKS+(BARTICKS/2)
            dc.w    13
            dc.l    SAMPLE15LEN, SAMPLE13LEN
            dc.b    1, %10000010

            dc.w    BARTICKS+(BARTICKS/2)
            dc.w    14
            dc.l    0, SAMPLE14LEN
            dc.b    1, %10000010

            dc.w    BARTICKS/2
            dc.w    16
            dc.l    0, SAMPLE16LEN
            dc.b    1, %10000010

            ;.... BREAKDOWN
            dc.w    BARTICKS*4                  ; breakdown, 12kHz
            dc.w    17
            dc.l    0, SAMPLE17LEN
            dc.b    1, %10000001

            dc.w    BARTICKS*4
            dc.w    18
            dc.l    0, SAMPLE18LEN
            dc.b    1, %10000001

            dc.w    BARTICKS*8                  ; "one more time.. one more time!"
            dc.w    19
            dc.l    0, SAMPLE19LEN
            dc.b    3, %10000001

            dc.w    BARTICKS*8                  ; "musics got me feeling so free we're gonna celebrate, celebrate and dance for free"
            dc.w    20
            dc.l    0, SAMPLE20LEN
            dc.b    3, %10000001

            dc.w    BARTICKS*2                  ; beat builds up (11 bars)
            dc.w    21
            dc.l    0, SAMPLE21LEN
            dc.b    1, %10000010

            dc.w    BARTICKS*2
            dc.w    22
            dc.l    0, SAMPLE22LEN
            dc.b    1, %10000010

            dc.w    BARTICKS*2
            dc.w    21
            dc.l    0, SAMPLE21LEN
            dc.b    1, %10000010

            dc.w    BARTICKS*2
            dc.w    22
            dc.l    0, SAMPLE22LEN
            dc.b    1, %10000010

            dc.w    BARTICKS*2
            dc.w    21
            dc.l    0, SAMPLE21LEN
            dc.b    1, %10000010

            dc.w    BARTICKS
            dc.w    22
            dc.l    0, SAMPLE22LEN/2
            dc.b    1, %10000010

            dc.w    BARTICKS                    ; "one more t..." (beat stops)
            dc.w    11
            dc.l    SAMPLE11LEN/2, SAMPLE11LEN/2
            dc.b    1, %10000010

            ;.... REPRISE
            dc.w    BARTICKS*2                  ; beat kicks back in
            dc.w    23
            dc.l    0, SAMPLE23LEN
            dc.b    1, %10000010

            dc.w    BARTICKS*2
            dc.w    24
            dc.l    0, SAMPLE24LEN
            dc.b    1, %10000010

            dc.w    BARTICKS*2
            dc.w    25
            dc.l    0, SAMPLE25LEN
            dc.b    1, %10000010

            dc.w    BARTICKS*2
            dc.w    26
            dc.l    0, SAMPLE26LEN
            dc.b    1, %10000010

            dc.w    BARTICKS/4
            dc.w    27
            dc.l    0, SAMPLE27LEN
            dc.b    1, %10000010

            dc.w    BARTICKS+(3*BARTICKS/4)
            dc.w    23
            dc.l    SAMPLE27LEN, SAMPLE23LEN
            dc.b    1, %10000010

            dc.w    BARTICKS*2
            dc.w    24
            dc.l    0, SAMPLE24LEN
            dc.b    1, %10000010

            dc.w    BARTICKS*2
            dc.w    25
            dc.l    0, SAMPLE25LEN
            dc.b    1, %10000010

            dc.w    BARTICKS*2                  ; "yeah one more t..." beat stopping
            dc.w    11
            dc.l    0, SAMPLE11LEN
            dc.b    1, %10000010

            dc.w    BARTICKS*2                  ; "...ime" beat kicks back in
            dc.w    23
            dc.l    0, SAMPLE23LEN
            dc.b    1, %10000010

            dc.w    BARTICKS*2
            dc.w    24
            dc.l    0, SAMPLE24LEN
            dc.b    1, %10000010

            dc.w    BARTICKS*2
            dc.w    25
            dc.l    0, SAMPLE25LEN
            dc.b    1, %10000010

            dc.w    BARTICKS*2
            dc.w    26
            dc.l    0, SAMPLE26LEN
            dc.b    1, %10000010

            dc.w    BARTICKS/4
            dc.w    27
            dc.l    0, SAMPLE27LEN
            dc.b    1, %10000010

            dc.w    BARTICKS+(3*BARTICKS/4)
            dc.w    23
            dc.l    SAMPLE27LEN, SAMPLE23LEN
            dc.b    1, %10000010

            dc.w    BARTICKS*2
            dc.w    24
            dc.l    0, SAMPLE24LEN
            dc.b    1, %10000010

            dc.w    BARTICKS*2
            dc.w    25
            dc.l    0, SAMPLE25LEN
            dc.b    1, %10000010

            dc.w    BARTICKS
            dc.w    26
            dc.l    0, SAMPLE26LEN
            dc.b    1, %10000010

            dc.w    5*BARTICKS/8
            dc.w    12
            dc.l    0, SAMPLE12LEN
            dc.b    3, %10000010

            dc.w    3*BARTICKS/8
            dc.w    8
            dc.l    5*SAMPLE8LEN/8, 3*SAMPLE8LEN/8
            dc.b    1, %10000010
sequenceEnd:
            dc.w    -1                      ; final step
            dc.w    0
            dc.l    0, 0
            dc.b    0, 0
