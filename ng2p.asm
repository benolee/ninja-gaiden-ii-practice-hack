// assemble with xkas-plus v14+1
// https://github.com/devinacker/xkas-plus
// Ninja Gaiden II - The Dark Sword of Chaos (U) [!] practice hack v0.8-ish

arch nes.cpu
header
banksize $2000

//--/////////////////////////////////////////////////////////////////////
define buttons        $12 ; define lvl_width      $7f ; define tmp8 $08
define new_buttons    $13 ; define ryu_hp         $80 ; define tmp9 $09
define scrn_sub       $39 ; define nme_hp         $81 ; define tmpA $0a
define scrn_pix       $3a ; define wall_right     $9d ; define tmpB $0b
define scrn_hi        $3b ; define wall_left      $9e ; define tmpC $0c
define current_block  $40 ; define timer_ones     $ab ; define tmpD $0d
define pause_flag     $52 ; define current_ninpo  $ae ; define tmpE $0e
define sub_wep        $7d ; define max_ninpo      $af ; define tmpF $0f
define level          $7e ; define cs_play        $cb

define tally_flag     $d0   // $80 = tally timer, $40 = tally ninpo
define ppu_flag       $16   // $80 = send ppu_buffer to ppu next nmi
define scroll_flag    $3e   // $40 = scrolling unlocked
define boss_fight     $4d   // $10 = true
define inv            $bf   // debug invulnerability flag. $80 = true

define ppu_buffer     $03f0 ; define y_pos_lo       $0568
define bg_collision   $04c0 ; define y_pos_hi       $0580
define ryu_state      $0520 ; define x_speed_hi     $05b0
define x_pos_lo       $0538 ; define bossHP         $060f
define x_pos_hi       $0550 ; define sound_buffer   $0700

// new or changed variables
// stock unused zp: 
// $3c,$43..$45,$74..$7c,$90,$91,$9a,$b3,$b5,$d4..$d7,$fe,$ff
define mark $3c   // 16 px block that the game will auto-pause at to display frame count
define tmpT $43   // previous timer ones digit ("previous" vars )
define mnpT $44   // previous max ninpo
define npoT $45   // previous ninpo
define bgct $74   // saves ryu's background collision state on room exit
define ryuS $75   // saves ryu's state bitfield on room exit
define xsbt $76   // saves ryu's x_pos_lo on room exit
define ysbt $77   // saves ryu's y_pos_lo on room exit (don't move these 4)
define mrk0 $78   // marker msd
define mrk1 $79   // marker lsd
define fc2T $7a   // frame count 2 update flag
define scfT $7b   // previous scroll_flag
define hOrD $7c   // hexadecimal / decimal display flag, $80 = hex
define rhpT $90   // previous player health
define brpt $91   // boss refill toggle. $80 = true
define fc2  $d4   // 4 bytes. right frame count. duration in frames of previous room/attempt

define updi $a0   // was status_updates_index. unused!
define fc1  $a1   // 4 bytes. left frame count. duration in frames of current room (was score)

// $dc..$ef are never used during gameplay, but are zeroed at each screen transition
// so we're free to use them for variables within a level, or just more registers
define swrd $ef   // temp variable to track whether boss was killed with sword or up+b


// some PRG addresses
// define lvl_change_info    $8240
// define hud_update_old     $96cc   // Y = which update, 0..6 valid (originally)
define get_weapon         $9810   // A = new weapon, 0..4 valid
define red_ninpo          $9863
define get_scroll         $9876
define get_clone          $98c9
define Wait_for_vblank    $9bd9
// define get_block_old      $c739
define cs_exit            $c74e
define go_back            $c799
define go_forward         $c7a2
define go_forward_alt     $c7a8
define Tecmo_Cinema       $c820
define game_over_reload   $c8e7
define nme_alive_swd      $cad1
define nme_alive_upB      $cb94
define Boss_kill          $ccba
define Load_level         $ced2
define Musicruise         $d76a
//++


bank $01
//--/////////////////////////////////////////////////////////////////////
org $a13c                   // unused $5c4 bytes
levelskip:; lda #$00        // $bb bytes used
            sta {boss_fight}
            sta {tally_flag}
            lda #$10
            sta {nme_hp}
            jsr FCUpdate
            jmp {go_forward_alt}

PauseOpts:; bit {buttons}   // A = new_buttons
            bmi Apressed.right
            bvs Bpressed.right
