// xkas-plus v14+1 May 16, 2015  https://github.com/devinacker/xkas-plus

// Ninja Gaiden II practice hack v0.6
arch nes.cpu
header
banksize $2000


define buttons       $12
define new_buttons   $13
define ppu_tran_flag $16
define scrn_sub      $39
define scrn_pix      $3a
define scrn_hi       $3b
define current_block $40
define boss_fight    $4d  // $10 = true
define pause_flag    $52
define sub_wep       $7d
define level         $7e
define ryu_hp        $80
define nme_hp        $81
define wall_right    $9d
define wall_left     $9e
define max_ninpo     $af
define inv           $bf  // debug invulnerability flag. $80 = true
define tally_flag    $d0

define ppu_buffer    $03f0
define bg_collision  $04c0
define x_pos_hi      $0550
define x_pos_lo      $0538
define y_pos_lo      $0568
define bossHP        $060f
define sound_buffer  $0700

// stock unused zp: $3c,$74..$7c,$90,$91,$9a,$b3,$b5,$d4..$d7
// new or changed variables
define mark $3c  // block that the game will auto-pause at to display frame count
define bgct $74  // saves ryu's background collision state on room exit
define mrk0 $75  // marker msd
define mrk1 $76  // marker lsd
define xpos $0077  // 
define swrd $90  // temp variable to track whether boss was killed with sword or up+b
define brpt $91  // boss refill toggle. $80 = true
define ppu0 $9a  // ppu addr lo for static markers
define fc1  $a1  // 4 bytes. left frame count. duration in frames of current room.
define xsbt $b3  // saves ryu's x_pos_lo on room exit
define ysbt $b5  // saves ryu's y_pos_lo on room exit
define fc2  $d4  // 4 bytes. right frame count. duration in frames of previous room/attempt

// some PRG addresses
define lvl_transition_info $8240
define hud_update          $96cc  // Y = which update, 0..6 valid (originally)
define get_weapon          $9810  // A = new weapon, 0..4 valid
define red_ninpo           $9863
define get_scroll          $9876
define get_clone           $98c9
define Wait_for_vblank     $9bd9
define get_block           $c739
define cs_exit             $c74e
define go_back             $c799
define go_forward          $c7a2
define go_forward_alt      $c7a8
define game_over_reload    $c8e7
define nme_alive_swd       $cad1
define nme_alive_upB       $cb94
define Boss_kill           $ccba
define Load_level          $ced2
define Musicruise          $d76a


/////////////////////////////////////////////////////////////////////////////////////
bank $01
org $a13c                  // rom 2146 pc 01:a13c

levelskip:; lda #$00
            sta {boss_fight}
            sta {tally_flag}
            lda #$10
            sta {nme_hp}
            jsr FCUpdate
            jmp {go_forward_alt}


PauseOptions:              // assume A = new_buttons here
            bit {buttons}
            bmi Aright
            bvs Bright
retA:;      rts

Bright:;    lsr
            bcc Bleft
            lda {level}    // next lvl
            cmp #$2f       // don't go past 7-5
            bcs retA
            inc {level}
            bpl levelskip

Bleft:;     lsr
            bcc Bdown
            lda {level}    // prev lvl
            beq retA       // and don't go below 1-1a
            dec {level}
            bpl levelskip

Bdown:;     lsr
            bcc Bup
            jsr RestoreRyuState  // reload lvl & fill hp
            lda #$10
            sta {ryu_hp}
            sta {nme_hp}
            cmp {boss_fight}
            beq levelskip
            jsr FCUpdate
            jmp {Load_level}

Bup:;       lsr
            bcc Bselect
            lda {current_block}  // set marker/clear if equal
            beq retA
            cmp {mark}
            beq clrMark
            bne setMark

Bselect:;   lsr #2
            bcc retA
clrMark:;   lda #$00       // clear marker
setMark:;   sta {mark}
            php
            ldx #$23
            stx {ppu0}
            plp
            bne +
            ldy #$03
            bpl hud_upd
+;          ldy #$00
            // jsr {HexDisplay}
            // bmi Hud_Mark
            beq Hexdisp


