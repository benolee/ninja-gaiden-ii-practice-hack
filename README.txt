Ninja Gaiden II practice hack
===============================================================================
Pause Options:
Hold B and press...
  R  next lvl  (some odd things may still happen with next/prev)
  L  prev lvl   If you get glitched graphics on 2-1 or 3-3 just reload with B+down
  D  redo lvl & fill health (todo: also reset clock?)
  U  set marker, clear marker if equal (does this feature need more explanation?)
  Se clear marker
Hold A and press...
  R  get scroll (100 cap)
  L  get clone & fill ninpo
  D  boss refill toggle
  U  change weapon & fill ninpo
  Se debug invuln toggle
Hold A and B then press Select:
  force a reload to clear any graphical issues
  (like after loading a state from an unmodified ROM)

To use the the marker feature, get to a point in a scrolling level past the part
 you want to test, pause, set the marker (B+up) then reload the level with B+down.
 Now once you return to that point the game will automatically pause and
 allow you to see the frame count. You can also save state after reloading the
 level to test and compare strategies for whatever short segment you like.
 
Boss refill: this causes boss health to refill when it reaches zero. It was added
 primarily for continuous practice of slashing Jaquio3's belly while dodging shrimp.
===============================================================================


"Perfect score" means the frame count if you could go from the start
 of a level to its exit without stopping or slowing down.
 Obviously, it's more complicated than that in 2-2 and 4-2.
 And the idea becomes particularly absurd in the single screen rooms.

perfect score possible:
1-1c   279 (with clip from 1-1b)
2-1   1982
6-1c  1142 (L+R only, I guess)
6-2    979
7-1e   430 (with Left+A on 1st frame of input followed by Left+B on next frame)

perfect score approachable:
3-1   1993 (TAS gets 1997)
3-2a   441 (TAS gets  442)
4-1c  1133 (TAS gets 1134)
5-1a   435 (TAS gets  440)
5-1c   416 (TAS gets  418)
5-2c  1132 (TAS gets 1136)
7-1a   766 (TAS gets  772)
===============================================================================
full list of TAS frame counts & dubiously derived "perfect scores":
 LVL,       TAS,   HAX,
1-1a,      1674,  1650, 1669 if extra clone is skipped
1-1b,       121,    88,
1-1c,       279,   279,
Dando,      136,  ----,
2-1,       1982,  1982,
2-2a,       871,   827,
2-2b,       986,   940,
2-2c,       278,   253,
B.Spider,    91,  ----,
3-1,       1997,  1993,
3-2a,       442,   441,
3-2b,       464,   409,
3-2c,       466,   428,
3-2d,       476,   409,
3-2e,       317,   194, Even with the huge shortcut, this room is still furthest from this unattainable ideal.
Funky D.,   117,  ----,
4-1a,       996,   969,
4-1b,       194,    88, Ridiculous.
4-1c,      1134,  1133,
4-2a,       772,   753, Nonsense.
4-2b,       455,   360, ''
4-2c,      1143,  1107, ''
N.Sotuva,    96,  ----,
5-1a,       440,   435,
5-1b,       752,   721,
5-1c,       419,   416, (418 with agreeable frame_counter)
5-2a,      1158,  1150,
5-2b,       122,    89,
5-2c,      1136,  1132,
Ashtar,      77,  ----,
6-1a,       620,   601,
6-1b,        88,    67,
6-1c,      1142,  1142,
6-2,        979,   979,
Kelbeross,  284,  ----,
7-1a,       772,   766,
7-1b,       112,    67,
7-1c,       601,   578,
7-1d,        69,    66,
7-1e,       430,   430,
7-2a,       830,   772,
7-2b,        74,    66,
7-2c,       782,   749,
7-2d,       151,    67,
7-2e,       490,   460,
Jaq1,       122,  ----, 116 with 1 AotFW, 110 with 2
Jaq2,       104,  ----,  89 with all attacks to the left, which requires an extra AotFW
Jaq3,       290,  ----,
===============================================================================
Todo:
DONE  implement marker function
DONE  implement marker display
DONE  save xsub/ysub/bgcoll on room change & reload them on B+D (so it's more like loading a state from room entry)
DONE (sort of) boss pause cut-off & reload after boss dead fix
NOTDONE add xpos/xsub display