.doneB:;    rts

Bpressed:
.right:;    lsr
            bcc .left
            lda {level}     // next lvl
            cmp #$2f        // don't go past 7-5
            bcs PauseOpts.doneB
            inc {level}
            bpl levelskip

.left:;     lsr
            bcc .down
            lda {level}     // and don't go below 1-1a
            beq PauseOpts.doneB
            dec {level}     // prev lvl
            bpl levelskip

.down:;     lsr
            bcc .up
            jsr RyuState.R  // reload lvl & fill hp
            lda #$10
            sta {ryu_hp}
            sta {nme_hp}
            cmp {boss_fight}
            beq levelskip
            jsr FCUpdate
            jmp {Load_level}

.up:;       lsr
            bcc .select
            lda {current_block} // set marker/clear if equal
            beq PauseOpts.doneB
            cmp {mark}
            beq .clrMark
            bne .setMark

.select:;   lsr #2
            bcc PauseOpts.doneB
.clrMark:;  lda #$00        // clear marker
.setMark:;  sta {mark}
            bne Hexify
            beq Apressed.markit


Apressed:
.right:;    lsr
            bcc .left
            lda {max_ninpo}  // get scroll (100 cap)
            cmp #$64
            bcs Sound.doneA
            jmp {get_scroll}

.left:;     lsr
            bcc .down
            jsr {red_ninpo}-5 // get clone, fill ninpo
            jmp {get_clone}

.down:;     lsr
            bcc .up
            lda {brpt}
            eor #$80
            sta {brpt}
.markit:;   jmp DoMarks
            // bmi Sound
            // bpl Sound.21

.up:;       lsr
            bcc .BSelect
            ldx {sub_wep}   // change weapon, fill ninpo
            cpx #$04
            beq .wrap
            inx
            txa
            bpl +
.wrap:;     lda #$00
+;          jsr {get_weapon}
            jsr {red_ninpo}
            lda #$23
            bpl Sound.set

.BSelect:;  bit {buttons}
            bvc .select
            lsr #2
            bcc Sound.doneA
            jmp {game_over_reload}  // fix buggy level or state load

.select:;   lsr #2
            bcc Sound.doneA
            lda {inv}
            eor #$80
            sta {inv}
.msrkit:;   jmp DoMarks

Sound:;     lda #$22
            bpl .set
.21:;       lda #$21
.set:;      sta {sound_buffer}
.doneA:;    rts

Hexify:;    tay             // $1b bytes used
            and #$0f
            cmp #$0b
            bcc +
            adc #$36
+;          sta {mrk0}
            tya
            lsr #4
            cmp #$0b
            bcc +
            adc #$36
+;          sta {mrk1}
            jmp DoMarks

//++

//-- Update_status_bar replacement
// 00 fc1           04  23 49   07
// 01 fc2           04  23 50   07
// 02 max ninpo     02  23 89   05
// 03 ninpo         03  23 85   06
// 04 level timer   03  23 69   06
// 05 ryu x hex     04  23 71   07
// 06 ryu x dec     05  23 70   08
// 07 screen x hex  05  23 90   08
// 08 screen x dec  06  23 8f   09
// 09 player bar    08  23 76   0b
// 0a enemy bar     08  23 96   0b

// relocated hud update data to make room for displaying more stuff
//            00  01  02  03  04  05  06  07  08  09  0a
hudsize:; db $04,$04,$02,$03,$03,$04,$05,$05,$06,$08,$08
hud_ram:; db $03,$36,$06,$09,$0c  // $26 bytes used
hud_ppu:; db $49,$50,$89,$85,$69,$71,$70,$90,$8f,$76,$96
hud_end:; db $07,$07,$05,$06,$06,$07,$08,$08,$09,$0b,$0b

//                          // $87 bytes used
Hud_update:;asl {ppu_flag}  // make sure it's clear in case of interruption
            ldx #$00        // x reg = index for which element is being updated
            ldy #$00        // y reg = index for ppu_buffer writes
.fc1:;      jsr Status_upd  // $08-$0b = temp registers throughout

.fc2:;      bit {fc2T}
            bpl .Mninpo     // fc2 doesn't belong here, and instead should
            asl {fc2T}      // be updated seperately on lvl change.
            ldx #$01        // Maybe later.
            jsr Status_upd  // Nah, it's fine.