Aright:;    lsr
            bcc Aleft
            lda {max_ninpo}  // get scroll (100 cap)
            cmp #$64
            bcs retB
            jmp {get_scroll}

Aleft:;     lsr
            bcc Adown
            jsr {red_ninpo}-5  // get clone, fill ninpo
            jmp {get_clone}

Adown:;     lsr
            bcc Aup
            lda #$9e       // boss refill toggle
            sta {ppu0}
            lda {brpt}
            eor #$80
            sta {brpt}
            // bmi soundA
            // bpl soundB
            bpl bfalse
            ldy #$02
            bpl +
bfalse:;    ldy #$03
+;          bpl hud_upd

Aup:;       lsr
            bcc ABSelect
            ldx {sub_wep}  // change weapon, fill ninpo
            cpx #$04
            beq z
            inx
            txa
            bpl +
z:;         lda #$00
+;          jsr {get_weapon}
            jsr {red_ninpo}
            lda #$23
            bpl sound

ABSelect:;  bit {buttons}
            bvc Aselect
            lsr #2
            bcc retB
            jmp {game_over_reload}  // try and fix buggy level or state load

Aselect:;   lsr #2
            bcc retB
            lda #$7e       // toggle invulnerability
            sta {ppu0}
            lda {inv}
            eor #$80
            sta {inv}
            bpl ifalse
            ldy #$01
            bpl hud_upd
ifalse:;    ldy #$03
hud_upd:;   bpl Hud_Mark

soundA:;    lda #$22
            bpl sound
soundB:;    lda #$21
sound:;     sta {sound_buffer}
retB:;      rts


Hexdisp:;   tax
            and #$0f
            cmp #$0b
            bcc +
            adc #$36
+;          sta {mrk0}
            txa
            lsr #4
            cmp #$0b
            bcc +
            adc #$36
+;          sta {mrk1}
            cpy #$00
            beq Hud_Mark
            rts

Hud_Mark:;  lda #$23
            sta $03f1           // ppu addr hi
            lda {ppu0}
            sta $03f2           // ppu addr lo

            ldx hud_end0,y
            lda #$00
            sta {ppu_buffer},x  // $00 terminator

            lda hudsize0,y
            sta {ppu_buffer}    // size

            ldx hud_offs,y
            bpl static
            lda {mrk0}
            sta $03f4
            lda {mrk1}
            sta $03f3
            bpl +
            // bmi done
static:;    tay
-;          lda hud_mark,x
            sta $03f2,y         // ppu data
            inx; dey
            bne -
+;          lda #$80
            sta {ppu_tran_flag}
done:;      rts

// 00 marker indicator       $3c mark, $77,$78
// 01 invuln. indicator      $bf inv
// 02 boss refill indicator  $91 brpt
// 03 clear

hud_mark:; db $3f,$3f,$5f,$5f
           //  00  01  02  03  04  05
hudsize0:; db $02,$01,$01,$02,$00,$00
hud_offs:; db $ff,$02,$03,$00,$00,$00
hud_end0:; db $05,$04,$04,$05,$00,$00
// hud_ppu0:; db $23,$7e,$9e,$00,$00,$00

DoMarks:;   ldx {mark}     // if invuln/boss-refill/marker are set
            beq +          // and a game over or cutscene happens
            lda #$23       // this will keep their hud indicators
            ldy #$00       // from getting erased.
            jsr do1
+;          ldx {inv}
            beq +
            lda #$7e
            ldy #$01
            jsr do1
+;          ldx {brpt}
            beq +
            lda #$9e
            ldy #$02
do1:;       sta {ppu0}
            jsr Hud_Mark
            jsr {Wait_for_vblank}
+;          rts


HexdispL:;  lda {x_pos_lo}
            ldy #$00
            beq HexdispB
HexdispH:;  lda {x_pos_hi}
HexdispB:;  tax
            and #$0f
            cmp #$0b
            bcc +
            adc #$36
+;          sta {xpos},y
            txa
            iny
            lsr #4
            cmp #$0b
            bcc +
            adc #$36
