$0010#soft_ppu_ctrl#
$0011#soft_ppu_mask#
$0012#input_this_frame#
$0013#input_new_buttons#
$0014#input_last_frame#backup
$0015#nmi_flag#b7 set at end of NMI routine
$0016#ppu_trans_flag#b7 set when there's stuff at $3F0 to transmit during next NMI, e.g., status bar updates, palette changes
$0017#chr_bank_R0#
$0018#chr_bank_R1#
$0019#chr_bank_R2#
$001A#chr_bank_R3#
$001B#chr_bank_R4#
$001C#chr_bank_R5#
$001D#prg_bank_R6#
$001E#prg_bank_R7#
$001F#mmc3_irq_latch#
$0020#cs_xscroll_adjustment#
$0021#soft_ppuscroll_x#
$0022#cs_yscroll_adjustment#
$0023#soft_ppuscroll_y#
$0024#last_prg_bank#
$0025#bank_mode_bits#
$0026#sound_A000#which bank is used during sound routine: C or D
$0027#nt_mirroring#(0: vertical; 1: horizontal)
$0028#a_temp_nmi#
$0029#x_temp_nmi#
$002A#y_temp_nmi#
$002B#input_shifter_outer#
$002C#input_first_poll#
$002D#irq_flag#
$002E#cs_flag_&_irq_jmp_offset#
$002F#irq_jmp_ptr_lo#
$0030#irq_jmp_ptr_hi#
$0031#a_temp_irq#
$0032#x_temp_irq#
$0033#y_temp_irq#
$0034#irq_chr_bank_0#
$0035#irq_x_scroll_1#
$0036#irq_x_scroll_2#
$0037#irq_x_scroll_4#
$0038#irq_x_scroll_9#
$0039#cam_pos_fractions#
$003A#cam_pos_pixel#
$003B#cam_pos_screen#
$003D#movement_direction#b7=left
$003E#scroll_flag#b6
$003F#ppu_ctrl_NT_base#bits 0,1 to be OR'd with a value for PPU_CTRL writes
$0040#current_block#
$0041#collision_xdiff#b7 determines damage bounce direction
$0042#wind_timer#
$0046#state_temp#
$0047#facing_temp#
$0048#active_objects_0#b7-4=orbs; b3=spc.wpn symbol; b2-1=shadow clones; b0=Ryu
$0049#active_objects_1#bits 7-3 = enemies 0x0F-0x0B; bits 2-0 = special weapons
$004A#active_objects_2#enemies 0x17-0x10
$004B#shadows_offset#index into shadow clone arrays @ $100,$140,$180
$004C#ryu_blink_flag#1=no flicker (initial Y reg for ryu/clone/weapon blink loop)
$004D#boss_fight_flag#b4, to allow updates of enemy health bar and DEC level on death vs boss
$004E#multi_pointer_lo#C614=object routines; C16F=wind; D809=dpad input; 04:9810=sub-wpn get, and many more
$004F#multi_pointer_hi#
$0050#temp_indirect_ptr_lo#
$0051#temp_indirect_ptr_hi#
$0052#pause_flag#b7
$0053#object_index#
$0054#crouch_y_offset_0#
$0055#crouch_y_offset_1#
$0056#pal_change_flags#
$0057#pal_ptr_offset_0#
$0058#pal_ptr_offset_1#
$0059#pal_ptr_offset_2#
$005A#pal_ptr_offset_3#
$005B#pal_ptr_offset_4#status bar
$005C#palette_change_timer_0#
$005D#palette_change_timer_1#
$005E#palette_change_timer_2#
$005F#palette_change_timer_3#
$0060#palette_change_timer_4#
$0061#palette_index_0#
$0062#palette_index_1#
$0063#palette_index_2#
$0064#palette_index_3#
$0065#palette_index_4#
$0066#wind_cycle#
$0067#carry_temp#
$0068#inv_frames#
$0069#lvldata_0_lo#I am tired of labeling things.
$006A#lvldata_0_hi#
$006B#lvldata_1_lo#
$006C#lvldata_1_hi#
$006D#lvldata_2_lo#
$006E#lvldata_2_hi#
$006F#bgcoll_base_lo#
$0070#bgcoll_base_hi#
$0071#obj_bitfield_index#JSR $9E24
$0072#bitmask_index#JSR $9E24
$0073#oam_write_offset#
$007D#current_sub_weapon#
$007E#current_level#lvl data index 1-1a==0x00; 7-5==0x2F
$007F#lvl_width_in_screens#
$0080#ryuHP#
$0081#enemy_bar#
$0082#tile_x_lo#
$0083#tile_x_hi#16 pixel position for updating nametable address
$0084#metatile_x_lo#
$0085#metatile_x_hi#32 pixel position for updating tile address and background collision data
$0086#tile_ptr_lo#
$0087#tile_ptr_hi#
$0088#nametable_base_lo#
$0089#nametable_base_hi#
$008A#bg_collision_offset#
$008B#bg_collision_write_offset#
$008C#scroll_spd_lo#
$008D#scroll_spd_hi#
$008E#directional_indicator#-1 = left; 0 = right or not moving
$0092#left_scroller_flag#
$0093#bg_pal_0#
$0094#bg_pal_1#
$0095#bg_pal_2#
$0096#bg_pal_3#
$0097#sprite_pal_2#
$0098#sprite_pal_3#
$0099#univ_bg_color_offset#@ 01:BFF0, all black except for 4-1
$009B#stage_numbers#b7=sprites behind BG (for 6-1); b6-3=left digit; b2-0=right digit
$009C#platform#
$009D#wall_right#
$009E#wall_left#
$009F#wall_top#
$00A0#status_updates_index#
$00A1#score0#
$00A2#score1#
$00A3#score2#
$00A4#score3#
$00A5#lives#
$00A6#maxNinpo_tens#
$00A7#maxNinpo_hundos#
$00A8#ninpo_ones#
$00A9#ninpo_tens#
$00AA#ninpo_hundos#
$00AB#timer_ones#
$00AC#timer_tens#
$00AD#timer_hundos#
$00AE#current_ninpo#
$00AF#max_ninpo#
$00B0#timer_frames#
$00B1#timer_seconds#
$00B2#active_temp#
$00B4#room_revisit_flag#
$00B6#level_load_type#
$00B7#orb_spawn_index_R#
$00B8#orb_spawn_index_L#
$00B9#orb_spawn_quantity#
$00BA#orb_spawn_blocks_ptr_lo#
$00BB#orb_spawn_blocks_ptr_hi#
$00BC#orb_contents_and_ypos_ptr_lo#lo nybble=contents, hi nybble=ypos
$00BD#orb_contents_and_ypos_ptr_hi#
$00BE#player_death_flag#and frame count before restart. b7=pit; b6=damage/timer death
$00BF#debug_invuln_flag#b7=enabled, jumps over pit death and enemy collision checks
$00C0#spc_wpn_size#
$00C1#frame_counter#used to split parts of the program to different frames and to jumble the final boss's spew a bit
$00C2#tile_x_offset#($3A AND 0x1F) for object-bg collision
$00C3#enemy_spawn_blocks_ptr_lo#
$00C4#enemy_spawn_blocks_ptr_hi#
$00C5#enemy_spawn_positions_ptr_lo#x and y
$00C6#enemy_spawn_positions_ptr_hi#
$00C7#enemy_spawn_ID_offsets_ptr_lo#
$00C8#enemy_spawn_ID_offsets_ptr_hi#
$00C9#enemy_spawn_quantity#
$00CA#enemy_spawn_list_index#
$00CB#last_cs_played#
$00CC#bg_animation_flags#b7=no animation; b2=alt CHR banks (for 7-1,7-2)
$00CD#bg_animation_period#
$00CE#bg animation timer#
$00CF#bg_animation_index#
$00D0#boss_dead_tally_flag#b7=tally timer; b6=tally ninpo
$00D1#music_track#
$00D2#scroll_get#0x30 after getting scroll from current level, boss kill resets it so dying after killing jaquio1 or jaquio2 allows you to get up to two bonus scrolls for a max maximum of 120 ninpo
$00D3#highest_boss_passed#
$00D8#orb_bits#$D8-$EF reserved, though it will never use more than a few bytes
$00E0#title_fade_count#determines which sound test is used
$00E1#title_fade_timer#
$0100#shdw_xpos_array#
$0140#shdw_ypos_array#
$0180#shdw_states_array#
$01C0#palettes#0x20 bytes
$01E0#metatiles#6 bytes
$0300#collision_tiles_0#
$0378#collision_tiles_1#
$03F0#ppu_trans#size,ppuaddr,ppuaddr,data ...
$0440#enemy_bits#$440-$45F
$0460#animation_id#index into data pointers at $ab70, $ac00
$0478#animation_timer#
$0490#animation_frame#
$04A8#current_action#
$04C0#bg_collision#b7=overlapping wall/just walljumped; b4=platform; b3=L grab; b2=L barrier; b1=R grab; b0=R barrier
$04D8#object_ID#ai pointer index
$04F0#sprite_attr#b7=v-flip; b6=h-flip (face left); b5=priority; b2=don't draw(flicker); b1,b0=palette
$0508#timer#Enemy actions, explosions, power-up time-outs
$050E#score_tally_timer#2 bytes, 61*5
$0520#state#Ryu: b6=in air; b5=walljmp; b4=jump; b3=slow; b2=sword; b1=crouch; b0=spc atk; Enemies: b7=no bgCollision; b6=air; b5=boss; b4=proj.; b1=invulnerable; b0=dead
$0538#x_pos_lo#
$0550#x_pos_hi#
$0551#shadow1_x_pos#
$0552#shadow2_x_pos#
$0568#y_pos_lo#
$0580#y_pos_hi#
$0581#shadow1_y_pos#
$0582#shadow2_y_pos#
$0598#x_speed_lo#
$05B0#x_speed_hi#
$05C8#y_speed_lo#
$05E0#y_speed_hi#
$05F8#health#
$0610#x_rad#
$0628#y_rad#
$0640#multi_purpose#Ryu Ypos @ spawn for bats for later comparison, index to tie projectile back to whatever spawned it, 2nd action timer, etc.
$0658#spawn_number#
$0670#enemy_touch_damage#
$0688#points#
$0700#sound_buffer#sound effect, music track, or command to initiate next nmi
$07E9#sound_suspend_flag#0x2B (pause sound effect) sets, 0x2C unsets
$0009#bgc_tX#
$000A#bgc_t2#
$000B#l_coll_d#
$000C#r_coll_u#
$000D#r_coll_d#
$000E#l_coll_u#
$000F#bgc_temp#
$003C#_unused#
$0074#_unused#
$0075#_unused#
$0076#_unused#
$0077#_unused#
$0078#_unused#
$0079#_unused#
$007A#_unused#
$007B#_unused#
$007C#_unused#
$0090#_unused#
$0091#_unused#
$009A#_unused#
$00B3#_unused#
$00B5#_unused#
$00D4#_unused#
$00D5#_unused#
$00D6#_unused#
$00D7#_unused#