.Mninpo:;   lda {max_ninpo}
            cmp {mnpT}
            beq .ninpo
            sta {mnpT}
            ldx #$02
            jsr Status_upd

.ninpo:;    lda {current_ninpo}
            cmp {npoT}
            beq .timer
            sta {npoT}
            ldx #$03
            jsr Status_upd

.timer:;    lda {timer_ones}
            cmp {tmpT}
            beq .ryux
            sta {tmpT}
            ldx #$04
            jsr Status_upd

.ryux:;     // bit {scfT}   selectively updating this is
            // bvs .scrnx   more trouble than it's worth.
            ldx #$05
            bit {hOrD}
            bmi +
            inx
+;          jsr Status_upd
            jsr PrRyuX

.scrnx:;    bit {scfT}
            bvc .ryuhp
            ldx #$07
            bit {hOrD}
            bmi +
            inx
+;          jsr Status_upd
            jsr PrScrX

.ryuhp:;    lda {ryu_hp}
            cmp {rhpT}
            beq .nmehp
            sta {rhpT}
            ldx #$09
            jsr Status_upd
            ldx {ryu_hp}
            jsr Health_bar  // still using default bar code for now

.nmehp:;    lda {boss_fight}
            beq .done
            ldx #$0a
            jsr Status_upd
            ldx {nme_hp}
            jsr Health_bar  // actually, why change it? it's fine.

            lda #$00
.done:;     sta {ppu_buffer},y
            lda #$80
            sta {ppu_flag}
            lda {scroll_flag}
            sta {scfT}
            rts

define tloop  {tmp8}
define ppuhi  #$23

Status_upd:;lda hudsize,x   // $2a bytes used
            sta {ppu_buffer},y
            sta {tloop}
            iny
            lda {ppuhi}
            sta {ppu_buffer},y
            iny
            lda hud_ppu,x
            sta {ppu_buffer},y
            iny
            cpx #$05
            bcs +
            lda hud_ram,x
            tax
-;          lda {fc1},x
            sta {ppu_buffer},y
            iny; dex; dec {tloop}
            bne -
+;          rts

define decThou  {tmp9}
define decHund  {tmpA}
define decOnes  {tmpB}
define tmpY     {tmp8}

PrRyuX:;    lda {x_pos_hi}  // $2e bytes used
            bit {hOrD}
            bmi .hexi
            sty {tmpY}
            jsr HexToDec255
.deci:;     ldy {tmpY}
            sta {ppu_buffer}+1,y
            lda {decHund}
            bne +
            lda #$3f        // blank if <= 99
+;          sta {ppu_buffer},y
            iny
            iny
            lda {decOnes}
            sta {ppu_buffer},y
            iny
            bpl .done
.hexi:;     jsr Bin2hex
.done:;     lda {x_pos_lo}
            jsr Bin2bar
            rts

PrScrX:;    lda {scrn_hi}   // $39 bytes used
            bit {hOrD}
            bmi .hexi
.deci:;     ldx {scrn_pix}
            sty {tmpY}
            jsr HexToDec65535
            ldy {tmpY}
            sta {ppu_buffer}+2,y
            lda {decThou}
            bne +
            lda #$1f        // blank if <= 999
+;          sta {ppu_buffer},y
            iny
            lda {decHund}
            sta {ppu_buffer},y
            iny
            iny
            lda {decOnes}
            sta {ppu_buffer},y
            iny
            bpl .done
.hexi:;     jsr Bin2hex.lo  // ignore high nybble of scrn_hi: always 0
            lda {scrn_pix}
            jsr Bin2hex
.done:;     lda {scrn_sub}
            jsr Bin2bar
            rts

Bin2hex:;   tax             // $1d bytes used
            lsr #4
            cmp #$0b
            bcc +
            adc #$36
+;          sta {ppu_buffer},y
            txa
            iny
.lo:;       and #$0f
            cmp #$0b
            bcc +
            adc #$36
+;          sta {ppu_buffer},y
            iny
            rts

// represent a sub-pixel value as quarters of a pixel using bars.
// won't give full precision on ice (1/32), but that's fine.
Bin2bar:;   beq .zero       // $2d bytes used
            tax
            bmi .half
.quartL:;   lda #$1a        // 1 set, 1 clear
            sta {ppu_buffer},y
            iny
            lda #$1b
            bpl .once
.half:;     lda #$19        // both set
            sta {ppu_buffer},y
            txa
            iny
.quartR:;   and #$40
            beq +
            lda #$1a
            bpl .once