+;          sta {xpos},y
            iny
            lda {ppu_buffer}
            rts


/////////////////////////////////////////////////////////////////////////////////////
bank $04
// 00 fc1
// 01 fc2
// 02 max ninpo
// 03 ninpo
// 04 level timer
// 05 screen x
// 06 ryu x
// 07 player bar
// 08 enemy bar

org $86af  // relocated hud update data to make room for more things
           // 00  01  02  03  04  05  06  07  08  09  0a  0b  0c
hudsize:; db $04,$04,$02,$03,$03,$04,$04,$08,$08
hud_ram:; db $00,$33,$05,$07,$0a,$d6,$d6, // 2 bytes fewer: hp bars don't use this.
hud_ppu:; db $49,$50,$89,$85,$69,$90,$70,$76,$96
hud_end:; db $07,$07,$05,$06,$06,$07,$07,$0b,$0b


org $96c8; ldy #$08        // 
org $96d3; lda hud_ppu,y
org $96d9; ldx hud_end,y
org $96e1; lda hudsize,y
org $96e7; cpy #$05
           bcs Xdisplay
           bcc nums
bars:;     cpy #$08
org $9717
nums:;     ldx hud_ram,y

org $9729
Xdisplay:; cpy #$06
           bcc screenx
           ldx {ryu_hp}
           cpy #$07
           bcs bars
ryux:;     jsr HexdispL
           jsr HexdispH
           ldy #$06
           bpl nums
screenx:;  rts

// change lives hud updates to 2nd frame counter
// don't need this anymore
// org $972a; db $04         // character count to transmit
// org $9731; db $33         // RAM offset from $a1
// org $9736; db $50         // ppu_addr_lo
// org $973d; db $07         // update size (offset to write 0 byte to terminate)

org $9d68; db $60,$ea     // RTS and NOP from Add_points  (this gets jumped to a lot)


/////////////////////////////////////////////////////////////////////////////////////
bank $0c
org $aaaf; db $01         // cut out that awful racket after a boss kill


/////////////////////////////////////////////////////////////////////////////////////
bank $0e
org $c69f; jmp cutScene   // after score tally, copy & reset fc before cutscene
org $c71d; jmp ExitCheck  // handle frame counts on level exit (not enough room here)
org $c7b2; db $00         // don't fade out music on stage change (simplest way to deal with level skip messing with music)
org $c85e; jsr DeathFCU   // copy & reset frame count on death
org $cabb; jmp swordKill  // boss kill with sword attack
org $cba7; jmp upBee      // boss kill with up+b attack
// org $cd36; jsr $dc37      // enable level select
org $ce3e; jsr $e31e      // hijack jsr $9903 for hud marker handling after gameover or cutscene
org $ce5c; db $24,$14,$0a,$10                      // SCOR -> FRAM
org $ce66; db $3f,$18,$3f,$00,$00,$00,$00,$3f,$3f  // 00_STAGE -> _-_0000__
org $ce97; fill 6, $3f    // erase NINJA
org $cea8; fill 6, $3f    // erase ENEMY
org $d734; cmp #$30  // change sound test to Select+Start and go directly to Musicruise
           beq {Musicruise}


/////////////////////////////////////////////////////////////////////////////////////
bank $0f
org $e254; nop #2    // enable pausing during score tally
org $e258; lda #$26  // change suspend sound to sound effect on pause
org $e269; ldx #$00  // change resume sound to no sound
org $e2da; jsr IncFrameCount  // hijack jsr $953a to do frame counter stuff
org $e2e0; jsr PauseOptions; nop  // pause option handler
org $e31e; jsr $9903 // indirect hijack because we need to bankswitch first
           jsr DoMarks
           rts

org $efbd                  // rom 1efcd  pc 0f:efbd
SaveRyuState:
            lda {bg_collision}  // oops, forgot slow-mode
            sta {bgct}
            lda {x_pos_lo}
            sta {xsbt}
            lda {y_pos_lo}
            sta {ysbt}
            rts
RestoreRyuState:            // 0f:efcd
            lda {bgct}
            sta {bg_collision}
            lda {xsbt}
            sta {x_pos_lo}
            lda {ysbt}
            sta {y_pos_lo}
            rts
