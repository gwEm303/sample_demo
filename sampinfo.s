;
; Daft Punk Sample Demo
;
; 2026
; Gareth Morris / gwEm
;

;................................................................
            RSRESET
samFileName:rs.b    16  ; this must be the first item for the sample loading routine to work
samAddr:    rs.l    1
samBuffer:  rs.w    1
samFileSiz: rs.l    1
samFileHan: rs.w    1
samInfoLen: rs.w    0

                    ;1234567890123456789012345678901234567890
sampleInfo: dc.b    "a:\sample0.kal",0
            ds.b    samAddr-15
            ds.l    1
            dc.w    -1
            dc.l    SAMPLE0LEN/2
            ds.w    1

            dc.b    "a:\sample1.kal",0
            ds.b    samAddr-15
            ds.l    1
            dc.w    -1
            dc.l    SAMPLE1LEN/2
            ds.w    1

            dc.b    "a:\sample2.kal",0
            ds.b    samAddr-15
            ds.l    1
            dc.w    -1
            dc.l    SAMPLE2LEN/2
            ds.w    1

            dc.b    "a:\sample3.kal",0
            ds.b    samAddr-15
            ds.l    1
            dc.w    -1
            dc.l    SAMPLE3LEN/2
            ds.w    1

            dc.b    "a:\sample4.kal",0
            ds.b    samAddr-15
            ds.l    1
            dc.w    -1
            dc.l    SAMPLE4LEN/2
            ds.w    1

            dc.b    "a:\sample5.kal",0
            ds.b    samAddr-15
            ds.l    1
            dc.w    -1
            dc.l    SAMPLE5LEN/2
            ds.w    1

            dc.b    "a:\sample6.kal",0
            ds.b    samAddr-15
            ds.l    1
            dc.w    -1
            dc.l    SAMPLE6LEN/2
            ds.w    1

            dc.b    "a:\sample7.kal",0
            ds.b    samAddr-15
            ds.l    1
            dc.w    -1
            dc.l    SAMPLE7LEN/2
            ds.w    1

            dc.b    "a:\sample8.kal",0
            ds.b    samAddr-15
            ds.l    1
            dc.w    -1
            dc.l    SAMPLE8LEN/2
            ds.w    1

            dc.b    "a:\sample9.kal",0
            ds.b    samAddr-15
            ds.l    1
            dc.w    -1
            dc.l    SAMPLE9LEN/2
            ds.w    1

            dc.b    "a:\sample10.kal",0
            ds.b    samAddr-16
            ds.l    1
            dc.w    -1
            dc.l    SAMPLE10LEN/2
            ds.w    1

            dc.b    "a:\sample11.kal",0
            ds.b    samAddr-16
            ds.l    1
            dc.w    -1
            dc.l    SAMPLE11LEN/2
            ds.w    1

            dc.b    "a:\sample12.kal",0
            ds.b    samAddr-16
            ds.l    1
            dc.w    -1
            dc.l    SAMPLE12LEN/2
            ds.w    1

            dc.b    "a:\sample13.kal",0
            ds.b    samAddr-16
            ds.l    1
            dc.w    -1
            dc.l    SAMPLE13LEN/2
            ds.w    1

            dc.b    "a:\sample14.kal",0
            ds.b    samAddr-16
            ds.l    1
            dc.w    -1
            dc.l    SAMPLE14LEN/2
            ds.w    1

            dc.b    "a:\sample15.kal",0
            ds.b    samAddr-16
            ds.l    1
            dc.w    -1
            dc.l    SAMPLE15LEN/2
            ds.w    1

            dc.b    "a:\sample16.kal",0
            ds.b    samAddr-16
            ds.l    1
            dc.w    -1
            dc.l    SAMPLE16LEN/2
            ds.w    1

            dc.b    "a:\sample17.kal",0
            ds.b    samAddr-16
            ds.l    1
            dc.w    -1
            dc.l    SAMPLE17LEN/2
            ds.w    1

            dc.b    "a:\sample18.kal",0
            ds.b    samAddr-16
            ds.l    1
            dc.w    -1
            dc.l    SAMPLE18LEN/2
            ds.w    1

            dc.b    "a:\sample19.kal",0
            ds.b    samAddr-16
            ds.l    1
            dc.w    -1
            dc.l    SAMPLE19LEN/2
            ds.w    1

            dc.b    "a:\sample20.kal",0
            ds.b    samAddr-16
            ds.l    1
            dc.w    -1
            dc.l    SAMPLE20LEN/2
            ds.w    1

            dc.b    "a:\sample21.kal",0
            ds.b    samAddr-16
            ds.l    1
            dc.w    -1
            dc.l    SAMPLE21LEN/2
            ds.w    1

            dc.b    "a:\sample22.kal",0
            ds.b    samAddr-16
            ds.l    1
            dc.w    -1
            dc.l    SAMPLE22LEN/2
            ds.w    1

            dc.b    "a:\sample23.kal",0
            ds.b    samAddr-16
            ds.l    1
            dc.w    -1
            dc.l    SAMPLE23LEN/2
            ds.w    1

            dc.b    "a:\sample24.kal",0
            ds.b    samAddr-16
            ds.l    1
            dc.w    -1
            dc.l    SAMPLE24LEN/2
            ds.w    1

            dc.b    "a:\sample25.kal",0
            ds.b    samAddr-16
            ds.l    1
            dc.w    -1
            dc.l    SAMPLE25LEN/2
            ds.w    1

            dc.b    "a:\sample26.kal",0
            ds.b    samAddr-16
            ds.l    1
            dc.w    -1
            dc.l    SAMPLE26LEN/2
            ds.w    1

            dc.b    "a:\sample27.kal",0
            ds.b    samAddr-16
            ds.l    1
            dc.w    -1
            dc.l    SAMPLE27LEN/2
            ds.w    1
sampleInfoEnd:

NUMSAMPLES  equ     (sampleInfoEnd-sampleInfo)/samInfoLen
