$E242#main_loop#
$E248#pause_stuff#
$E270#gameplay#
$E296#object_loop#
$E2CB#not_enemy_or_bgcoll_disabled#
$E2D5#inactive|done#
$E2E0#paused#
$E2E4#disabled_debug_inv#Disabled code was [A5 BF 49 80 85 BF]  (press select while paused to toggle)
$E2ED#not_paused#
$E30F#object_pointers#0x00-0x7F
$E40F#object_pointers#0x80-0xC3
$E497#Windmill_star#0x01
$E4DA#Invincible_fire_wheel_rising#0x02
$E4F9#IFW_running#0x06
$E52C#Item_pickup_timeout#0x03
$E546#Dead_enemy#0x04
$E564#Enemy_explosion#0x05
$E56D#enemy_spawn_IDs#
$E59C#Grunt_spawn#0x10, 0x7E
$E5BF#Grunt_action#0x11
$E5D6#Sprinter_0#0x12
$E5EF#Sprinter_1#0x2E
$E5F9#Sprinter_2#0x13
$E616#Sprinter_3#0x2F
$E623#Sine_bat_spawn#0x14
$E65C#Sine_bat_action#0x15
$E672#Bird_spawn#0x16, 0x7C (large bat)
$E688#Bird_action#0x17
$E6BB#Hop_eye_0#0x18
$E6DE#Hop_eye_1#0x1A
$E70B#Hop_eye_n#0x30
$E713#Hop_eye_2#0x1B
$E729#Hop_eye_3#0x1C
$E739#Hop_eye_4#0x1D
$E754#Hop_eye_5#0x1E
$E762#Bazooka_&_cannon_0#0x1F
$E771#Bazooka_&_cannon_2#0x20
$E780#Bazooka_&_cannon_1#0x21
$E78E#Bazooka_&_cannon_3#0x22
$E7A5#Bazooka_shell#0x23
$E7E9#blob0#0x24 --two kinds of blobs: spitters and flippers, both with left/right facing spawn variants
$E7ED#blob1#0x32
$E80F#blob2#0x25
$E832#blob3#0x26
$E838#blob4#0x27
$E83C#blob5#0x33
$E85E#blob6#0x29
$E864#blob7#0x28
$E887#blob8#0x2A
$E8AF#blob9#0x2B
$E8BE#blobA#0x2C
$E8D6#blobB#0x2D
$E8F8#blobC#0x40
$E920#blobD#0x41
$E92F#blobE#0x42
$E947#blobF#0x43
$E96A#Common_projectile#0x3F
$E973#B_heads_disc#0x3E
$E994#Flame_spawn#0x44
$E9B1#Flame1#0x34
$E9C5#Flame2#0x45
$E9FE#Crawler_spawn#0x46
$EA21#Crawler_action#0x47 includes ground spider, red larvae
$EA31#WallSpider, spawn#0x48
$EA3F#WallSpider, repeat#0x4E
$EA4A#WallSpider, waiting#0x49
$EA5C#WallSpider, shooting#0x4A
$EA7E#WallSpider, drop#0x4B
$EA91#WallSpider, falling, seek ground#0x4C
$EA98#_#this bit probably wouldn't be reachable without the "bullet transfer" bug since all (three) wall spiders spawn over pits
$EAB2#WallSpider, on ground, seek wall/ryu#0x4D
$EABE#Bomberhead clone1#0x35
$EAD6#Bomberhead clone2#0x36
$EAE5#Bomberhead clone3#0x37
$EB0E#Bomberhead clone4#0x38
$EB31#Bomberhead clone5#0x39
$EB53#Rock_chucker_0#0x3A
$EB6B#Rock_chucker_2#0x3B
$EB7A#Rock_chucker_1#0x3C
$EB88#Rock_chucker_3#0x3D
$EBA0#Chucked_rock_0#0x4F
$EBE6#Chucked_rock_1#0x50
$EC14#PumpkinHead, init#0x5B
$EC1D#PumpkinHead, repeat#0x5C
$EC3C#PumpkinHead, walk&wait#0x5D
$EC5B#PumpkinHead, spit loop#0x6F
$EC65#PumpkinHead, spitting#0x70
$EC92#PumpkinHead projectile#0x5E
$ECCC#Malth clone, init#0x5F
$ECF4#Malth, wait#0x60
$ED14#Malth, throw#0x61
$ED39#Malth, delay#0x62
$ED44#Malthballs, init#0x63
$ED7C#Malthballs, moving#0x64
$ED9A#Explode_o_ball_0#0x65
$EDC1#Explode_o_ball_1#0x66 --rising
$EDD5#Explode_o_ball_2#0x67 --falling
$EDE4#Explode_o_ball_3#0x68 --exploding
$EE03#Ball_ejecta#0x69
$EE42#Basaquer clone0#0x6A
$EE55#Basaquer clone4#0x31
$EE65#Basaquer clone1#0x6B
$EE8C#Basaquer clone2#0x6C
$EEAF#Basaquer clone3#0x6D --falling
$EEBC#Basaquer projectile#0x6E
$EEE2#pillbugman0#0x71
$EEF0#pillbugman1#0x72
$EF0F#pillbugman2#0x73
$EF46#pillbugman3#0x74
$EF60#trampoline_ninja_0#0x75
$EF8A#trampoNinja_1#0x76
$EF97#trampoNinja_2#0x77
$EFBD#unused_0x35_bytes#0x79
$EFDD#unused#0x7A
$EFF2#alt sineBat spawn#0x7B
$EFF7#alt bird spawn (bigBat)#0x7C
$EFFC#alt sprinter spawn#0x7D
$F001#alt grunt spawn#0x7E
$F006#alt hopEye spawn a#0x7F
$F00B#alt crawler spawn (red larvae)#0x80
$F010#unused#0x81
$F015#alt hopEye spawn b#0x82
$F01A#alt hopEye spawn c#0x83
$F01F#Dando the Cursed, init#0x78
$F034#Dando the Cursed, repeat#0x87
$F053#Dando the Cursed, creep along#0x84
$F082#Dando the Cursed, rush#0x85
$F0A0#Dando the Cursed, delay#0x86
$F0AB#Dando wall shake#
$F0C9#Baron Spider init#0x88
$F0E8#Baron Spider, repeat#0x8E
$F0F2#Baron Spider, up#0x89
$F108#Baron Spider, flee down#0x93
$F12A#Baron Spider, hopping down#0x8A
$F139#Baron Spider, falling1#0x8B
$F14F#Baron Spider, down#0x90
$F165#Baron Spider, flee up#0x94
$F17E#Baron Spider, falling2#0x91
$F190#Baron Spider, spawn pets#
$F1C2#Baron's spiders init#0x8D
$F1FC#Baron's spiders#0x92 --in air, seek ground
$F20F#Baron's spiders#0x8F --on ground, seek wall
$F240#Funky Dynamite#0x95
$F259#Funky Dynamite, ascend#0xC3
$F275#Funky Dynamite, rising#0x96
$F29C#Funky Dynamite, prepare to shoot#0x99
$F2A7#Funky Dynamite, fly and shoot#0x97
$F303#Funky Dynamite, drop#0x98
$F326#Funky Dynamite, crouch&wait#0x9B
$F33E#Funky Dynamite, launcher#
$F35D#Funkyshot#0x9A
$F39C#Naga Sotuva, init#0xA2
$F3CA#Naga Sotuva#0x57
$F3DF#Naga Sotuva, spawn hand#0x58
$F42A#Naga Sotuva, hands in#0x59
$F43D#Naga Sotuva, hands out#0x5A
$F445#unused_0x43_bytes#0xAB --wacky ryu-launching effect
$F476#unused#0xAC
$F488#Ashtar, init#0x9D
$F49E#Ashtar, repeat#0xA3
$F4AD#Ashtar, delay1#0x9E
$F4C1#Ashtar, delay2#0x9F
$F4D7#Ashtar, delay3#0xA0
$F4EA#Ashtar, phase in#0xA1
$F50B#Ashtar, teleport&fire#
$F53C#Ashtar's fireballs#0xA4
$F58D#afb_xpos_offsets#
$F595#afb_ypos_offsets#
$F59D#afb_xspdlo_offsets#
$F5A5#afb_xspdhi_offsets#
$F5AD#afb_yspdlo_offsets#
$F5B5#afb_yspdhi_offsets#
$F5BD#Kelbeross, init#0xA5
$F613#Kelbeross, slumber#0x51
$F630#Kelbeross, awake#0x52
$F670#Kelbeross, delay#0x53
$F67B#Kelbeross, spitting#0x54
$F699#Kelbeross, hop#0x55
$F6B3#Kelberspittle#0x56
$F6F1#Jaquio I, init#0xA7
$F710#Jaquio I, repeat#0xA8
$F71F#Jaquio I, shot delay#0xA9
$F73B#Jaquio I, flame on#0xAA
$F766#Jaquio I, move#
$F78B#Wind_particles_spawn#0xAD
$F799#Wind_particles_reset#0xAE
$F7B5#Wind_particles_blow#0xAF
$F7C8#wind_speeds#
$F7D9#wind_positions#
$F7EA#Jaquio II, init#0xB0
$F81D#Jaquio II, dostuff#0xB2
$F84B#Jaquio II, ceiling drips init#0xB5
$F87C#drip x positions#
$F884#drip y positions#
$F88C#Ceiling drips, wait and drip#0xB6
$F8AE#Jaquio II, spit#0xB4
$F8EA#Jaquio III, init#0xB1
$F952#j3_sprtid#
$F954#j3_xpos#
$F956#j3_ypos#
$F958#j3_objid#
$F95A#Jaquio III, head#0x8C
$F976#Jaquio III, head, spit#0xBA
$F9B2#Jaquio III, head dead#0xB3 --clear head & hands, spawn core
$FA11#Jaquio III, core delay#0xBF
$FA28#Jaquio III, spew delay#0xC0
$FA3E#Jaquio III, spew#0xC1
$FA6B#Jaquio III, spew spawn#0xC2
$FAA7#Jaquio III, upper hand, init#0xB7
$FABC#Jaquio III, upper hand, advance#0xBB
$FAD6#Jaquio III, upper hand, retreat#0xBE activate lower hand when done
$FAE9#Jaquio III, lower hand, init#0xB8
$FAFE#Jaquio III, lower hand, advance#0xBC
$FB18#Jaquio III, lower hand, retreat#0xBD activate upper hand when done
$FB2B#Jaquio III, spitballs#0xB9
$FB61#rts#unused 0x9C, 0xA6 would jump here
$FB62#reset#
$FBBB#unused_0x45_bytes#
$FC00#PCMdata#
$FFD1#unused_0x29_bytes#