warnpc $eff2+1


org $f445                  // rom 1f455 pc 0f:f445
ExitCheck:; ldx #$02
            lda {wall_right}
-;          cmp #$09
            beq cutScene
            cmp #$07
            beq goBack
            cmp #$06
            beq goForward
            lda {wall_left}
            dex
            bne -
            jmp {get_block}
cutScene:;  jsr LvlExitFCU
            jmp {cs_exit}
goBack:;    jsr LvlExitFCU
            jmp {go_back}
goForward:; jsr LvlExitFCU
            jmp {go_forward}
warnpc $f476+1


org $f476                  // rom 1f486 pc 0f:f476
MarkerCheck:
            ldx {mark}
            beq +
            cpx {current_block}
            bne +
            lda #$80
            sta {pause_flag}
            lda #$55
            sta {sound_buffer}
+;          rts
warnpc $f488+1


org $fbbb                  // rom 1fbcb pc 0f:fbbb
IncFrameCount:
            jsr $953a      // do hijacked routine
            ldy {tally_flag}
            bne reta
            lda #$0a
            ldx #$00
-;          inc {fc1},x
            cmp {fc1},x
            bne +
            sty {fc1},x
            inx
            cpx #$04
            bne -
+;          jsr MarkerCheck
reta:;      rts

LvlExitFCU:
            ldy #$00
            jsr {hud_update}
            jsr SaveRyuState  // save xsub/ysub/bgoll
            jsr FCUpdate
            ldx {level}
            inx
            lda {lvl_transition_info},x
            and #$03
            beq reta
            jmp {Wait_for_vblank}  // insert a frame if lvl uses a fade transition

DeathFCU:;  sta {sound_buffer}
FCUpdate:;  ldy #$00
            ldx #$03
-;          lda {fc1},x
            sta {fc2},x
            sty {fc1},x
            dex
            bpl -
            rts
warnpc $fc00+1


org $ffd1                  // rom 1ffe1 pc 0f:ffd1
swordKill:; lda #$80
            sta {swrd}
upBee:;     bit {brpt}
            bpl unset
            lda #$10
            sta {nme_hp}
            sta {bossHP}
            jsr FCUpdate
            bit {swrd}
            bpl +
            asl {swrd}
            inc {nme_hp}   // sword doesn't remove last bar of health until *after* damage
            jmp {nme_alive_swd}
+;          jmp {nme_alive_upB}
unset:;     asl {swrd}     // swordKill clear
            jmp {Boss_kill}
warnpc $fffa


// CHR ROM //////////////////////////////////////////////////////////////////////////
arch none
org $20010+$410
db $ff,$ff,$ff,$ff,$9c,$80,$9c,$9c,$ff,$e3,$c9,$9c,$ff,$ff,$ff,$ff // A tile $41
db $ff,$ff,$ff,$ff,$81,$9c,$9c,$81,$ff,$81,$9c,$9c,$ff,$ff,$ff,$ff // B
db $ff,$ff,$ff,$ff,$9f,$9f,$c8,$e1,$ff,$e1,$c8,$9f,$ff,$ff,$ff,$ff // C
// db $ff,$ff,$ff,$ff,$9f,$9f,$cc,$e1,$ff,$e1,$cc,$9f,$ff,$ff,$ff,$ff // C, skinny
db $ff,$ff,$ff,$ff,$9c,$9c,$99,$83,$ff,$83,$99,$9c,$ff,$ff,$ff,$ff // D
db $ff,$ff,$ff,$ff,$81,$9f,$9f,$80,$ff,$80,$9f,$9f,$ff,$ff,$ff,$ff // E
db $ff,$ff,$ff,$ff,$81,$9f,$9f,$9f,$ff,$80,$9f,$9f,$ff,$ff,$ff,$ff // F

org $20010+$5f0
db $ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$f7,$f3,$01,$f3,$f7,$ff // arrow
// db $ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$f7,$f3,$01,$f3,$f7,$ff,$ff // arrow, pixel higher