+;          lda #$1b        // both clear
            bpl .once
.zero:;     lda #$1b
            sta {ppu_buffer},y
            iny
.once:;     sta {ppu_buffer},y
            iny
.done:;     rts

Health_bar:;lda #$08        // $1d bytes used
            sta {tmp8}      // just a copy of the original routine
-;          dex             // X = health
            beq .half
            bmi .empty
            dex
            lda #$19        // 11
            bne .write
.half:;     lda #$1a        // 10
            bne .write
.empty:;    lda #$1b        // 00
.write:;    sta {ppu_buffer},y
            iny
            dec {tmp8}
            bne -
            rts             // $26a bytes FREE

org $a620
incsrc bin2dec.asm          // $e0 bytes used

//++
warnpc $a700+1              // $0 bytes


bank $04
//--/////////////////////////////////////////////////////////////////////

org $81e2; db $c7,$97,$61   // 1-1c, 1-2, 2-1
org $81e7; db $42,$41,$a7   // 2-2c, 2-3, 3-1
org $81ee; db $87,$78       // 3-3e, 3-3
org $81f2; db $6a           // 4-1c
org $81f5; db $67,$87       // 4-2c, 4-3
org $81f8; db $0b,$87       // 5-1b, 5-1c
org $81fc; db $4b,$70,$a8,$a6,$61,$87,$c1  // 5-2c through 6-3
org $8207; db $b3           // 7-1e
org $820c; db $b1,$89,$88,$b5 // 7-2e, 7-3, 7-4, 7-5

// Since the above levels aren't normally revisit-able, they weren't
// assigned spawn positions for Ryu when the revisit flag is set.
// Instead, they default to putting him at x pos. 64, y pos. 8.
// So, if the revisit flag is set by returning to a room and then
// the level skip function (B+L/R) is used, the above edits should
// put Ryu where you might expect him to be.
// Caveats: the game wasn't coded to handle boss spawns when returing
// to a room this way. This may be fixable without screwing with normal
// game operation. There also isn't much choice in precision in placing
// Ryu: the high nybble of the value has 8 added to it and gives y position;
// the low nybble indexes into a list of twelve pre-defined x positions.
// x-pos table offset: 00 01 02 03 04 05 06 07 08 09 0a 0b (@ $d262)
// x-pos table values: 40 DB 3B 20 30 10 28 BB 9B 50 90 80
// Boss fights: tried to give some of them start points for an alternative
// to play with instead of reckoning a "return point." Baron Spider won't
// be spawned by Ryu's movement anyway since the snow comes first on the
// spawn list.
// Additionally, since all the rooms you can normally return to are via
// ladders, Tecmo didn't need to include code to adjust Ryu's facing 
// direction for that circumstance. Probably edit-able without screwing 
// anything up though.

org $86af                   // unused $71 bytes
warnpc $8720+1              // $71 bytes FREE

// org $823f; db $00           // disable palette animation for 7-5
org $946c; ldx #$00         // disable hud shimmer; more time for important stuff!

// old hud_update was here, made redundant or moved elsewhere
// 00 clear 2 tiles
// 01 marker indicator       $3c mark, $78,$79
// 02 invuln. indicator      $bf inv
// 03 boss refill indicator  $91 brpt
// 04 screen x clr   $3e+ $36+ $0d bytes used = $81

org $96c2;                  // $81 bytes
hud_mrk:;  db $1f,$3f,$3f,$3f,$3f,$3f,$5f,$3f
mrk_offs:; db $01,$80,$06,$06,$00
// mrkppulo:; db $ff,$23,$7e,$9e,$8f    // oh, just inline these.

define tloop  {tmp8}
define ppulo  {tmp9}
define ppuhi  #$23

DoMarks:;   ldy #$00        // $3e bytes used
            ldx #$01
            sty {tmpA}
            lda #$23
            sta {ppulo}
            lda {mark}
            jsr .do
            ldx #$02
            lda #$7e
            sta {ppulo}
+;          lda {inv}
            jsr .do
            ldx #$03
            lda #$9e
            sta {ppulo}
            lda {brpt}
            jsr .do
            bit {pause_flag}
            bmi .done       // don't wipe screen x if paused
            lda #$8f
            sta {ppulo}
            ldx #$04
            lda #$06
            jsr .doX
.done:;     lda #$00
            sta {ppu_buffer},y
            lda #$80
            sta {ppu_flag}
            rts

