// Hex to Decimal (0-65535) conversion
// by Omegamatrix
// (and modified for use with xkas-plus for a Ninja Gaiden II hack)
// https://forums.nesdev.org/viewtopic.php?p=130363#p130363
// HexToDec99      37 cycles
// HexToDec255     52-57 cycles
// HexToDec999     72-77 cycles
// HexToDec65535   157-162 cycles

// HexToDec99
//  start in A
//  end with A = 10's, decOnes

// HexToDec255
//  start in A
//  end with decHund = 100's, A = 10's, decOnes

// HexToDec999
//  start with A = high byte, X = low byte
//  end with decHund = 100's, A = 10's, decOnes
//  requires 1 extra temp register on top of decOnes, could combine
//  these two if HexToDec65535 was eliminiated...

// HexToDec65535
//  start with A = high byte, X = low byte
//  end with decTenThou, decThou, decHund = 100's, A = 10's, decOnes
//  requires 2 extra temp registers on top of decTenThou, decThou, decOnes



// define decThou     {tmp9}
// define decHund     {tmpA}
// define decOnes     {tmpB}
// define decTenThou  $6ff

define hexHigh  {tmpC}
define hexLow   {tmpD}

Mult24Tab:
    db $00,$18,$30,$48,$60,$78,$90,$a8,$c0,$d8
    db $f0,$09,$21,$39,$51,$69,$81,$99,$b1,$c9
    db $e1,$f9,$12,$2a,$42,$5a,$72,$8a,$a2,$ba
    db $d2,$ea,$03,$1b,$33,$4b,$63,$7b,$93,$ab
    db $c3,$db,$f3,$0c,$24,$3c,$54,$6c,$84,$9c
    db $b4,$cc,$e4,$fc,$15,$2d,$45,$5d,$75,$8d
    db $a5,$bd,$d5,$ed,$06,$1e

Mod100Tab:
    db 0,56,12,56+12

ShiftedBcdTab:
    db $00,$01,$02,$03,$04,$08,$09,$0a,$0b,$0c
    db $10,$11,$12,$13,$14,$18,$19,$1a,$1b,$1c
    db $20,$21,$22,$23,$24,$28,$29,$2a,$2b,$2c
    db $30,$31,$32,$33,$34,$38,$39,$3a,$3b,$3c
    db $40,$41,$42,$43,$44,$48,$49,$4a,$4b,$4c

HexToDec65535: // subroutine
    sta  {hexHigh}          //3  @9
    stx  {hexLow}           //3  @12
    tax                     //2  @14
    lsr                     //2  @16
    lsr                     //2  @18   integer divide 1024 (result 0-63)

    cpx  #$a7               //2  @20   account for overflow of multiplying 24 from 43,000 ($A7F8) onward,
    adc  #0                 //2  @22   we can just round it to $A700, and the divide by 1024 is fine...
    tay                     //2  @24
    lda  Mult24Tab+1,y      //4  @28   could use LAX...
    tax                     //2  @30
    and  #$f8               //2  @32
    adc  {hexLow}           //3  @35
    txa                     //2  @37
    and  #$07               //2  @39
    adc  {hexHigh}          //3  @42
    ror                     //2  @44
    lsr                     //2  @46
    tay                     //2  @48   integer divide 1,000 (result 0-65)

    lsr                     //2  @50   split the 1,000 and 10,000 digit
    tax                     //2  @52
    lda  ShiftedBcdTab,x    //4  @56
    tax                     //2  @58
    rol                     //2  @60
    and  #$0f               //2  @62
    sta  {decThou}          //3  @65

    // txa                   //2  @67    // Scumtron: don't need this part for now
    // lsr                   //2  @69    // $b01 (2817) should be the max we'll deal with
    // lsr                   //2  @71
    // lsr                   //2  @73
    // sta  decTenThou       //3  @76

  //at this point we have a number 0-65 that we have to times by 24,
  //add to original sum, and Mod 1024 to get the remainder 0-999

    lda  Mult24Tab,y        //4  @80   could use LAX...
    tax                     //2  @82
    and  #$f8               //2  @84
    clc                     //2  @86
    adc  {hexLow}           //3  @89
    sta  {decOnes}          //3  @92
    txa                     //2  @94
    adc  {hexHigh}          //3  @97
Start100s:
    and  #$03               //2  @99
    tax                     //2  @101   0,1,2,3
    cmp  #2                 //2  @103
    rol                     //2  @105   0,2,5,7
    tay                     //2  @107   Y = Hundreds digit

    lda  {decOnes}          //3  @110
    adc  Mod100Tab,x        //4  @114  adding remainder of 256, 512, and 256+512 (all mod 100)
    bcs  try200.doSub200    //2³ @116/117

try200:
    cmp  #200               //2  @118
    bcc  .try100            //2³ @120/121
.doSub200:
    iny                     //2  @122
    iny                     //2  @124
    sbc  #200               //2  @126
.try100:
    cmp  #100               //2  @128
    bcc  HexToDec99         //2³ @130/131
    iny                     //2  @132
    sbc  #100               //2  @134
HexToDec99: // subroutine
    lsr                     //2  @136
    tax                     //2  @138
    lda  ShiftedBcdTab,x    //4  @142
    tax                     //2  @144
    rol                     //2  @146
    and  #$0f               //2  @148
    sta  {decOnes}          //3  @151
    txa                     //2  @153
    lsr                     //2  @155
    lsr                     //2  @157
    lsr                     //2  @159
    sty  {decHund}      //Scumtron: want it to return with Y ready to be restored
    rts                     //6  @165   A = tens digit

HexToDec255: // subroutine
    ldy  #0                 //2  @8
    beq  try200             //3  @11    always branch

// HexToDec999: // subroutine
    // stx  {decOnes}          //3  @9
    // jmp  Start100s          //3  @12