.do:;       bne +           // $36 bytes used
            ldx #$00
+;          lda #$02
.doX:;      sta {ppu_buffer},y
            sta {tloop}
            iny
            lda {ppuhi}
            sta {ppu_buffer},y
            iny
            lda {ppulo}
            sta {ppu_buffer},y
            iny
            lda mrk_offs,x
            bpl .static
-;          lda {mrk0},x    // if we're here, then X = 1
            sta {ppu_buffer},y
            iny
            dex
            bpl -
            bmi +
.static:;   tax
-;          lda hud_mrk,x
            sta {ppu_buffer},y
            iny; inx; dec {tloop}
            bne -
+;          rts             // $00 bytes


org $9d68;  rts             // RTS from Add_points--beats tracking down every JSR and JMP to here
TitleKeys:; cmp #$30        // $29 bytes used
            beq .music      // A = {buttons}
            cmp #$90
            beq .hex
            cmp #$50
            bne .done
.movie:;    inc {cs_play}
            ldx #40         // 40 frame delay for start to be released
-;          jsr {Wait_for_vblank}
            dex
            bne -
            jsr {Tecmo_Cinema}
            clc
            bcc .movie
.music:;    jmp {Musicruise}
.hex:;      lda #$80
            sta {hOrD}
            lda #$58
            sta {sound_buffer}
.done:;     rts

warnpc $9d92+1              // $00 bytes
//++


bank $0c
//--/////////////////////////////////////////////////////////////////////
// org $aaaf; db $01           // cut out that awful racket after a boss kill
//++


bank $0e
//--/////////////////////////////////////////////////////////////////////
org $c69f; jmp ExitCheck.CS // after score tally, copy & reset fc before cutscene
org $c71d; jmp ExitCheck    // handle frame counts on level exit (not enough room here)
                            // $2e bytes FREE
org $c7b1; ldy #$00         // don't fade out music on stage change (simplest way to deal with level skip messing with music)
org $c85e; jsr DeathFCU     // copy & reset frame count on death
org $c888; jsr Hud_update   // jsr to new Hud_update during death loop
org $cabb; jmp swordKill    // boss kill with sword attack
org $cba7; jmp upBee        // boss kill with up+b attack
// org $cd36; jsr $dc37        // enable level select (or 3 bytes FREE) --free for what?

// status template changes
org $ce5c; db $24,$14,$0a,$10 // SCOR -> FRAM
org $ce66; db $3f,$18,$3f,$00 // 00_STAGE -> _-_0000__
           db $00,$00,$00,$3f,$3f
org $ce97; fill 6, $3f      // erase NINJA
org $cea8; fill 6, $3f      // erase ENEMY

org $d034; jsr Transition   // cut in during level load to refresh status indicators and clear screen pos. display
org $d1b3; jsr ExitCheck.get_block  // this got moved
org $d734; jsr TitleKeys; nop // handle added title screen inputs

// org $d0eb; bvc $d112       // turn off stage music (for a test)
//++


bank $0f
//--/////////////////////////////////////////////////////////////////////
// crude slo-mo test. conclusion: it could work, just not quite like this.
// and would be more effort than it's worth.
// org $e270; game:; org $e2ea; pause:; org $e26e; hop:; bcs pause
// org $e248;  lda $c1; and #2; beq hop; lda $12; sta $13; jmp game


// org $e254; nop #2           // enable pausing during score tally
org $e258; lda #$26         // change suspend sound to sound effect on pause
org $e269; ldx #$00         // change resume sound to no sound
org $e2da; jsr IncFrameC    // hijack jsr $953a to do frame counter stuff
org $e2e0; jsr PauseOpts    // pause option handler
           nop              // $07 bytes FREE
org $e309; jsr Hud_update   // way better, man
org $e31d;                  // unused $12 bytes (in the middle of a jmp table)

org $efbd                   // unused $35 bytes
RyuState:
.S:;        ldx #$03        // $20 bytes used
-;          ldy .offs,x
            lda {bg_collision},y
            sta {bgct},x
            dex
            bpl -
            rts
.R:;        ldx #$03
-;          ldy .offs,x
            lda {bgct},x
            sta {bg_collision},y
            dex
            bpl -
            rts
.offs:; db $00,$60,$78,$a8
Transition:;sta {x_speed_hi}// $0e bytes used
            lda {lvl_width}
            beq +
            lda #$40        // only update screen x on entry
            sta {scfT}      // if loading a scrolling screen
+;          jmp DoMarks

warnpc $eff2+1              // $15 bytes FREE

org $f445                   // unused $43 bytes
ExitCheck:; ldx #$01        // $3c bytes used
            lda {wall_right}
-;          cmp #$09
            beq .CS
            cmp #$07
            beq .Back
            cmp #$06
            beq .Forward
            lda {wall_left}
            dex
            bpl -
// .get_block:;lda {scrn_hi}   // why jump back? just stick this here too.
            // asl #4          // and rewrite to save 2 bytes (but lose a few cycles)
            // sta {current_block}
            // lda {scrn_pix}  // or don't. whatever.
            // lsr #4
            // ora {current_block}
            // sta {current_block}
            // rts
.get_block:;lda {scrn_hi}   // original version
            sta {current_block}
            lda {scrn_pix}
            lsr {current_block}
            ror; lsr {current_block}
            ror; lsr {current_block}
            ror; lsr {current_block}
            ror; sta {current_block}
            rts
.CS:;       jsr LvlExitFCU
            jmp {cs_exit}
.Back:;     jsr LvlExitFCU
            jmp {go_back}
.Forward:;  jsr LvlExitFCU
            jmp {go_forward}

warnpc $f488+1              // $00 bytes


org $fbbb                   // unused $45 bytes
// increment frame count at rate of one frame per game frame
// and check marker if set
IncFrameC:; jsr $953a       // do hijacked routine
            ldy {tally_flag}// $18 bytes used
            bne .done
            lda #$0a
            ldx #$00
-;          inc {fc1},x
            cmp {fc1},x
            bne .MarkCheck
            sty {fc1},x
            inx
            cpx #$04
            bne -
.MarkCheck:;ldx {mark}      // $12 bytes used
            beq .done
            cpx {current_block}
            bne .done
            lda #$80
            sta {pause_flag}
            lda #$55
            sta {sound_buffer}
.done:;     rts

DeathFCU:;  sta {sound_buffer}
            bpl FCUpdate    // $1a bytes used
LvlExitFCU:;jsr RyuState.S  // save bgoll/state/xsub/ysub
FCUpdate:;  ldy #$00
            ldx #$03
-;          lda {fc1},x
            sta {fc2},x
            sty {fc1},x
            dex
            bpl -
            lda #$80
            sta {fc2T}
            rts
            nop

warnpc $fc00+1              // $01 byte FREE


org $ffd1                   // unused $29 bytes
// handle boss refiller
swordKill:; lda #$80        // $25 bytes used
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
            inc {nme_hp}    // sword doesn't remove last bar of health until *after* damage
            jmp {nme_alive_swd}
+;          jmp {nme_alive_upB}
unset:;     asl {swrd}      // swordKill clear
            jmp {Boss_kill}

warnpc $fffa                // $04 bytes FREE
//++


//--// CHR ROM //////////////////////////////////////////////////////////
arch none
org $20000+$10+$410
db $ff,$ff,$ff,$ff,$9c,$80,$9c,$9c,$ff,$e3,$c9,$9c,$ff,$ff,$ff,$ff // A tile $41
db $ff,$ff,$ff,$ff,$81,$9c,$9c,$81,$ff,$81,$9c,$9c,$ff,$ff,$ff,$ff // B
db $ff,$ff,$ff,$ff,$9f,$9f,$c8,$e1,$ff,$e1,$c8,$9f,$ff,$ff,$ff,$ff // C
// db $ff,$ff,$ff,$ff,$9f,$9f,$cc,$e1,$ff,$e1,$cc,$9f,$ff,$ff,$ff,$ff // C, skinny
db $ff,$ff,$ff,$ff,$9c,$9c,$99,$83,$ff,$83,$99,$9c,$ff,$ff,$ff,$ff // D
db $ff,$ff,$ff,$ff,$81,$9f,$9f,$80,$ff,$80,$9f,$9f,$ff,$ff,$ff,$ff // E
db $ff,$ff,$ff,$ff,$81,$9f,$9f,$9f,$ff,$80,$9f,$9f,$ff,$ff,$ff,$ff // F

org $20000+$10+$5f0
db $ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$f7,$f3,$01,$f3,$f7,$ff // arrow
// db $ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$f7,$f3,$01,$f3,$f7,$ff,$ff // arrow, pixel higher
//++
